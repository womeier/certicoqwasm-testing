#!/usr/bin/env python3

import os
import click
import subprocess
import json

CWD = os.path.abspath(os.path.dirname(__file__))
os.chdir(CWD)


benchmarks_info = {
    "./binaries/cps-binaryen-O2-feb-01-24/": "CPS + binaryen -O2",
    "./binaries/cps-feb-01-24/": "CPS",
    "./binaries/non-cps-PROPER-feb-07-24/": "NON-CPS, WasmCert tailcalls",
    "./binaries/non-cps-BAD-feb-06-24/": "NON-CPS, only normal tailcalls",
    "./binaries/non-cps-PROPER-0aryfast-feb-13-24/": "NON-CPS, WasmCert tailcalls, unboxed 0ary constr",
}

measurements = ["time_instantiate", "time_main", "time_pp"]


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
@click.option("--engine", type=str, help="Wasm engine", required=True)
@click.option("--runs", type=int, help="Number of runs", default=10)
@click.option(
    "--folder", type=str, help="Folder to Wasm binaries to run", required=True
)
@click.option("--verbose", is_flag=True, help="Print debug information", default=False)
def measure(engine, runs, folder, verbose):
    assert (
        engine == "wasmtime" or engine == "node"
    ), "Expected wasmtime or node runtime."
    assert runs > 0, "Expected at least one run."

    description = benchmarks_info[folder.strip()]
    programs = open(f"{folder}/TESTS").read().strip().split("\n")
    print(f"Running {description}, avg. of {runs} runs in {engine}.")

    for program in programs:

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

        time_instantiate = int(
            sum(result["time_instantiate"]) / len(result["time_instantiate"])
        )
        time_main = int(sum(result["time_main"]) / len(result["time_main"]))
        time_pp = int(sum(result["time_pp"]) / len(result["time_pp"]))
        print(
            f"{description} / avg of {runs} runs / {program}\t: "
            f"instantiation: {time_instantiate}, main: {time_main}, pp: {time_pp}, "
            f" sum: {time_instantiate + time_main + time_pp}"
        )


if __name__ == "__main__":
    measure()
