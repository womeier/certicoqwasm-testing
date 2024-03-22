#!/usr/bin/env python3

import os
import click
import subprocess
import json
from tqdm import tqdm
import time

CWD = os.path.abspath(os.path.dirname(__file__))
os.chdir(CWD)


measurements = ["time_startup", "time_main", "time_pp", "bytes_used"]


def get_info(path):
    if path[-1] == "/":
        path = path[:-1]
    if path[0:2] == "./":
        path = path[2:]

    benchmarks_info = {
        "binaries/cps-feb-01-24": "CPS, inserted tailcalls, naive 0ary (CoqPL)",
        "binaries/cps-0aryfast-feb-13-24": "CPS, inserted tailcalls (no return instrs)",
        "binaries/non-cps-feb-07-24": "non-CPS, (tailcalls, no return instrs) naive 0ary",
        "binaries/non-cps-0aryfast-return-feb-26-24": "non-cps, with return instr, 0ary",
    }
    try:
        info = benchmarks_info[path]
    except KeyError:
        print("Running new binaries. Did you run MAKE INSTALL?\n")
        time.sleep(1)
        info = "DIDN'T FIND DESCRIPTION"

    return info


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
            "node",
            "--experimental-wasm-return_call",
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


@click.command()
@click.option("--engine", type=str, help="Wasm engine", default="node")
@click.option("--runs", type=int, help="Number of runs", default=10)
@click.option("--memory_usage", is_flag=True, help="Print lin.mem. used", default=False)
@click.option("--binary_size", is_flag=True, help="Print binary size", default=False)
@click.option("--folder", type=str, help="Folder to Wasm binaries", required=True)
@click.option("--optimize_flag", type=str, help="Binaryen optimizations flag")
@click.option("--verbose", is_flag=True, help="Print debug information", default=False)
def measure(engine, runs, memory_usage, binary_size, folder, verbose, optimize_flag):
    assert (
        engine == "wasmtime" or engine == "node"
    ), "Expected wasmtime or node runtime."
    assert runs > 0, "Expected at least one run."

    description = get_info(folder.strip())
    if optimize_flag is not None:
        description = description + f" ({optimize_flag})"
    print(f"Running {description}, avg. of {runs} runs in {engine}.")

    programs = open(f"{folder}/TESTS").read().strip().split("\n")
    for program in programs:
        path = f"{folder}/CertiCoq.Benchmarks.tests.{program}.wasm"
        if optimize_flag is not None:
            program = program_opt_name(program, optimize_flag)
            path = f"{folder}/CertiCoq.Benchmarks.tests.{program}.wasm"
            if not os.path.exists(path):
                print("Didn't find optimized binaries.")
                create_optimized_programs(folder, flag=optimize_flag)
                print("Done. Please run again.")
                exit()

        values = []
        for run in range(runs):
            res = None
            if engine == "node":
                res = single_run_node(folder, program, verbose)

            if engine == "wasmtime":
                res = single_run_wasmtime(folder, program, verbose)

            assert res is not None, "No value returned."
            values.append(res)

        result = dict()
        for meas in measurements:
            result[meas] = list()

        for val in values:
            for meas in measurements:
                result[meas].append(int(val[meas]))

        time_startup = int(sum(result["time_startup"]) / len(result["time_startup"]))
        time_main = int(sum(result["time_main"]) / len(result["time_main"]))
        time_pp = int(sum(result["time_pp"]) / len(result["time_pp"]))
        memory_in_kb = int(result["bytes_used"][0] / 1000) if runs > 0 else "N/A"
        binary_size_in_kb = int(os.stat(path).st_size / 1000)

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


if __name__ == "__main__":
    measure()
