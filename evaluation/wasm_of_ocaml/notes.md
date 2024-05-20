# Notes on wasm_of_ocaml binaries

- Requires `node` v22.1.0
- Run with `node <benchmark>.js`
- The result is pretty printed
- The execution time of the wasm module is printed (note that this includes pretty printing)
- The ocaml code extracted from the color benchmark does not typecheck, and so is not included here
- The extraction of the sm_gauss_PrimInt benchmark requires specifying an ocaml implementation for the Uint63 operations, and so is not included here
