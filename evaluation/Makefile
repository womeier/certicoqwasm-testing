LATEST="./binaries/non-cps-grow-mem-func-mrch-24-24"
ENGINE="node"
# ENGINE="wasmtime"

help:
	@echo "See the other targets for examples on how to run benchmarks."
	@echo "e.g. make latest-O2"

latest-coalesce-locals:
	./benchmark.py --folder ${LATEST} --engine ${ENGINE} --wasm-opt --coalesce-locals

latest-O1:
	./benchmark.py --folder ${LATEST} --engine ${ENGINE} --wasm-opt -O1

# no difference with wasm-opt 117
#latest-O1-noinline-memgrow:
#	./benchmark.py --folder ${LATEST} --engine ${ENGINE} --wasm-opt --no-inline=grow_mem_if_necessary --wasm-opt -O1

latest-O2:
	./benchmark.py --folder ${LATEST} --engine ${ENGINE} --wasm-opt -O2

# no difference with wasm-opt 117
#latest-O2-noinline-memgrow:
#	./benchmark.py --folder ${LATEST} --engine ${ENGINE} --wasm-opt --no-inline=grow_mem_if_necessary --wasm-opt -O2

wasmgc-best:
	./benchmark.py --folder ./binaries/non-cps-wasmgc-may-16-24/ --engine node --wasm-opt -O2 --wasmgc-cast-nochecks
