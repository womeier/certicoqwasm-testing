#!/usr/bin/env python3

import sys
import subprocess

assert len(sys.argv) == 3, "expected two arguments: 0: js file, 1: file containing expected return exp" # noqa

js_file = sys.argv[1]
expected = open(sys.argv[2]).read()

out = subprocess.check_output(["node", js_file])

print()

if expected.strip() in str(out):
    print(f"Running {js_file} yielded the correct S-expr.")
else:
    print("Got incorrect result:")
    print(str(out))
    print("-------- EXPECTED: ------------------------------")
    print(expected)
