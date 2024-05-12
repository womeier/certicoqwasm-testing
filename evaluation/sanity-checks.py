#!/usr/bin/env python3
import os
import subprocess
from tqdm import tqdm

folders = list(filter(lambda x: x != "clean.py", os.listdir("./binaries/")))
programs = [
    "demo1",
    "demo2",
    "list_sum",
    "binom",
    "sha_fast",
    "vs_easy",
    "vs_hard",
    "ack_3_9",
    "even_10000",
    "sm_gauss_N",
    "sm_gauss_nat",
]

print("Sanitity checking the following combinations: ")
print(f"- {', '.join(folders)}")
print(f"- {', '.join(programs)}")
print("---------------------------------------------------------------------------------------")

################################################################################################
print("Checking that all binaries have a different sha256 sum.")

hashes = []
for prog in programs:
    for folder in folders:
        file = f"./binaries/{folder}/CertiCoq.Benchmarks.tests.{prog}.wasm"
        if not os.path.exists(file):
            print(f"Didn't find {file}.")
            exit(1)
        p = subprocess.run(["sha256sum", file], capture_output=True)
        hashes.append((p.stdout.decode("utf-8").split(" ")[0], file))

found_same_hash = False
for hash, file in hashes:
    tuples_same_hash = list(filter(lambda t: t[0] == hash, hashes))
    if len(tuples_same_hash) > 1:
        print("Found multiple files with same hash:")
        found_same_hash = True
        for h, f in tuples_same_hash:
            print(f"{f}: {h}")

if found_same_hash:
    exit(1)
else:
    print("==> all good.")


#########################################################################################

print("\nRunning all binaries and checking for correct result printed to stdout.")

for program in tqdm(programs):
    expected_res = open(f"./results/{program}.txt").read().strip().split("\n")
    for folder in folders:
        # RUN wasm-opt
        program_opt = f"{program}-opt_coalesce-locals"
        path_program_opt = (
            f"./binaries/{folder}/CertiCoq.Benchmarks.tests.{program_opt}.wasm"
        )
        path_program = f"./binaries/{folder}/CertiCoq.Benchmarks.tests.{program}.wasm"
        if not os.path.exists(path_program_opt):
            r = subprocess.run(
                [
                    "wasm-opt",
                    "--coalesce-locals",
                    "--enable-tail-call",
                    "--enable-mutable-globals",
                    path_program,
                    "--output",
                    path_program_opt,
                ],
                capture_output=True,
            )
            if r.returncode != 0:
                print(f"{folder}: failed to call wasm-opt")
                print(r.stderr.decode("utf-8"))
                exit()

        # RUN
        r = subprocess.run(
            [
                "python3",
                "./run-wasmtime.py",
                f"./binaries/{folder}/",
                program_opt,
            ],
            capture_output=True,
        )
        if r.returncode != 0:
            print(
                f"{folder}/CertiCoq.Benchmarks.tests.{program_opt}.wasm returned non-0 return code."
            )
            print(r.stderr.decode("utf-8"))
            exit()

        stdout = r.stdout.decode("utf-8")
        if all(map(lambda res: res not in stdout, expected_res)):
            print("Didn't find expected result in stdout.")
            print("STDOUT: " + stdout)
            print("STDERR: " + r.stderr.decode("utf-8"))
            exit(1)

print("==> all good.")
