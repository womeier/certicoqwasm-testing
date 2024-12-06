# Running the benchmarks compiled from the C code to Wasm with emscripten

To run the individual benchmarks, run  `node --stack-size=1000000 run_node.js binaries <benchmark>` from this folder, where `<bencmark>` is the name of one of the benchmarks. This will also measure and print start up, execution and pretty printing time.

Run `python benchmark.py --folder binaries` to run and print time for all benchmarks. Optionally specify optmization level `O1` or `O2` by adding `--opt`, for example: `python benchmark.py --folder binaries --opt O1`

Note that
- the `sha_fast` benchmark does not run without optimization level `O1` or `O2`, as the generated binary has a function with too many locals
- some of the benchmarks do not pretty print the correct result (or anything, for that matter) without optimization level `O1` or `O2`

# Compiling CertiCoq generated C code to Wasm with emscripten

## Instructions

Make sure `emsdk` is installed and that the `emcc` command is available.

From certicoq/ directory
1. `cd benchmarks`
2. Generate C code for the benchmarks. Make sure to also generate glue code and have a main/ 'driver' file to run the benchmark.
3. To compile a benchmark, run `emcc -o <benchmark>.js -w -Wno-everything -I../plugin/runtime <benchmark>_main.c ../plugin/runtime/gc_stack.c CertiCoq.Benchmarks.wasm.tests.<benchmark>.c glue_<benchmark>.c -sALLOW_MEMORY_GROWTH=1 -sINITIAL_MEMORY=1GB -sSTACK_SIZE=500000000`
4. This will create a binary file `binom.wasm` and a JavaScript scaffolding file `binom.js`
5. To run the benchmark, execute e.g. `node --stack-size=1000000 binom.js`.

To use the pretty printing functions defined in the C glue code from the JS scaffolding, enable the `ccall` runtime method and mark the pretty printing function and main function for export during compilation.

The exact command that was used to compile the binaries (optionally add an optimization level):
```
emcc -o <benchmark>.js -w -Wno-everything -I../plugin/runtime <benchmark>_main_wasm_no_pp.c ../plugin/runtime/gc_stack.c CertiCoq.Benchmarks.wasm.tests.<benchmark>.c ../plugin/runtime/prim_int63.c glue_<benchmark>.c -sALLOW_MEMORY_GROWTH=1 -sINITIAL_MEMORY=1GB -sSTACK_SIZE=500000000 -sEXPORTED_FUNCTIONS=_main,_pp -sEXPORTED_RUNTIME_METHODS=ccall
```

Note that the stack size and initial memory was increased a lot to allow some of the benchmarks to run.
