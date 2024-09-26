#!/usr/bin/env python3

import sys
import os

if len(sys.argv) == 2 and sys.argv[1].split(".")[-1] == "wasm" and os.path.isfile(sys.argv[1]):
    file_name = sys.argv[1]
else:
    print("expected parameter *.wasm file")
    exit(1)

bytestring = open(file_name, "rb").read()

def b2s(b):
    x = hex(b)[2:]
    if len(x) == 1:
        x = "0" + x
    return "x" + x


preamble = """
From Coq Require Import String List.
From Coq.Strings Require Import Byte.

From Wasm Require Import binary_format_parser datatypes instantiation_func.
"""

definition_bytelist = "Definition test_bytes : list Byte.byte := " + " :: ".join([b2s(x) for x in bytestring]) + " :: nil."
definition_module = "Definition test_module : option module := run_parse_module test_bytes."
compute = "Compute test_module."
type_check = """Definition type_check_test_module :=
  match test_module with
  | Some m => module_type_checker m
  | None => None
  end.
"""
compute_type_check = "Compute type_check_test_module."

file_name_out = file_name.replace(".", "_") + ".v"
if os.path.isfile(file_name_out):
    os.remove(file_name_out)

def debug_compute(text):
    return f"Compute \"{text}\"%string."

print(f"writing output to {file_name_out}")

with open(file_name_out, "a") as f:
    f.write(preamble + "\n\n")
    f.write(definition_bytelist + "\n\n")
    f.write(definition_module + "\n\n")
    f.write(debug_compute("parsing module bytes") + "\n\n")
    f.write(compute + "\n\n")
    f.write(type_check + "\n\n")
    f.write(debug_compute("type checking") + "\n\n")
    f.write(compute_type_check + "\n\n")
