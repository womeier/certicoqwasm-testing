from wasmtime import Store, Module, Instance, Func, FuncType, ValType, Config, Engine
import sys
import time

config = Config()
config.wasm_tail_call = True

# Shared amongst objects
store = Store(Engine(config))

# Here we can compile a `Module` which is then ready for instantiation
# afterwards
module = Module.from_file(store.engine, "./color-tail.wasm")


# Our module needs two imports
def print_int(n):
    sys.stdout.write(str(n))


def print_char(n):
    sys.stdout.write(str(chr(n)))


print_char_stdout = Func(store, FuncType([ValType.i32()], []), print_char)
print_int_stdout = Func(store, FuncType([ValType.i32()], []), print_int)

# instantiate module
instance = Instance(store, module, [print_char_stdout, print_int_stdout])

# run main
start = time.time()
instance.exports(store)["$main_function"](store)
end = time.time()

result = instance.exports(store)["result"].value(store)
sys.stdout.write("====> ")
instance.exports(store)["$pretty_print_constructor"](store, result)
print()

bytes_used = instance.exports(store)["bytes_used"].value(store)
ms = round((end - start) * 1000, 2)
print(f"====> Used {bytes_used} bytes of memory, took {ms} ms (wasmtime).")
print()
