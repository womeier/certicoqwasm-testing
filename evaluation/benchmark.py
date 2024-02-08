#!/usr/bin/env python3

import os
import click
import subprocess
import json

CWD = os.path.abspath(os.path.dirname(__file__))
os.chdir(CWD)


benchmarks = [
    ("./binaries/cps-binaryen-O2-feb-01-24/", "CPS + binaryen -O2"),
    ("./binaries/cps-feb-01-24/", "CPS"),
    ("./binaries/non-cps-PROPER-feb-07-24/", "NON-CPS, WasmCert tailcalls"),
    ("./binaries/non-cps-BAD-feb-06-24", "NON-CPS, only normal tailcalls"),
]

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


@click.command()
@click.option("--engine", type=str, help="Wasm engine", required=True)
@click.option("--runs", type=int, help="Number of runs", default=10)
@click.option("--benchmark", type=int, help="Which benchmark to run", required=True)
@click.option("--verbose", is_flag=True, help="Print debug information", default=False)
def measure(engine, runs, benchmark, verbose):
    global benchmarks, measurements

    assert (
        engine == "wasmtime" or engine == "node"
    ), "Expected wasmtime or node runtime."
    assert runs > 0, "Expected at least one run."
    assert 0 <= benchmark < len(benchmarks), "Expected at least one run."

    folder = benchmarks[benchmark][0]
    description = benchmarks[benchmark][1]

    programs = open(f"{folder}/TESTS").read().strip().split("\n")
    print(f"Running {description}, avg. of {runs} runs in {engine}.")

    for program in programs:

        values = []
        for run in range(runs):
            res = None
            if engine == "node":
                res = single_run_node(folder, program, verbose)

            if engine == "wasmtime":
                assert False, "TODO"

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
