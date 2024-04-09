#!/usr/bin/env python3

import os
import click
import subprocess
import json
import pathlib

CWD = os.path.abspath(os.path.dirname(__file__))
os.chdir(CWD)

# NODE = "/usr/bin/node"
NODE = "node"
measurements = ["time_startup", "time_main", "time_pp"]

def get_engine_version(engine):
    if engine == "node":
        r = subprocess.run([NODE, "--version"], capture_output=True)
        return f"node ({r.stdout.decode('ascii').strip()})"
    else:
        print(f"Engine {engine} not found.")
        exit(1)


def single_run_node(folder, program, verbose):
    r = subprocess.run(
        [
            NODE,
#            "--experimental-wasm-return_call",
#            "--no-wasm-bounds-checks",
            "--stack-size=1000000",
            "./run-node.js",
            folder,
            program,
        ],
        capture_output=True,
    )

    wasm_path = f"{folder}/{program}.wasm"
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
@click.option("--runs", type=int, help="Number of runs", default=10)
@click.option("--binary-size", is_flag=True, help="Print binary size", default=False)
@click.option("--folder", type=str, help="Folder to Wasm binaries", required=True)
@click.option("--verbose", is_flag=True, help="Print debug information", default=False)
@click.option("--print-latex-table", is_flag=True, help="Print results as latex table", default=False)
@click.option("--print-org-table", is_flag=True, help="Print results as org mode table", default=False)
def measure(runs, binary_size, folder, verbose, print_latex_table, print_org_table):
    assert runs > 0, "Expected at least one run."

    f_name = pathlib.PurePath(folder).name
    engine_version = get_engine_version("node")
    print(f"Running {f_name}, avg. of {runs} runs in {engine_version}.")

    programs = open(os.path.join(CWD, "TESTS")).read().strip().split("\n")
    for program in programs:
        path = f"{folder}/{program}.wasm"
        if not os.path.exists(path):
            continue

        values = []
        for run in range(runs):
            res = single_run_node(folder, program, verbose)

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
            + (f", bin size: {binary_size_in_kb:>4} KB" if binary_size else "")
        )

if __name__ == "__main__":
    measure()
