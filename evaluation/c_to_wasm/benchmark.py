#!/usr/bin/env python3

import os
import click
import subprocess
import json
import pathlib
from tqdm import tqdm

CWD = os.path.abspath(os.path.dirname(__file__))
os.chdir(CWD)

# NODE = "/usr/bin/node"
NODE = "node"
measurements = ["time_startup", "time_main", "time_pp"]

programs = [
    "demo1",
    "demo2",
    "list_sum",
    "vs_easy",
    "vs_hard",
    "binom",
    "sha_fast",
    #"color",
    "sm_gauss_nat",
    "sm_gauss_N",
    "sm_gauss_PrimInt",
    "even_10000",
    "ack_3_9",
]


def get_engine_version(engine):
    if engine == "node":
        r = subprocess.run([NODE, "--version"], capture_output=True)
        return f"node ({r.stdout.decode('ascii').strip()})"
    else:
        print(f"Engine {engine} not found.")
        exit(1)

def program_opt_name(program, flags):
    flags = map(lambda f: f.replace("-", ""), flags)
    return f"{program}-opt_{'-'.join(flags)}"


def single_run_node(folder, program, verbose):
    r = subprocess.run(
        [
            NODE,
            "--stack-size=1000000",
            "./run-node.js",
            folder,
            program,
        ],
        capture_output=True,
    )
    wasm_path = f"{folder}/{program}.wasm"
    # assert (
    #     r.returncode == 0
    # ), f"Running {wasm_path} returned non-0 returncode, stderr: {r.stderr}"

    if verbose:
        print("STDOUT: " + r.stdout.decode("ascii"))
        print("STDERR: " + r.stdout.decode("ascii"))

    res = "{" + r.stdout.decode("ascii").split("{{")[1].split("}}")[0] + "}"
    return json.loads(res)

def create_optimized_programs(folder, flags):
    print(f"Creating programs optimized with wasm-opt {' '.join(flags)} in {folder}.")
    for program in tqdm(programs):
        program_opt = program_opt_name(program, flags)
        path_orig = os.path.join(folder, f"{program}.wasm")
        path_opt = os.path.join(folder, f"{program_opt}.wasm")
        if not os.path.exists(path_opt):
            subprocess.run(
                [
                    "wasm-opt",
                    *flags,
                    "--enable-tail-call",
                    "--enable-reference-types",
                    "--enable-gc",
                    "--enable-mutable-globals",
                    "--enable-bulk-memory",
                    "--enable-exception-handling",
                    "--enable-multivalue",
                    "--enable-strings",
                    "--enable-nontrapping-float-to-int",
                    path_orig,
                    "--output",
                    path_opt,
                ]
            )


@click.command()
@click.option("--runs", type=int, help="Number of runs", default=10)
@click.option("--binary-size", is_flag=True, help="Print binary size", default=False)
@click.option("--folder", type=str, help="Folder to Wasm binaries", required=True)
@click.option("--wasm-opt", type=str, help="Wasm-opt optimizations flag", multiple=True)
@click.option("--verbose", is_flag=True, help="Print debug information", default=False)
def measure(runs, binary_size, folder, wasm_opt, verbose):
    assert runs > 0, "Expected at least one run."

    f_name = pathlib.PurePath(folder).name
    engine_version = get_engine_version("node")
    print(f"Running {f_name}, avg. of {runs} runs in {engine_version}.")

    for program in programs:
        path = f"{folder}/{program}.wasm"

        if not os.path.exists(path):
            continue

        if wasm_opt:
            program = program_opt_name(program, wasm_opt)
            path = f"{folder}/{program}.wasm"
            if not os.path.exists(path):
                print(f"Didn't find optimized binary: {path}")
                create_optimized_programs(folder, wasm_opt)

        values = []
        failed = False
        for run in range(runs):
            try:
                res = single_run_node(folder, program, verbose)
                assert res is not None, "No value returned."
                values.append(res)
            except:
                failed = True

        if failed:
            max_program_len = max(map(len, programs))
            program_orig_len = (
                len((program).split("-opt_")[0]) if "-opt_" in program else len(program)
            )
            program_pp = (max_program_len - program_orig_len) * " " + program
            print(f"{program_pp} : failed to run")
            continue

        result = dict()
        for meas in measurements:
            result[meas] = list()

        for val in values:
            for meas in measurements:
                result[meas].append(int(val[meas]))

        time_startup = round(sum(result["time_startup"]) / len(result["time_startup"]))
        time_main = round(sum(result["time_main"]) / len(result["time_main"]))
        time_pp = round(sum(result["time_pp"]) / len(result["time_pp"]))

        binary_size_in_kb = int(os.stat(path).st_size / 1000)

        # count spaces instead of using \t
        max_program_len = max(map(len, programs))
        program_orig_len = (
            len(program.split("-opt_")[0]) if "-opt_" in program else len(program)
        )
        program_pp = (max_program_len - program_orig_len) * " " + program

        print(
            f"{program_pp} : "
            f"startup: {time_startup:>2}, main: {time_main:>3}, pp: {time_pp:>2}"
            f", sum: {time_startup+time_main+time_pp:>4}"
            + (f", bin size: {binary_size_in_kb:>4} KB" if binary_size else "")
        )


if __name__ == "__main__":
    measure()
