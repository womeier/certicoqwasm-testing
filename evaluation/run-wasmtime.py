#!/usr/bin/env python3

from wasmtime import Store, Module, Instance, Func, FuncType, ValType, Config, Engine
import pp
import sys
import time
import os

assert (
    len(sys.argv) == 3 or len(sys.argv) == 4
), "Expected args: 0: folder containing Wasm binaries, 1: program, optionally 2: --no-precompile"

path = sys.argv[1]
program = sys.argv[2]
program_orig = program.split("-opt")[0]

precompile = True
if "--no-precompile" in sys.argv:
    precompile = False

config = Config()
config.wasm_tail_call = True


# mapping for pretty print functions
def pp_function_not_found(value, memory, store):
    print("pp_function not found, please specify in run-wasmtime.py")


pp_function_map = {
    "demo1": pp.print_list_sexp(pp.print_bool),
    "demo2": pp.print_list_sexp(pp.print_bool),
    "list_sum": pp.print_nat_sexp,
    "vs_easy": pp.print_bool,
    "vs_hard": pp.print_bool,
    "binom": pp.print_nat_sexp,
    "color": pp.print_prod(pp.print_Z_sexp, pp.print_Z_sexp),
    "sha_fast": pp.print_list_sexp(pp.print_compcert_byte_sexp),
    "ack_3_9": pp.print_nat_sexp,
    "even_10000": pp.print_bool,
    "bernstein_yang": pp.print_Z_sexp,
    "sm_gauss_nat": pp.print_option(pp.print_nat_sexp),
    "sm_gauss_N": pp.print_option(pp.print_N_sexp),
    "sm_gauss_PrimInt": pp.print_option(pp.print_i63),
    "coqprime": pp.print_bool,
}


if "evaluation/binaries" in os.path.abspath(path):
    folder = os.path.abspath(path).split("/")[-1]
    # benchmarks before swapping bool constructors
    old_versions = [
       "cps-feb-01-24", "cps-0aryfast-feb-13-24", "non-cps-feb-07-24", "non-cps-0aryfast-return-feb-26-24",
       "non-cps-ifs-unnested-mrch-22-24", "non-cps-grow-mem-func-mrch-24-24",
       "non-cps-br_if-apr-12-24", "non-cps-wasmgc-may-16-24", "non-cps-primops-may-21-24",
       "non-cps-no-imports-june-15-24", "cps-grow-mem-less-often-september-18-24",
       "non-cps-grow-mem-less-often-august-30-24",
    ]
    if folder in old_versions:
        pp_function_map = {
            "demo1": pp.print_list_sexp(pp.print_bool_old_dont_use),
            "demo2": pp.print_list_sexp(pp.print_bool_old_dont_use),
            "list_sum": pp.print_nat_sexp,
            "vs_easy": pp.print_bool_old_dont_use,
            "vs_hard": pp.print_bool_old_dont_use,
            "binom": pp.print_nat_sexp,
            "color": pp.print_prod(pp.print_Z_sexp, pp.print_Z_sexp),
            "sha_fast": pp.print_list_sexp(pp.print_compcert_byte_sexp),
            "ack_3_9": pp.print_nat_sexp,
            "even_10000": pp.print_bool_old_dont_use,
            "bernstein_yang": pp.print_Z_sexp,
            "sm_gauss_nat": pp.print_option(pp.print_nat_sexp),
            "sm_gauss_N": pp.print_option(pp.print_N_sexp),
            "sm_gauss_PrimInt": pp.print_option(pp.print_i63),
            "coqprime": pp.print_bool_old_dont_use,
        }


if program_orig not in pp_function_map:
    print(f"Please specify pp function for {program_orig} in run-wasmtime.py")
    exit(1)


# Old version of our module needed the imports
def print_int(n):
    sys.stdout.write(str(n))


def print_char(n):
    sys.stdout.write(str(chr(n)))


# Shared amongst objects
store = Store(Engine(config))
print_char_stdout = Func(store, FuncType([ValType.i32()], []), print_char)
print_int_stdout = Func(store, FuncType([ValType.i32()], []), print_int)

# Here we compile a `Module` which is then ready for instantiation
start_startup = time.time()

if precompile:
    module = Module.deserialize_file(
        store.engine, os.path.join(path, f"CertiCoq.Benchmarks.wasm.tests.{program}.cwasm")
    )
else:
    module = Module.from_file(
        store.engine, os.path.join(path, f"CertiCoq.Benchmarks.wasm.tests.{program}.wasm")
    )

# instantiate module
if len(module.imports) == 0:
    # new version
    instance = Instance(store, module, [])
elif len(module.imports) == 2:
    # old debugging version with the 2 imported functions
    instance = Instance(store, module, [print_char_stdout, print_int_stdout])

stop_startup = time.time()
time_startup = round((stop_startup - start_startup) * 1000)

# run main
start_main = time.time()
instance.exports(store)["main_function"](store)
stop_main = time.time()
time_main = round((stop_main - start_main) * 1000)

result = instance.exports(store)["result"].value(store)
sys.stdout.write("====> ")

# previously, the generated module contained a pp function
# this is no longer the case with the new representation of constructor values
if "pretty_print_constructor" in instance.exports(store):
    start_pp = time.time()
    instance.exports(store)["pretty_print_constructor"](store, result)
    stop_pp = time.time()
    time_pp = round((stop_pp - start_pp) * 1000)
else:
    start_pp = time.time()
    memory = instance.exports(store)["memory"]
    pp_function = pp_function_map[program_orig]
    pp_function(result, memory, store)
    stop_pp = time.time()
    time_pp = round((stop_pp - start_pp) * 1000)

print()

try:
    # old name bytes_used renamed into mem_ptr
    bytes_used = instance.exports(store)["bytes_used"].value(store)
except KeyError:
    bytes_used = instance.exports(store)["mem_ptr"].value(store)

print(
    f"Benchmark {path}:"
    + "{{"
    + f'"time_startup": "{time_startup}", "time_main": "{time_main}", "time_pp": "{time_pp}", "bytes_used": "{bytes_used}", "program": "{program}"'
    + "}} ms, bytes."
)
