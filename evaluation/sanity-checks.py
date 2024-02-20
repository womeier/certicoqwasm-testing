#!/usr/bin/env python3
import os
import subprocess
from tqdm import tqdm

folders = list(filter(lambda x: x != "clean.py", os.listdir("./binaries/")))
programs = ["binom", "sha_fast", "vs_easy", "vs_hard"]


################################################################################################
print("Checking that all binaries have a different sha256 sum.")

hashes = []
for prog in programs:
    for folder in folders:
        file = f"./binaries/{folder}/CertiCoq.Benchmarks.tests.{prog}.wasm"
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
    expected_res = open(f"./results/{program}.txt").read()
    for folder in folders:
        r = subprocess.run(
            [
                "node",
                "--experimental-wasm-return_call",
                "./run-node.js",
                f"./binaries/{folder}/",
                program,
            ],
            capture_output=True,
        )
        if r.returncode != 0:
            print(f"{folder}/CertiCoq.test.{program}.wasm returned non-0 return code.")
            print(r.stderr.decode("utf-8"))
            exit()

        stdout = r.stdout.decode("utf-8")
        if expected_res not in stdout:
            print("Didn't find expected result in stdout.")
            print("STDOUT: " + stdout)
            print("STDERR: " + r.stderr.decode("utf-8"))
            exit(1)

print("==> all good.")
