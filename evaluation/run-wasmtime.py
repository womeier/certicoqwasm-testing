from wasmtime import Store, Module, Instance, Func, FuncType, ValType, Config, Engine
import sys
import time
import os

assert (
    len(sys.argv) == 3
), "Expected two args: 0: folder containing Wasm binaries, 1: program"

path = sys.argv[1]
program = sys.argv[2]

config = Config()
config.wasm_tail_call = True

# Shared amongst objects
store = Store(Engine(config))

# Here we can compile a `Module` which is then ready for instantiation
# afterwards
module = Module.from_file(
    store.engine, os.path.join(path, f"CertiCoq.Benchmarks.tests.{program}.wasm")
)


# Our module needs two imports
def print_int(n):
    sys.stdout.write(str(n))


def print_char(n):
    sys.stdout.write(str(chr(n)))


print_char_stdout = Func(store, FuncType([ValType.i32()], []), print_char)
print_int_stdout = Func(store, FuncType([ValType.i32()], []), print_int)

# instantiate module
start_inst = time.time()
instance = Instance(store, module, [print_char_stdout, print_int_stdout])
# intention: force instantiation, doesn't seem to work, time_inst is 0
_ = instance.exports(store)["bytes_used"].value(store)
stop_inst = time.time()
time_inst = int((stop_inst - start_inst) * 1000)

# run main
start_main = time.time()
instance.exports(store)["$main_function"](store)
stop_main = time.time()
time_main = int((stop_main - start_main) * 1000)

result = instance.exports(store)["result"].value(store)
sys.stdout.write("====> ")

start_pp = time.time()
instance.exports(store)["$pretty_print_constructor"](store, result)
stop_pp = time.time()
time_pp = int((stop_pp - start_pp) * 1000)

print()

# bytes_used = instance.exports(store)["bytes_used"].value(store)
print(
    f"Benchmark {path}:"
    + "{{"
    + f'"time_instantiate": "{time_inst}", "time_main": "{time_main}", "time_pp": "{time_pp}"'
    + "}} ms."
)
