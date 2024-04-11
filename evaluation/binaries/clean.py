#!/usr/bin/env python3
import subprocess

print("Deleting optimized/compiled Wasm files...")
subprocess.run(["find", ".", "-name", "*opt*", "-delete"])
subprocess.run(["find", ".", "-name", "*.cwasm", "-delete"])
