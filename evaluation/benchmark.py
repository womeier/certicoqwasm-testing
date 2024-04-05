#!/usr/bin/env python3

import os
import click
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
        "non-cps-metacoq-update-mrch-15-24": "non-cps (same as (feb-26-24), merged update to metacoq 1.3)",
        "non-cps-ifs-unnested-mrch-22-24": "non-cps (same as mrch-15-24), don't nest if statements",
        "non-cps-grow-mem-func-mrch-24-24": "non-cps (same as mrch-22-24), grow_mem in separate function"
    }
    try:
        info = benchmarks_info[path.replace("binaries/", "")]
    except KeyError:
        print("Running new binaries. Did you run MAKE INSTALL?\n")
        time.sleep(1)
        info = "DIDN'T FIND DESCRIPTION"

    return info


def get_engine_version(engine):
    if engine == "wasmtime":
        r = subprocess.run(["wasmtime", "--version"], capture_output=True)
        return r.stdout.decode("ascii").strip().replace("-cli ", " (") + ")"
    elif engine == "node":
        r = subprocess.run([NODE, "--version"], capture_output=True)
        return f"node ({r.stdout.decode('ascii').strip()})"
    else:
        print(f"Engine {engine} not found.")
        exit(1)


def program_opt_name(program, flag):
    if flag[0] == "-":
        if flag[1] == "-":
            return f"{program}-opt_{flag[2:]}"
        else:
            return f"{program}-opt_{flag[1:]}"
    else:
        return f"{program}-unexpected-{flag}"


def create_optimized_programs(folder, flag):
    print(f"Creating programs optimized with binaryen {flag} in {folder}.")
    programs = open(f"{folder}/TESTS").read().strip().split("\n")
    for program in tqdm(programs):
        program_opt = program_opt_name(program, flag)
        path_orig = os.path.join(folder, f"CertiCoq.Benchmarks.tests.{program}.wasm")
        path_opt = os.path.join(folder, f"CertiCoq.Benchmarks.tests.{program_opt}.wasm")
        if not os.path.exists(path_opt):
            subprocess.run(
                [
                    "wasm-opt",
                    f"{flag}",
                    "--enable-tail-call",
                    "--enable-mutable-globals",
                    path_orig,
                    "--output",
                    path_opt,
                ]
            )


def single_run_node(folder, program, verbose):
    r = subprocess.run(
        [
            NODE,
            "--experimental-wasm-return_call",
            "--no-wasm-bounds-checks",
            "./run-node.js",
            folder,
            program,
        ],
        capture_output=True,
    )

    wasm_path = f"{folder}/CertiCoq.Benchmarks.tests.{program}.wasm"
    assert (
        r.returncode == 0
    ), f"Running {wasm_path} returned non-0 returncode, stderr: {r.stderr}"

    if verbose:
        print("STDOUT: " + r.stdout.decode("ascii"))
        print("STDERR: " + r.stdout.decode("ascii"))

    res = "{" + r.stdout.decode("ascii").split("{{")[1].split("}}")[0] + "}"
    return json.loads(res)


def single_run_wasmtime(folder, program, verbose):
    r = subprocess.run(
        [
            "python3",
            "run-wasmtime.py",
            folder,
            program,
        ],
        capture_output=True,
    )

    wasm_path = f"{folder}/CertiCoq.Benchmarks.tests.{program}.wasm"
    assert (
        r.returncode == 0
    ), f"Running {wasm_path} returned non-0 returncode, stderr: {r.stderr}"

    if verbose:
        print("STDOUT: " + r.stdout.decode("ascii"))
        print("STDERR: " + r.stdout.decode("ascii"))

    res = "{" + r.stdout.decode("ascii").split("{{")[1].split("}}")[0] + "}"
    return json.loads(res)

def latex_table(tests, measure, results):
    rows = [[binary_version] + ["N/A" if result.get(t) is None else f"{result[t][measure]}" for t in tests] for (binary_version, result) in results.items()]

    latex_rows = [" & ".join(row) + "\\\\ \n" for row in rows]
    latex_string = (("\\begin{table}\n")
                    +("\\caption{placeholder caption}\n")
                    +("\\label{tbl:placeholder-label}\n")
                    +("\\centering\n")
                    +("\\begin{tabular}{|" + "|".join(["l"] + ["r" for t in tests]) + "|}\n")
                    +("\\hline\n")
                    +(" & " + " & ".join(tests) + " \\\\")
                    +("\\hline\n")
                    +(("\\hline\n").join(latex_rows))
                    +("\\hline\n")
                    +("\\end{tabular}\n")
                    +("\\end{table}\n")).replace("_", "\\_")

    print(latex_string)



def org_table(tests, measure, results):
    rows = [[binary_version] + ["N/A" if result.get(t) is None else f"{result[t][measure]}" for t in tests] for (binary_version, result) in results.items()]

    org_rows = ["| " + " | ".join(row) + " |\n" for row in rows]

    org_string = (("|---|---" + "".join(["|---" for t in tests]) + "|\n")
                  +("|   | " + " | ".join(tests) + " |\n")
                  +("|---|---" + "".join(["|---" for t in tests]) + "|\n")
                  +(("|---|---" + "".join(["|---" for t in tests]) + "|\n").join(org_rows))
                  +("|---|---" + "".join(["|---" for t in tests]) + "|\n"))

    print(org_string)

@click.command()
@click.option("--engine", type=str, help="Wasm engine", default="node")
@click.option("--runs", type=int, help="Number of runs", default=10)
@click.option("--memory_usage", is_flag=True, help="Print lin.mem. used", default=False)
@click.option("--binary_size", is_flag=True, help="Print binary size", default=False)
@click.option("--folder", type=str, help="Folder to Wasm binaries", multiple=True, required=True)
@click.option("--optimize_flag", type=str, help="Binaryen optimizations flag")
@click.option("--verbose", is_flag=True, help="Print debug information", default=False)
@click.option("--tests", type=str, help="Path to file containing tests")
@click.option("--print_latex_table", is_flag=True, help="Print results as latex table", default=False)
@click.option("--print_org_table", is_flag=True, help="Print results as org mode table", default=False)
def measure(engine, runs, memory_usage, binary_size, folder, verbose, optimize_flag, tests, print_latex_table, print_org_table):
    assert (
        engine == "wasmtime" or engine == "node"
    ), "Expected wasmtime or node runtime."
    assert runs > 0, "Expected at least one run."

    tests_to_run = open(tests).read().strip().split("\n") if tests is not None else []

    collected_tests = []

    all_results = dict()

    for f in folder:
        f_name = pathlib.PurePath(f).name

        description = get_info(f.strip())
        if optimize_flag is not None:
            description = description + f" ({optimize_flag})"
        engine_version = get_engine_version(engine)
        print(f"Running {description}, avg. of {runs} runs in {engine_version}.")

        programs = open(f"{f}/TESTS").read().strip().split("\n") if tests is None else tests_to_run
        folder_results = dict()
        for program in programs:

            test = program

            if program not in collected_tests:
                collected_tests.append(program)

            path = f"{f}/CertiCoq.Benchmarks.tests.{program}.wasm"

            if not os.path.exists(path):
                continue

            if optimize_flag is not None:
                program = program_opt_name(program, optimize_flag)
                path = f"{f}/CertiCoq.Benchmarks.tests.{program}.wasm"
                if not os.path.exists(path):

                    print(f"Didn't find optimized binaries: {program}")
                    # print("Didn't find optimized binaries.")
                    create_optimized_programs(f, flag=optimize_flag)
                    print("Done. Please run again.")
                    exit()

            values = []
            for run in range(runs):
                res = None
                if engine == "node":
                    res = single_run_node(f, program, verbose)

                if engine == "wasmtime":
                    res = single_run_wasmtime(f, program, verbose)

                assert res is not None, "No value returned."
                values.append(res)

            result = dict()
            for meas in measurements:
                result[meas] = list()

            for val in values:
                for meas in measurements:
                    result[meas].append(int(val[meas]))

            time_startup = round(sum(result["time_startup"]) / len(result["time_startup"]))
            time_main = round(sum(result["time_main"]) / len(result["time_main"]))
            time_pp = round(sum(result["time_pp"]) / len(result["time_pp"]))

            memory_in_kb = int(result["bytes_used"][0] / 1000) if runs > 0 else "N/A"
            binary_size_in_kb = int(os.stat(path).st_size / 1000)

            folder_results[test] = {"time_startup": time_startup, "time_main": time_main, "time_pp": time_pp, "bytes_used": memory_in_kb, "binary_size_in_kb": binary_size_in_kb}

            # count spaces instead of using \t
            max_program_len = max(map(len, programs))
            program_orig_len = (
                len(program.split("-opt_")[0]) if "-opt_" in program else len(program)
            )
            program_pp = (max_program_len - program_orig_len) * " " + program

            print(
                f"{program_pp} : "
                f"startup: {time_startup:>4}, main: {time_main:>3}, pp: {time_pp:>2}"
                f", sum: {time_startup+time_main+time_pp:>4}"
                + (f", memory used: {memory_in_kb} KB" if memory_usage else "")
                + (f", bin size: {binary_size_in_kb:>4} KB" if binary_size else "")
            )

        all_results[f_name] = folder_results

    if print_latex_table:
        print("\nPrinting LaTeX tables:\n")

        for meas in measurements:

            if not memory_usage and meas == "bytes_used":
                continue

            print(f"\nPrinting LaTeX table for {meas}:")
            latex_table(collected_tests, meas, all_results)

        if binary_size:
            print(f"\nPrinting LaTeX table for binary size:")
            latex_table(collected_tests, "binary_size_in_kb", all_results)

    if print_org_table:
        print("\nPrinting org tables:\n")

        for meas in measurements:
            if not memory_usage and meas == "bytes_used":
                continue

            print(f"\nPrinting org table for {meas}:")
            org_table(collected_tests, meas, all_results)

        if binary_size:
            print(f"\nPrinting org table for binary size:")
            org_table(collected_tests, "binary_size_in_kb", all_results)

    print("")


if __name__ == "__main__":
    measure()
