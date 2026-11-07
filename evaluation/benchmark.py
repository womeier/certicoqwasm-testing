#!/usr/bin/env python3

import os
import click
import subprocess
import json
from tqdm import tqdm
from importlib.metadata import version as package_version
import time
import pathlib
from wasmtime import Config, Engine, Module
import sys

CWD = os.path.abspath(os.path.dirname(__file__))
os.chdir(CWD)

# NODE = "/usr/bin/node"
NODE = "node"
measurements = ["time_startup", "time_main", "time_pp", "bytes_used"]

programs = [
    "demo1",
    "demo2",
    "list_sum",
    "vs_easy",
    "vs_hard",
    "binom",
    "color",
    "sha_fast",
    "even_10000",
    "ack_3_9",
    "sm_gauss_nat",
    "sm_gauss_N",
#    "sm_gauss_PrimInt", # comment in for non-cps-primops-may-21-24 and later
#    "coqprime", # comment in for wasmgc, and non-cps-grow-mem-less-often-august-30-24 or later
]

benchmarks_info = {
    "cps-feb-01-24": "CPS, inserted tailcalls, naive 0ary (CoqPL)",
    "cps-0aryfast-feb-13-24": "CPS, inserted tailcalls (no return instrs)",
    "non-cps-feb-07-24": "non-CPS, (tailcalls, no return instrs) naive 0ary",
    "non-cps-0aryfast-return-feb-26-24": "non-cps, with return instr, 0ary",
    "non-cps-ifs-unnested-mrch-22-24": "non-cps (same as feb-26-24, update MC), don't nest if statements",
    "non-cps-grow-mem-func-mrch-24-24": "non-cps (same as mrch-22-24), grow_mem in separate function",
    "non-cps-br_if-apr-12-24": "non-cps (same as mrch-24-24), br_if instead of if return",
    "non-cps-wasmgc-may-16-24": "WasmGC demo (unverified), based on apr-12-24",
    "non-cps-primops-may-21-24": "new constr. repr. + primops, based on apr-12-24",
    "non-cps-no-imports-june-15-24": "removed imports, otherwise may-21-24", # this will be removed in the future

    "non-cps-grow-mem-less-often-august-30-24": "track available mem statically, only grow when necessary",
    # also bool constructors swapped https://github.com/CertiCoq/certicoq/pull/100
    "non-cps-cleanup-oct-13-24": "renamed globals, cleanup",
}


def get_info(path):
    if path[-1] == "/":
        path = path[:-1]
    if path[0:2] == "./":
        path = path[2:]

    # folders staged by stage-binaries.py describe themselves
    info_file = os.path.join(path, "INFO.txt")
    if os.path.exists(info_file):
        with open(info_file) as f:
            for line in f:
                if line.startswith("description:"):
                    return line.split(":", 1)[1].strip()

    try:
        info = benchmarks_info[path.replace("binaries/", "")]
    except KeyError:
        print("Running new binaries. Did you run MAKE INSTALL?\n")
        time.sleep(1)
        info = path

    return info


def get_engine_version(engine):
    if engine == "node":
        r = subprocess.run([NODE, "--version"], capture_output=True, check=True)
        return f"Node.js ({r.stdout.decode('ascii').strip()})"
    return f"wasmtime-py ({package_version('wasmtime')})"


def program_opt_name(program, flags):
    flags = [f.replace("-", "") for f in flags]
    return f"{program}-opt_{'-'.join(flags)}"


def create_optimized_programs(folder, flags):
    print(f"Creating programs optimized with wasm-opt {' '.join(flags)} in {folder}.")
    for program in tqdm(programs):
        program_opt = program_opt_name(program, flags)
        path_orig = os.path.join(folder, f"CertiRocq.Tests.wasm.tests.{program}.wasm")
        path_opt = os.path.join(folder, f"CertiRocq.Tests.wasm.tests.{program_opt}.wasm")
        if not os.path.exists(path_opt):
            subprocess.run(
                [
                    "wasm-opt",
                    *flags,
                    "--enable-tail-call",
                    "--enable-reference-types",
                    "--enable-gc",
                    "--enable-mutable-globals",
                    path_orig,
                    "--output",
                    path_opt,
                ],
                check=True,
            )


def wasmtime_compile_programs(folder, wasmopt_flag):
    print(f"Compiling wasm modules AOT with wasmtime in {folder}.")
    # wasmtime fingerprints the Config into the artifact and refuses to
    # deserialize one compiled under a different one, so this has to stay in sync with the Config in run-wasmtime.py.
    config = Config()
    config.wasm_tail_call = True
    engine = Engine(config)
    for program in tqdm(programs):
        if wasmopt_flag != ():
            program = program_opt_name(program, wasmopt_flag)

        path = os.path.join(folder, f"CertiRocq.Tests.wasm.tests.{program}.wasm")
        if not os.path.exists(path):
            print(f"wasmtime compile: didn't find input program {path}, skipping.")
            continue

        path_compiled = os.path.join(
            folder, f"CertiRocq.Tests.wasm.tests.{program}.cwasm"
        )
        if not os.path.exists(path_compiled):
            with open(path, "rb") as f:
                module = Module(engine, f.read())
            with open(path_compiled, "wb") as f:
                f.write(module.serialize())


def single_run_node(folder, program, wasmgc_cast_nochecks, verbose):
    cast_flag = ["--experimental-wasm-assume-ref-cast-succeeds"] if wasmgc_cast_nochecks else []

    r = subprocess.run(
        [
            NODE,
            *cast_flag,
            "./run-node.js",
            folder,
            program,
        ],
        capture_output=True,
    )

    wasm_path = os.path.join(folder, f"CertiRocq.Tests.wasm.tests.{program}.wasm")
    if r.returncode != 0:
        print(f"Running {wasm_path} returned non-0 returncode, stderr: {r.stderr}")
        sys.exit(1)

    if verbose:
        print("STDOUT: " + r.stdout.decode("ascii"))
        print("STDERR: " + r.stdout.decode("ascii"))

    res = "{" + r.stdout.decode("ascii").split("{{")[1].split("}}")[0] + "}"
    return json.loads(res)


def single_run_wasmtime(folder, program, precompile, verbose):
    precompile_flag = [] if precompile else ["--no-precompile"]
    r = subprocess.run(
        [
            sys.executable,
            "run-wasmtime.py",
            folder,
            program,
            *precompile_flag,
        ],
        capture_output=True,
    )

    wasm_path = os.path.join(folder, f"CertiRocq.Tests.wasm.tests.{program}.{'c' if precompile else ''}wasm")
    if r.returncode != 0:
        print(f"Running {wasm_path} returned non-0 returncode, stderr: {r.stderr}")
        sys.exit(1)

    if verbose:
        print("STDOUT: " + r.stdout.decode("ascii"))
        print("STDERR: " + r.stdout.decode("ascii"))

    res = "{" + r.stdout.decode("ascii").split("{{")[1].split("}}")[0] + "}"
    return json.loads(res)


@click.command()
@click.option("--engine", type=str, help="Wasm engine (node|wasmtime|wasmtime-compile).", default="node")
@click.option("--runs", type=int, help="Number of runs.", default=10)
@click.option("--memory-usage", is_flag=True, help="Print linear memory usage.", default=False)
@click.option("--binary-size", is_flag=True, help="Print binary size", default=False)
@click.option("--folder", type=str, help="Path to folder with Wasm binaries.", multiple=True, required=True)
@click.option("--wasm-opt", type=str, help="Wasm-opt optimizations flag.", multiple=True)
@click.option("--wasmgc-cast-nochecks", is_flag=True, help="Disables runtime checks for casts.")
@click.option("--verbose", is_flag=True, help="Print debug information", default=False)
def measure(engine, runs, memory_usage, binary_size, folder, wasm_opt, wasmgc_cast_nochecks, verbose):
    if engine not in ["wasmtime", "wasmtime-compile", "node"]:
        print("Expected wasmtime or node runtime.")
        sys.exit(1)
    if runs <= 0:
        print("Expected at least one run.")
        sys.exit(1)

    for f in folder:
        f_name = pathlib.PurePath(f).name

        description = get_info(f.strip())
        if wasm_opt:
            description = description + f" ({' '.join(wasm_opt)})"
        engine_version = get_engine_version(engine)
        print(f"Running \"{f_name}\" ({description}), avg. of {runs} runs with {engine_version}.")

        for program in programs:
            path = os.path.join(f, f"CertiRocq.Tests.wasm.tests.{program}.wasm")

            if not os.path.exists(path):
                print(f"Didn't find {path}, skipping.")
                continue

            if wasm_opt:
                program = program_opt_name(program, wasm_opt)
                path = f"{f}/CertiRocq.Tests.wasm.tests.{program}.wasm"
                if not os.path.exists(path):
                    print(f"Didn't find optimized binary: {path}")
                    create_optimized_programs(f, wasm_opt)
                    print("Done. Please run again.")
                    sys.exit()

            if engine == "wasmtime-compile":
                path = os.path.join(f, f"CertiRocq.Tests.wasm.tests.{program}.cwasm")
                if not os.path.exists(path):
                    print(f"Didn't find compiled, optimized binary: {path}")
                    wasmtime_compile_programs(f, wasm_opt)
                    print("Done. Please run again.")
                    sys.exit()

            values = []
            for run in range(runs):
                res = None
                if engine == "node":
                    res = single_run_node(f, program, wasmgc_cast_nochecks, verbose)

                elif engine == "wasmtime":
                    res = single_run_wasmtime(f, program, precompile=False, verbose=verbose)

                elif engine == "wasmtime-compile":
                    res = single_run_wasmtime(f, program, precompile=True, verbose=verbose)

                assert res is not None, "No value returned."
                values.append(res)

            result = {}
            for meas in measurements:
                result[meas] = []

            for val in values:
                for meas in measurements:
                    if meas == "bytes_used" and val[meas] is None:
                        result[meas].append(None)
                    else:
                        result[meas].append(int(val[meas]))

            time_startup = round(sum(result["time_startup"]) / len(result["time_startup"]))
            time_main = round(sum(result["time_main"]) / len(result["time_main"]))
            time_pp = round(sum(result["time_pp"]) / len(result["time_pp"]))

            memory_in_kb = (
                int(result["bytes_used"][0] / 1000)
                if (runs > 0 and result["bytes_used"][0] is not None)
                else "N/A"
            )
            binary_size_in_kb = int(os.stat(path).st_size / 1000)

            # count spaces instead of using \t
            max_program_len = max(map(len, programs))
            program_orig_len = (
                len(program.split("-opt_")[0]) if "-opt_" in program else len(program)
            )
            program_pp = (max_program_len - program_orig_len) * " " + program

            print(
                f"{program_pp} : "
                f"startup: {time_startup:>4}, main: {time_main:>3}, sum: {time_startup+time_main:>4}"
                f" (pp: {time_pp:>2}, sum_total: {time_startup+time_main+time_pp:>4})"
                + (f", memory used: {memory_in_kb} KB" if memory_usage else "")
                + (f", bin size: {binary_size_in_kb:>4} KB" if binary_size else "")
            )

    print()


if __name__ == "__main__":
    measure()
