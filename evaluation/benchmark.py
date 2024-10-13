#!/usr/bin/env python3

import os
import click
import pkg_resources
import subprocess
import json
from tqdm import tqdm
import time
import pathlib

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


def get_info(path):
    if path[-1] == "/":
        path = path[:-1]
    if path[0:2] == "./":
        path = path[2:]

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

        # also bool constructors swapped https://github.com/CertiCoq/certicoq/pull/100
        "non-cps-grow-mem-less-often-august-30-24": "track available mem statically, only grow when necessary",
        "non-cps-cleanup-oct-13-24": "renamed globals, cleanup",
    }
    try:
        info = benchmarks_info[path.replace("binaries/", "")]
    except KeyError:
        print("Running new binaries. Did you run MAKE INSTALL?\n")
        time.sleep(1)
        info = path

    return info


def get_engine_version(engine):
    if engine == "wasmtime":
        packages = {d.project_name: d.version for d in pkg_resources.working_set}
        version = packages.get("wasmtime", "wasmtime-py not installed")
        return f"wasmtime-py ({version})"
    elif engine == "wasmtime-compile":
        r = subprocess.run(["wasmtime", "--version"], capture_output=True)
        return r.stdout.decode("ascii").strip().replace("-cli ", "-compile (") + ")"
    elif engine == "node":
        r = subprocess.run([NODE, "--version"], capture_output=True)
        return f"Node.js ({r.stdout.decode('ascii').strip()})"
    else:
        print(f"Engine {engine} not found.")
        exit(1)


def ensure_wasmtime_same_version():
    version_lib = get_engine_version("wasmtime").split("(")[1][:-1]
    version_standalone = get_engine_version("wasmtime-compile").split("(")[1][:-1]
    if version_lib != version_standalone:
        print(f"Found two different version of wasmtime: standalone {version_standalone} and python-lib {version_lib}. They need to be the same.")
        exit(1)


def program_opt_name(program, flags):
    flags = map(lambda f: f.replace("-", ""), flags)
    return f"{program}-opt_{'-'.join(flags)}"


def create_optimized_programs(folder, flags):
    print(f"Creating programs optimized with wasm-opt {' '.join(flags)} in {folder}.")
    for program in tqdm(programs):
        program_opt = program_opt_name(program, flags)
        path_orig = os.path.join(folder, f"CertiCoq.Benchmarks.tests.{program}.wasm")
        path_opt = os.path.join(folder, f"CertiCoq.Benchmarks.tests.{program_opt}.wasm")
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
                ]
            )


def wasmtime_compile_programs(folder, wasmopt_flag):
    print(f"Compiling wasm modules AOT with wasmtime in {folder}.")
    for program in tqdm(programs):
        if wasmopt_flag != ():
            program = program_opt_name(program, wasmopt_flag)

        path = os.path.join(folder, f"CertiCoq.Benchmarks.tests.{program}.wasm")
        if not os.path.exists(path):
            print(f"wasmtime compile: didn't find input program {path}, skipping.")
            continue

        path_compiled = os.path.join(
            folder, f"CertiCoq.Benchmarks.tests.{program}.cwasm"
        )
        if not os.path.exists(path_compiled):
            subprocess.run(
                [
                    "wasmtime",
                    "compile",
                    "-W",
                    "tail-call=y",
                    path,
                    "--output",
                    path_compiled,
                ]
            )


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

    wasm_path = os.path.join(folder, f"CertiCoq.Benchmarks.tests.{program}.wasm")
    if r.returncode != 0:
        print(f"Running {wasm_path} returned non-0 returncode, stderr: {r.stderr}")
        exit(1)

    if verbose:
        print("STDOUT: " + r.stdout.decode("ascii"))
        print("STDERR: " + r.stdout.decode("ascii"))

    res = "{" + r.stdout.decode("ascii").split("{{")[1].split("}}")[0] + "}"
    return json.loads(res)


def single_run_wasmtime(folder, program, precompile, verbose):
    precompile_flag = [] if precompile else ["--no-precompile"]
    r = subprocess.run(
        [
            "python3",
            "run-wasmtime.py",
            folder,
            program,
            *precompile_flag,
        ],
        capture_output=True,
    )

    wasm_path = os.path.join(folder, f"CertiCoq.Benchmarks.tests.{program}.{'c' if precompile else ''}wasm")
    if r.returncode != 0:
        print(f"Running {wasm_path} returned non-0 returncode, stderr: {r.stderr}")
        exit(1)

    if verbose:
        print("STDOUT: " + r.stdout.decode("ascii"))
        print("STDERR: " + r.stdout.decode("ascii"))

    res = "{" + r.stdout.decode("ascii").split("{{")[1].split("}}")[0] + "}"
    return json.loads(res)


def org_table(tests, measures, results):
    allrows = []
    for (version, result) in results.items():
        rows=[]
        for measure in measures:
            row = [measure] + ["" if result.get(t) is None else f"{result[t][measure]}" for t in tests]
            rows.append(row)
        allrows.append((version, rows))


    orgrows = []
    for (version, rows) in allrows:
        orgrows.append(f"| {version} | " + " | ".join(rows[0]) + " |\n" + "".join(["|   | " + " | ".join(row) + " |\n" for row in rows[1:]]))

    org_string = (("|---|---|---" + "".join(["|---" for t in tests]) + "|\n")
                  +("|   |   |   " + " | ".join(tests) + " |\n")
                  +("|---|---" + "".join(["|---" for t in tests]) + "|\n")
                  +(("|---|---" + "".join(["|---" for t in tests]) + "|\n").join(orgrows))
                  +("|---|---" + "".join(["|---" for t in tests]) + "|\n"))

    print(org_string)

@click.command()
@click.option("--engine", type=str, help="Wasm engine (node|wasmtime|wasmtime-compile).", default="node")
@click.option("--runs", type=int, help="Number of runs.", default=10)
@click.option("--memory-usage", is_flag=True, help="Print linear memory usage.", default=False)
@click.option("--binary-size", is_flag=True, help="Print binary size", default=False)
@click.option("--folder", type=str, help="Path to folder with Wasm binaries.", multiple=True, required=True)
@click.option("--wasm-opt", type=str, help="Wasm-opt optimizations flag.", multiple=True)
@click.option("--wasmgc-cast-nochecks", is_flag=True, help="Disables runtime checks for casts.")
@click.option("--verbose", is_flag=True, help="Print debug information", default=False)
@click.option("--print-org-table", is_flag=True, help="Print results as org mode table", default=False)
def measure(engine, runs, memory_usage, binary_size, folder, wasm_opt, wasmgc_cast_nochecks, verbose, print_org_table):
    if engine not in ["wasmtime", "wasmtime-compile", "node"]:
        print("Expected wasmtime or node runtime.")
        exit(1)
    if engine == "wasmtime-compile":
        ensure_wasmtime_same_version()
    if runs <= 0:
        print("Expected at least one run.")
        exit(1)

    all_results = dict()

    for f in folder:
        f_name = pathlib.PurePath(f).name

        description = get_info(f.strip())
        if wasm_opt:
            description = description + f" ({' '.join(wasm_opt)})"
        engine_version = get_engine_version(engine)
        print(f"Running {description}, avg. of {runs} runs with {engine_version}.")

        folder_results = dict()
        for program in programs:
            program_name_orig = program
            path = os.path.join(f, f"CertiCoq.Benchmarks.tests.{program}.wasm")

            if not os.path.exists(path):
                print(f"Didn't find {path}, skipping.")
                continue

            if wasm_opt:
                program = program_opt_name(program, wasm_opt)
                path = f"{f}/CertiCoq.Benchmarks.tests.{program}.wasm"
                if not os.path.exists(path):
                    print(f"Didn't find optimized binary: {path}")
                    create_optimized_programs(f, wasm_opt)
                    print("Done. Please run again.")
                    exit()

            if engine == "wasmtime-compile":
                path = os.path.join(f, f"CertiCoq.Benchmarks.tests.{program}.cwasm")
                if not os.path.exists(path):
                    print(f"Didn't find compiled, optimized binary: {path}")
                    wasmtime_compile_programs(f, wasm_opt)
                    print("Done. Please run again.")
                    exit()

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

            result = dict()
            for meas in measurements:
                result[meas] = list()

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

            folder_results[program_name_orig] = {
                "time_startup": time_startup,
                "time_main": time_main,
                "time_pp": time_pp,
                "sum": time_startup + time_main,
                "bytes_used": memory_in_kb,
                "binary_size_in_kb": binary_size_in_kb,
            }

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

        all_results[f_name] = folder_results

    if print_org_table:
        print("\nPrinting org tables:\n")

        org_table(programs, ["time_main", "time_pp", "sum"], all_results)

    print("")


if __name__ == "__main__":
    measure()
