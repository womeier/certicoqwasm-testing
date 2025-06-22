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

template = f"""
From Coq Require Import String List.
From Coq.Strings Require Import Byte.

From Wasm Require Import binary_format_parser datatypes instantiation_func.

Definition test_bytes : list Byte.byte := {" :: ".join([b2s(x) for x in bytestring])} :: nil.

Definition test_module : option module := run_parse_module test_bytes.

Compute "Parsing module...".
Compute test_module.


Definition type_check_test_module :=
  match test_module with
  | Some m => module_type_checker m
  | None => (None, String.EmptyString)
  end.

Compute "Type checking module...".
Compute type_check_test_module.
"""

path, name = file_name.rsplit("/", 1)
file_name_out = os.path.join(path, name.replace(".", "_") + ".v")
if os.path.isfile(file_name_out):
    os.remove(file_name_out)

print(f"writing output to {file_name_out}")

with open(file_name_out, "a") as f:
    f.write(template)
