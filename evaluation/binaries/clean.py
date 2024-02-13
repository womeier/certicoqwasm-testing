#!/usr/bin/env python3
import subprocess

print("Deleting optimized Wasm files...")
subprocess.run(["find", ".", "-name", "*opt*", "-delete"])
