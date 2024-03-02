# Running the benchmarks compiled from the C code to Wasm with emscripten

To run the binaries, run  `node run_node_emscripten.js emscripten_binaries <program>` from this folder, where `<program>` is the name of one of the benchmarks. This will also measure and print start up, execution and pretty printing time.


# Compiling CertiCoq generated C code to Wasm with emscripten

## Instructions

Make sure emsdk is installed and that the `emcc` command is available.

From certicoq/ directory
1. cd benchmarks
2. Generate C code for the benchmarks. Make sure to also generate glue code and have a main/ 'driver' file to run the benchmark.
3. **In the glue code, it is important to remove the declared external function `printf` at the top of the file**, as this clashes with the `printf` that emscripten uses, which causes the generated Wasm code to trap everytime `printf` is called.
4. To compile e.g. the binom benchmark, run `emcc -O1 -o binom -o binom.js -w -Wno-everything -I../plugin/runtime binom_main.c ../plugin/runtime/gc_stack.c CertiCoq.Benchmarks.tests_emscripten.binom.c glue.CertiCoq.Benchmarks.tests_emscripten.binom.c -sSTACK_SIZE=327680 --profiling`
5. This will create a binary file `binom.wasm` and a JavaScript scaffolding file `binom.js`
6. To run the benchmark, execute e.g. `node binom.js`.

To use the pretty printing functions defined in the C glue code from the JS scaffolding, enable the `ccall` runtime method and mark the pretty printing function for export during compilation, e.g.

`emcc -O1 -o binom -o binom.js -w -Wno-everything -I../plugin/runtime binom_main.c ../plugin/runtime/gc_stack.c CertiCoq.Benchmarks.tests_emscripten.binom.c glue.CertiCoq.Benchmarks.tests_emscripten.binom.c -sSTACK_SIZE=327680 -sEXPORTED_RUNTIME_METHODS=ccall -sEXPORTED_FUNCTIONS=_main,_pp`

See `run_node_emscripten.js` (line 952) for how to call the `pp` function (note that the main/ driver code for these benchmarks has been modified to return the computed value).

## Notes

- The above was only tested for the benchmarks `binom`, `vs_easy`, `vs_hard` and `sha_fast`.
- The option `-O1` was added because some benchmarks generated Wasm functions with too many locals
- The default stack size was increased from 65532 to 327680 because some benchmarks caused a stack overflow
