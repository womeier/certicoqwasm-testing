#!/usr/bin/env python3
"""Compare two folders of CertiRocq-Wasm binaries: size, node runtime, wasmtime
(AOT) compile time and runtime. Emits GitHub-flavoured markdown.

The two sides are measured *interleaved*, run by run, so machine drift is
common-mode rather than landing entirely on one side -- which is what
evaluation/benchmark.py gets wrong (it also rounds times to whole milliseconds
and aborts the whole run on the first failing program).

Usage
-----
    ./compare.py FOLDER_A FOLDER_B [-n RUNS] [--engine node] [--program vs_hard]

    ./compare.py binaries/nixpkgs-0.9.1+9.1-oct-21-26 ../result \\
        -n 20 --null -o report.md

Needs `node` and the `wasmtime` Python module on PATH (both are in the devShell).
"""

from __future__ import annotations

import click
import json
import math
import os
import platform
import random
import re
import shutil
import statistics
import subprocess
import sys
import tempfile
import threading
import time
from dataclasses import dataclass, field
from pathlib import Path
from types import SimpleNamespace

PREFIX = "CertiRocq.Tests.wasm.tests."

# A big stack for *every* program, on both engines, on both sides. The three
# sm_gauss_* need it (they recurse linearly from 2253b4e8 on, once the tail calls
# are gone), and giving it to all of them costs nothing measurable -- the flags
# only move a limit, they do not commit memory -- while keeping one engine Config,
# one .cwasm fingerprint and one execution path for all programs, so programs stay
# comparable to each other and not just within an A/B pair.
#
# The price is that a stack overflow no longer reports itself: at the default
# stack a program that lost its tail calls says "RangeError: Maximum call stack
# size exceeded", which is a finding. Runtime and memory still show it.
#
# Caveat: node's --stack-size only moves V8's limit, it does not grow the OS
# thread stack, so on a host with a small `ulimit -s` a real overflow segfaults
# instead of raising. wasmtime is safe either way -- we size the host thread
# ourselves below.
BIG_STACK_KB = 200000                     # node --stack-size, in KB
BIG_STACK_BYTES = BIG_STACK_KB * 1024     # wasmtime max_wasm_stack, same budget
# wasmtime executes wasm on the calling thread's stack, so the host stack has to
# exceed max_wasm_stack or an overflow segfaults the process instead of trapping.
HOST_STACK_SLACK = 32 * 1024 * 1024

# ---------------------------------------------------------------- node runner

NODE_RUNNER = r"""
// Minimal high-resolution runner: instantiate, call main_function, print one
// JSON line. No pretty-printing -- the raw result word already detects a
// changed answer, and printing would pollute the measured region.
import * as fs from 'fs';

const [path, program] = process.argv.slice(2);
const importObject = { env: { write_char: () => {}, write_int: () => {} } };

(async () => {
  try {
    const bytes = fs.readFileSync(path);
    const t0 = performance.now();
    const obj = await WebAssembly.instantiate(new Uint8Array(bytes), importObject);
    const t1 = performance.now();
    const e = obj.instance.exports;

    const t2 = performance.now();
    e.main_function();
    const t3 = performance.now();

    // export renames across revisions: result_out_of_mem -> out_of_mem,
    // bytes_used -> mem_ptr
    const oom = e.result_out_of_mem !== undefined ? e.result_out_of_mem : e.out_of_mem;
    const bu = e.bytes_used !== undefined ? e.bytes_used : e.mem_ptr;

    console.log(JSON.stringify({
      ok: true,
      startup_ms: t1 - t0,
      main_ms: t3 - t2,
      result: e.result === undefined ? null : String(e.result.value),
      bytes_used: bu === undefined ? null : Number(bu.value),
      out_of_mem: oom === undefined ? null : Number(oom.value),
    }));
  } catch (err) {
    console.log(JSON.stringify({ ok: false, error: String(err).split('\n')[0] }));
  }
})();
"""


def run_node(runner: Path, wasm: Path, program: str, node: str) -> dict:
    cmd = [node, f"--stack-size={BIG_STACK_KB}",
           str(runner), str(wasm), program]
    p = subprocess.run(cmd, capture_output=True, text=True, timeout=600)
    line = next((l for l in p.stdout.splitlines() if l.startswith("{")), None)
    if line is None:
        err = (p.stderr or p.stdout or "no output").strip().splitlines()
        return {"ok": False, "error": err[-1][:200] if err else "no output"}
    return json.loads(line)


# ------------------------------------------------------------ wasmtime runner
# Runs in a fresh subprocess (`--worker-wasmtime`) so every measurement pays a
# cold engine, exactly like the node side.

def wasmtime_config():
    """The Config for both compiling and running. wasmtime fingerprints the
    compilation settings into the .cwasm and refuses a mismatch, so the two must
    be built the same way."""
    from wasmtime import Config

    config = Config()
    config.wasm_tail_call = True
    # wasmtime rejects max_wasm_stack > async_stack_size (2 MiB by default) even
    # for sync execution, and wasmtime-py binds no setter for it -- so reach for
    # the C function the package already loads. Getting this wrong aborts the
    # process from Rust rather than raising, hence the explicit check.
    import wasmtime._ffi as ffi

    setter = getattr(ffi.dll, "wasmtime_config_async_stack_size_set", None)
    if setter is None:
        raise RuntimeError(
            "this wasmtime-py exposes no async_stack_size setter, so max_wasm_stack "
            "cannot be raised above 2 MiB; rerun with --engine node")
    setter(config.ptr(), BIG_STACK_BYTES + HOST_STACK_SLACK)
    config.max_wasm_stack = BIG_STACK_BYTES
    return config


def _wasmtime_measure(cwasm: str) -> dict:
    from wasmtime import Engine, Instance, Module, Store

    store = Store(Engine(wasmtime_config()))
    try:
        t0 = time.perf_counter()
        module = Module.deserialize_file(store.engine, cwasm)
        instance = Instance(store, module, [])
        t1 = time.perf_counter()

        exports = instance.exports(store)
        t2 = time.perf_counter()
        exports["main_function"](store)
        t3 = time.perf_counter()

        def g(*names):
            for n in names:
                if n in exports:
                    return exports[n].value(store)
            return None

        return {
            "ok": True,
            "startup_ms": (t1 - t0) * 1000.0,
            "main_ms": (t3 - t2) * 1000.0,
            "result": None if g("result") is None else str(g("result")),
            "bytes_used": g("bytes_used", "mem_ptr"),
            "out_of_mem": g("result_out_of_mem", "out_of_mem"),
        }
    except Exception as exc:  # a trap is a result, not a crash of the harness
        return {"ok": False, "error": f"{type(exc).__name__}: {exc}".split(chr(10))[0][:200]}


def worker_wasmtime(cwasm: str) -> int:
    # max_wasm_stack is only a limit: the stack itself is the host thread's, so the
    # run has to happen on a thread we sized ourselves.
    threading.stack_size(BIG_STACK_BYTES + HOST_STACK_SLACK)
    box: dict = {}
    t = threading.Thread(target=lambda: box.update(_wasmtime_measure(cwasm)))
    t.start()
    t.join()
    out = box or {"ok": False, "error": "worker thread produced no result"}
    print(json.dumps(out))
    return 0


def run_wasmtime(cwasm: Path) -> dict:
    p = subprocess.run([sys.executable, os.path.abspath(__file__), "--worker-wasmtime",
                        str(cwasm)],
                       capture_output=True, text=True, timeout=600)
    line = next((l for l in p.stdout.splitlines() if l.startswith("{")), None)
    if line is None:
        err = (p.stderr or p.stdout or "").strip().splitlines()
        if p.returncode < 0:
            return {"ok": False,
                    "error": f"worker killed by signal {-p.returncode} (host stack too small?)"}
        return {"ok": False, "error": err[-1][:200] if err else "no output"}
    return json.loads(line)


def aot_compile(wasm: Path, out: Path) -> tuple[float | None, str | None]:
    """Serialize `wasm` to a .cwasm, returning (compile_ms, error)."""
    from wasmtime import Engine, Module

    engine = Engine(wasmtime_config())
    try:
        t0 = time.perf_counter()
        blob = Module(engine, wasm.read_bytes()).serialize()
        dt = (time.perf_counter() - t0) * 1000.0
        out.write_bytes(blob)
        return dt, None
    except Exception as exc:
        return None, f"{type(exc).__name__}: {exc}"[:200]


# ------------------------------------------------------------- value check
# The `result` global is a *pointer* into linear memory, so it is not comparable
# across revisions whose heap layout differs -- a pure layout shift makes two
# identical answers look different. The decidable check is the pretty-printed
# value, so we call the repo's own runner once per program per side and reuse its
# pp maps rather than duplicating them here.

def printed_value(folder: Path, program: str, node: str) -> tuple[str | None, str | None]:
    """Returns (printed value, error)."""
    evaldir = Path(__file__).resolve().parent
    runner = evaldir / "run-node.js"
    if not runner.is_file():
        return None, f"{runner} not found"
    cmd = [node]
    cmd.append(f"--stack-size={BIG_STACK_KB}")
    cmd += [str(runner), str(folder.resolve()) + "/", program]
    try:
        p = subprocess.run(cmd, capture_output=True, text=True, timeout=900, cwd=evaldir)
    except subprocess.TimeoutExpired:
        return None, "timeout"
    m = re.search(r"====> (.*?)(?:\nBenchmark|$)", p.stdout, re.S)
    if m:
        return " ".join(m.group(1).split()), None
    lines = [l.strip() for l in (p.stdout + p.stderr).splitlines() if l.strip()]
    # prefer the line naming the failure over a stack frame
    best = next((l for l in lines if re.search(r"(Error|Trap|trap|out of memory|Exception)", l)), None)
    return None, (best or (lines[-1] if lines else "no output"))[:160]


# -------------------------------------------------------------------- stats

def median(xs):
    return statistics.median(xs) if xs else float("nan")


def boot_ratio_ci(a: list[float], b: list[float], iters: int = 10000, seed: int = 0):
    """Percentile CI for median(b)/median(a), resampling rounds *paired* so the
    interleaving is respected."""
    n = min(len(a), len(b))
    if n < 3:
        return None
    rng = random.Random(seed)
    a, b = a[:n], b[:n]
    out = []
    for _ in range(iters):
        idx = [rng.randrange(n) for _ in range(n)]
        ma = statistics.median([a[i] for i in idx])
        mb = statistics.median([b[i] for i in idx])
        if ma > 0:
            out.append(mb / ma)
    if not out:
        return None
    out.sort()
    return out[int(0.025 * len(out))], out[int(0.975 * len(out))]


def pct(ratio: float) -> str:
    return f"{(ratio - 1.0) * 100:+.1f}%"


def geomean(xs: list[float]) -> float:
    xs = [x for x in xs if x and x > 0 and math.isfinite(x)]
    return math.exp(sum(map(math.log, xs)) / len(xs)) if xs else float("nan")


# -------------------------------------------------------------------- model

@dataclass
class Variant:
    label: str
    folder: Path
    wasm: dict[str, Path] = field(default_factory=dict)
    cwasm: dict[str, Path] = field(default_factory=dict)
    compile_ms: dict[str, float] = field(default_factory=dict)
    times: dict[tuple[str, str], list[float]] = field(default_factory=dict)  # (engine, prog) -> mains
    startup: dict[tuple[str, str], list[float]] = field(default_factory=dict)
    facts: dict[tuple[str, str], dict] = field(default_factory=dict)  # result/bytes_used/oom
    errors: dict[tuple[str, str], str] = field(default_factory=dict)
    values: dict[str, str] = field(default_factory=dict)       # program -> printed value
    value_errors: dict[str, str] = field(default_factory=dict)


def discover(folder: Path) -> dict[str, Path]:
    out = {}
    for f in sorted(folder.glob("*.wasm")):
        name = f.name
        name = name[len(PREFIX):] if name.startswith(PREFIX) else name
        name = re.sub(r"^CertiRocq\.\w+\.wasm\.tests\.", "", name)
        out[name[:-5]] = f
    return out


@click.command(context_settings={"help_option_names": ["-h", "--help"]})
@click.argument("folder_a", type=click.Path(exists=True, file_okay=False, path_type=Path))
@click.argument("folder_b", type=click.Path(exists=True, file_okay=False, path_type=Path))
@click.option("--runs", "-n", type=int, help="Rounds per program.", default=15, show_default=True)
@click.option("--engine", type=click.Choice(["node", "wasmtime"]), multiple=True,
              help="Engine to measure, repeatable.  [default: both]")
@click.option("--program", type=str, multiple=True,
              help="Restrict to this program, repeatable.  [default: all shared]")
@click.option("--node", type=str, help="node executable.", default="node", show_default=True)
@click.option("--null", is_flag=True, default=False,
              help="Add an A-vs-A' arm from a second copy of A: measures this machine's "
                   "noise floor during the same run.")
@click.option("--json", "json_out", type=click.Path(dir_okay=False, path_type=Path),
              help="Also write the raw measurements here.")
@click.option("--output", "-o", type=click.Path(dir_okay=False, path_type=Path),
              help="Write markdown here instead of stdout.")
def main(folder_a, folder_b, runs, engine, program, node,
         null, json_out, output) -> None:
    """Compare two folders of CertiRocq-Wasm binaries and print markdown.

    Measures the two sides interleaved, run by run, so machine drift is
    common-mode rather than landing on one side.
    """
    opts = SimpleNamespace(runs=runs, node=node, null=null, json_out=json_out,
                           output=output,
                           folder_a=folder_a, folder_b=folder_b,
                           programs=program)

    engines = list(engine) or ["node", "wasmtime"]

    variants = [
        Variant(opts.folder_a.resolve().name, opts.folder_a),
        Variant(opts.folder_b.resolve().name, opts.folder_b),
    ]
    tmp = Path(tempfile.mkdtemp(prefix="compare-"))
    if opts.null:
        # a byte-identical copy of A, measured as a third arm
        nulldir = tmp / "null-copy"
        nulldir.mkdir()
        for f in opts.folder_a.glob("*.wasm"):
            shutil.copy2(f, nulldir / f.name)
        variants.append(Variant(variants[0].label + "'", nulldir))

    for v in variants:
        v.wasm = discover(v.folder)

    common = sorted(set(variants[0].wasm) & set(variants[1].wasm))
    only_a = sorted(set(variants[0].wasm) - set(variants[1].wasm))
    only_b = sorted(set(variants[1].wasm) - set(variants[0].wasm))
    if opts.programs:
        want = set(opts.programs)
        unknown = want - set(common)
        if unknown:
            raise click.UsageError(f"not in both folders: {', '.join(sorted(unknown))}")
        common = [p for p in common if p in want]
    if not common:
        raise click.UsageError("no programs in common between the two folders")

    # ---- AOT compile (also a metric: wasmtime compile time and .cwasm size)
    if "wasmtime" in engines:
        for v in variants:
            d = tmp / f"cwasm-{v.label.replace('/', '_')}"
            d.mkdir(parents=True, exist_ok=True)
            for prog in common:
                out = d / f"{prog}.cwasm"
                ms, err = aot_compile(v.wasm[prog], out)
                if err:
                    v.errors[("wasmtime", prog)] = f"AOT compile failed: {err}"
                else:
                    v.cwasm[prog] = out
                    v.compile_ms[prog] = ms
                print(f"  compiled {v.label}/{prog}", file=sys.stderr)

    # ---- decidable answer check (outside the measured region)
    for v in variants[:2]:
        for prog in common:
            val, err = printed_value(v.folder, prog, opts.node)
            if err:
                v.value_errors[prog] = err
            else:
                v.values[prog] = val
            print(f"  value {v.label}/{prog}: {val if val is not None else err}", file=sys.stderr)

    # ---- interleaved timing
    runner = tmp / "run-hires.mjs"
    runner.write_text(NODE_RUNNER)

    for engine in engines:
        for prog in common:
            for rnd in range(opts.runs):
                # alternate the within-round order so neither side always runs first
                order = list(range(len(variants)))
                if rnd % 2:
                    order.reverse()
                for i in order:
                    v = variants[i]
                    key = (engine, prog)
                    if key in v.errors:
                        continue
                    if engine == "node":
                        r = run_node(runner, v.wasm[prog], prog, opts.node)
                    else:
                        if prog not in v.cwasm:
                            continue
                        r = run_wasmtime(v.cwasm[prog])
                    if not r.get("ok"):
                        v.errors[key] = r.get("error", "unknown failure")
                        continue
                    v.times.setdefault(key, []).append(r["main_ms"])
                    v.startup.setdefault(key, []).append(r["startup_ms"])
                    v.facts[key] = {k: r.get(k) for k in ("result", "bytes_used", "out_of_mem")}
                print(f"  {engine} {prog} round {rnd + 1}/{opts.runs}", file=sys.stderr)

    md = render(variants, common, only_a, only_b, engines, opts)
    if opts.output:
        opts.output.write_text(md)
        print(f"wrote {opts.output}", file=sys.stderr)
    else:
        sys.stdout.write(md)

    if opts.json_out:
        opts.json_out.write_text(json.dumps({
            v.label: {
                "folder": str(v.folder),
                "sizes": {p: v.wasm[p].stat().st_size for p in common},
                "cwasm_sizes": {p: v.cwasm[p].stat().st_size for p in v.cwasm},
                "compile_ms": v.compile_ms,
                "times": {f"{e}/{p}": t for (e, p), t in v.times.items()},
                "startup": {f"{e}/{p}": t for (e, p), t in v.startup.items()},
                "facts": {f"{e}/{p}": f for (e, p), f in v.facts.items()},
                "errors": {f"{e}/{p}": m for (e, p), m in v.errors.items()},
                "values": v.values,
                "value_errors": v.value_errors,
            } for v in variants
        }, indent=1))
    shutil.rmtree(tmp, ignore_errors=True)


# ------------------------------------------------------------------- render

def render(variants, common, only_a, only_b, engines, opts) -> str:
    a, b = variants[0], variants[1]
    nullv = variants[2] if len(variants) > 2 else None
    L = []
    w = L.append

    w(f"## `{a.label}` vs `{b.label}`")
    w("")
    w(f"| | folder | programs |")
    w(f"|---|---|---|")
    w(f"| A | `{a.folder}` | {len(a.wasm)} |")
    w(f"| B | `{b.folder}` | {len(b.wasm)} |")
    w("")
    if only_a or only_b:
        w(f"> **Asymmetric folders.** Only in A: {', '.join(f'`{p}`' for p in only_a) or '--'}. "
          f"Only in B: {', '.join(f'`{p}`' for p in only_b) or '--'}. "
          f"Compared the {len(common)} programs they share.")
        w("")

    # ---- size
    w("### Size")
    w("")
    head = "| program | A `.wasm` | B `.wasm` | Δ |"
    sep = "|---|---:|---:|---:|"
    if "wasmtime" in engines:
        head += " A `.cwasm` | B `.cwasm` | Δ |"
        sep += "---:|---:|---:|"
    w(head)
    w(sep)
    ratios, cratios = [], []
    for p in common:
        sa, sb = a.wasm[p].stat().st_size, b.wasm[p].stat().st_size
        r = sb / sa if sa else float("nan")
        ratios.append(r)
        row = f"| `{p}` | {sa / 1024:,.0f} KB | {sb / 1024:,.0f} KB | {pct(r)} |"
        if "wasmtime" in engines:
            if p in a.cwasm and p in b.cwasm:
                ca, cb = a.cwasm[p].stat().st_size, b.cwasm[p].stat().st_size
                cr = cb / ca if ca else float("nan")
                cratios.append(cr)
                row += f" {ca / 1024:,.0f} KB | {cb / 1024:,.0f} KB | {pct(cr)} |"
            else:
                row += " -- | -- | -- |"
        w(row)
    tot = f"| **geomean** | | | **{pct(geomean(ratios))}** |"
    if "wasmtime" in engines:
        tot += f" | | **{pct(geomean(cratios))}** |" if cratios else " | | -- |"
    w(tot)
    w("")

    def bytes_used(v, prog):
        for engine in engines:
            f = v.facts.get((engine, prog))
            if f and f.get("bytes_used") is not None:
                return f["bytes_used"]
        return None

    # ---- memory
    if any(bytes_used(v, p_) is not None for v in (a, b) for p_ in common):
        w("### Memory")
        w("")
        w("Heap high-water mark at the end of `main_function` (the `bytes_used` / "
          "`mem_ptr` global), in bytes. Independent of engine.")
        w("")
        w("| program | A | B | Δ |")
        w("|---|---:|---:|---:|")
        mratios = []
        for p_ in common:
            ba, bb = bytes_used(a, p_), bytes_used(b, p_)
            if ba is None or bb is None:
                missing = [t for t, x in (("A", ba), ("B", bb)) if x is None]
                w(f"| `{p_}` | {'--' if ba is None else f'{ba:,}'} | "
                  f"{'--' if bb is None else f'{bb:,}'} | no data ({', '.join(missing)}) |")
                continue
            r = bb / ba if ba else float("nan")
            mratios.append(r)
            w(f"| `{p_}` | {ba:,} | {bb:,} | {pct(r) if ba != bb else '--'} |")
        w(f"| **geomean** | | | **{pct(geomean(mratios))}** |")
        w("")

    # ---- timing, per engine
    for engine in engines:
        w(f"### Runtime -- {engine}" + (" (AOT `.cwasm`)" if engine == "wasmtime" else ""))
        w("")
        w(f"Median of {opts.runs} interleaved rounds, `main_function` only, in ms. "
          f"CI is a 95% paired bootstrap on the median ratio; **bold** = CI excludes 0%.")
        w("")
        extra = " compile |" if engine == "wasmtime" else ""
        extrasep = "---:|" if engine == "wasmtime" else ""
        w(f"| program | A | B | Δ | 95% CI |{extra}")
        w(f"|---|---:|---:|---:|---|{extrasep}")
        ratios = []
        for p in common:
            key = (engine, p)
            ta, tb = a.times.get(key, []), b.times.get(key, [])
            if not ta or not tb:
                fails = [f"{tag}: {v.errors[key]}" for v, tag in ((a, "A"), (b, "B")) if key in v.errors]
                cells = [f"{median(t):.2f}" if t else "--" for t in (ta, tb)]
                w(f"| `{p}` | {cells[0]} | {cells[1]} | -- | "
                  f"{'; '.join(fails) or 'no data'} |" + (" -- |" if engine == "wasmtime" else ""))
                continue
            ma, mb = median(ta), median(tb)
            r = mb / ma if ma else float("nan")
            ratios.append(r)
            ci = boot_ratio_ci(ta, tb)
            if ci:
                sig = ci[0] > 1.0 or ci[1] < 1.0
                cis = f"{pct(ci[0])} .. {pct(ci[1])}"
            else:
                sig, cis = False, "--"
            d = f"**{pct(r)}**" if sig else pct(r)
            row = f"| `{p}` | {ma:.2f} | {mb:.2f} | {d} | {cis} |"
            if engine == "wasmtime":
                ca, cb = a.compile_ms.get(p), b.compile_ms.get(p)
                row += f" {ca:.0f} -> {cb:.0f} ms |" if ca and cb else " -- |"
            w(row)
        w(f"| **geomean** | | | **{pct(geomean(ratios))}** | |" + (" |" if engine == "wasmtime" else ""))
        w("")

        if nullv:
            w(f"<details><summary>Null arm (A vs A', same bytes) -- this run's noise floor</summary>")
            w("")
            w("| program | A | A' | Δ | 95% CI |")
            w("|---|---:|---:|---:|---|")
            worst = 0.0
            for p in common:
                key = (engine, p)
                ta, tn = a.times.get(key, []), nullv.times.get(key, [])
                if not ta or not tn:
                    continue
                ma, mn = median(ta), median(tn)
                r = mn / ma if ma else float("nan")
                ci = boot_ratio_ci(ta, tn)
                if ci:
                    worst = max(worst, abs(ci[0] - 1), abs(ci[1] - 1))
                    cis, sig = f"{pct(ci[0])} .. {pct(ci[1])}", (ci[0] > 1.0 or ci[1] < 1.0)
                else:
                    cis, sig = "--", False
                w(f"| `{p}` | {ma:.2f} | {mn:.2f} | {'**' + pct(r) + '**' if sig else pct(r)} | {cis} |")
            w("")
            w(f"Widest null CI bound: **±{worst * 100:.1f}%**. Treat A-vs-B effects "
              f"smaller than that as unresolved on this machine.")
            w("")
            w("</details>")
            w("")

    # ---- correctness
    w("### Correctness")
    w("")
    w("Pretty-printed answers. The `result` global itself is a *pointer* into linear "
      "memory, so it is expected to move between revisions and is not compared.")
    w("")
    w("| program | answer | notes |")
    w("|---|---|---|")
    for p_ in common:
        notes = []
        for v, tag in ((a, "A"), (b, "B")):
            for engine in engines:
                if (engine, p_) in v.errors:
                    notes.append(f"{tag}/{engine}: {v.errors[(engine, p_)]}")

        va, vb = a.values.get(p_), b.values.get(p_)
        if va is not None and vb is not None:
            if va == vb:
                ans = f"`{va}`" if len(va) <= 42 else f"`{va[:39]}...`"
            else:
                ans = f"**differs**: `{va[:28]}` -> `{vb[:28]}`"
                notes.insert(0, "**answer differs**")
        else:
            ans = "--"
            for v, tag in ((a, "A"), (b, "B")):
                # the engine rows above usually carry the same message already
                msg = v.value_errors.get(p_)
                if msg and not any(msg in n for n in notes):
                    notes.append(f"{tag}: {msg}")

        if any((v.facts.get((e, p_)) or {}).get("out_of_mem") for v in (a, b) for e in engines):
            notes.append("**out of memory**")
        w(f"| `{p_}` | {ans} | {'; '.join(notes) or 'ok'} |")
    w("")

    # ---- provenance
    w("<details><summary>How this was measured</summary>")
    w("")
    w(f"- `{Path(__file__).name} {' '.join(sys.argv[1:])}`")
    w(f"- {opts.runs} rounds per program; within each round every variant runs "
      f"back-to-back, and the order flips every round, so drift and ordering are common-mode.")
    w("- A fresh process per measurement (cold engine on both sides).")
    w("- `performance.now()` / `time.perf_counter()`; no pretty-printing inside the measured region.")
    w("- answers are checked separately, via `run-node.js` (reusing its pp maps), "
      "once per program per side.")
    if "wasmtime" in engines:
        w("- wasmtime runs AOT: each `.wasm` is serialized to a `.cwasm` with "
          "`wasm_tail_call = True`, then `deserialize_file`d per run.")
        w(f"- `max_wasm_stack` = {BIG_STACK_BYTES // 1024 // 1024} MB for every "
          f"program, on a thread with a correspondingly larger host stack.")
    if "node" in engines:
        w(f"- `--stack-size={BIG_STACK_KB}` for every program (both sides): the "
          f"deeply-recursive ones need it, and it is free for the rest.")
    w(f"- host: {platform.platform()}, {os.cpu_count()} cpus")
    for tool, cmd in (("node", [opts.node, "--version"]),):
        if "node" in engines and shutil.which(cmd[0]):
            try:
                w(f"- {tool}: {subprocess.run(cmd, capture_output=True, text=True).stdout.strip()}")
            except Exception:
                pass
    if "wasmtime" in engines:
        try:
            from importlib.metadata import version as _v
            w(f"- wasmtime-py: {_v('wasmtime')}")
        except Exception:
            pass
    w(f"- {time.strftime('%Y-%m-%d %H:%M:%S %Z')}")
    w("")
    w("</details>")
    w("")
    return "\n".join(L)


if __name__ == "__main__":
    if len(sys.argv) >= 3 and sys.argv[1] == "--worker-wasmtime":
        sys.exit(worker_wasmtime(sys.argv[2]))
    main()
