#!/usr/bin/env python3

import os
import click
import subprocess
import json
from tqdm import tqdm
import time

CWD = os.path.abspath(os.path.dirname(__file__))
os.chdir(CWD)


measurements = ["time_startup", "time_main", "time_pp"]


def get_info(path):
    if path[-1] == "/":
        path = path[:-1]
    if path[0:2] == "./":
        path = path[2:]

    benchmarks_info = {
        "binaries/cps-feb-01-24": "CPS, inserted tailcalls, naive 0ary",
        "binaries/non-cps-PROPER-feb-07-24": "non-CPS, naive 0ary",
        "binaries/non-cps-BAD-feb-06-24": "non-CPS, no Wasm tailcalls, naive 0ary",
        "binaries/non-cps-PROPER-0aryfast-feb-13-24": "non-CPS, WasmCert tailcalls",
        "binaries/cps-0aryfast-feb-13-24": "CPS, inserted tailcalls",
        "binaries/non-cps-PROPER-0aryfast-return-feb-26-24": "non-cps, with return instr, 0ary",
    }
    try:
        info = benchmarks_info[path]
    except KeyError:
        print("Running new binaries. Did you run MAKE INSTALL?\n")
        time.sleep(1)
        info = "DIDN'T FIND DESCRIPTION"

    return info


def create_optimized_programs(folder, flag):
    print(f"Creating programs optimized with binaryen {flag} in {folder}.")
    programs = open(f"{folder}/TESTS").read().strip().split("\n")
    for program in tqdm(programs):
        orig = os.path.join(folder, f"CertiCoq.Benchmarks.tests.{program}.wasm")
        opt = os.path.join(
            folder, f"CertiCoq.Benchmarks.tests.{program}-opt-{flag}.wasm"
        )
        if not os.path.exists(opt):
            subprocess.run(
                [
                    "wasm-opt",
                    f"{flag}",
                    "--enable-tail-call",
                    "--enable-mutable-globals",
                    orig,
                    "--output",
                    opt,
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
@click.option("--folder", type=str, help="Folder to Wasm binaries", required=True)
@click.option("--optimize_flag", type=str, help="Binaryen optimizations flag")
@click.option("--verbose", is_flag=True, help="Print debug information", default=False)
def measure(engine, runs, folder, verbose, optimize_flag):
    assert (
        engine == "wasmtime" or engine == "node"
    ), "Expected wasmtime or node runtime."
    assert runs > 0, "Expected at least one run."

    description = get_info(folder.strip())
    programs = open(f"{folder}/TESTS").read().strip().split("\n")
    opt_desc = f"({optimize_flag})" if optimize_flag is not None else ""
    print(f"Running {description} {opt_desc}, avg. of {runs} runs in {engine}.")

    for program in programs:
        if optimize_flag is not None:
            program = f"{program}-opt-{optimize_flag}"
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
        print(
            f"{description} / avg of {runs} runs / {program}\t: "
            f"startup: {time_startup}, main: {time_main}, pp: {time_pp}, "
            f" sum: {time_startup+ time_main + time_pp}"
        )


if __name__ == "__main__":
    measure()
