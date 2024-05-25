# Testing certicoqwasm

This repo contains scripts and examples for testing [certicoqwasm](https://github.com/womeier/certicoqwasm).

## Requirements & Setup
Note, that CertiCoq-Wasm is not necessary to run the benchmarks.
- CertiCoq with wasm backend: [certicoqwasm](https://github.com/womeier/certicoqwasm).
- Node.js (version 22 or higher)
- python 3
- binaryen (version 117 or higher)
- Rust (e.g. 1.77)
- wasm-tools: [installation](https://github.com/bytecodealliance/wasm-tools)


## Performance evaluation CertiCoq-Wasm binaries
See [here](./evaluation/evaluation-wolfgang.md) (outdated) and [here](./evaluation/evaluation_27_03_24.org) for some performance comparisons.

### Run CertiCoq-Wasm binaries with Node.js
In `evaluation`, run:
```
./benchmark.py --engine=node --folder ./binaries/non-cps-primops-may-21-24 --wasm-opt --coalesce-locals
```

### Run CertiCoq-Wasm binaries with wasmtime
In `evaluation`, run:
```
./benchmark.py --engine=wasmtime --folder ./binaries/non-cps-primops-may-21-24 --wasm-opt --coalesce-locals
```

### Run CertiCoq-Wasm binaries with wasmtime-compile
In `evaluation`, run:
```
./benchmark.py --engine=wasmtime-compile --folder ./binaries/non-cps-primops-may-21-24 --wasm-opt --coalesce-locals
```

Note, that wasmtime-compile is currently not supported. (Could be supported by removing the unused imports.)

### Running the benchmarks
Wasmtime requires the installation of wasmtime-py, version 18 or later.
`pip install "wasmtime>=18.0.0"`

### How to add new CertiCoq-Wasm binaries
1) Create branch in main repo `benchmarks_<NAME>`
1) Create folder with name `<NAME>` in `./evaluation/binaries/`, put binaries in it
3) Insert folder with short description in `./evaluation/benchmark.py`, possibly update program list
4) Then you can run the benchmark with e.g. `cd evaluation && ./benchmark.py --folder ./binaries/non-cps-primops-may-21-24 --wasm-opt --coalesce-locals`
5) Add the expected result in file in `./evaluation/results`
6) Run the `./evaluation/sanity-checks.py` script.


## Performance evaluation Rust -> Wasm binaries
In `evaluation/rust_to_wasm`, run:
```
./benchmark.py --folder ./binaries/unchecked_arith/
```

## Performance evaluation OCaml -> Wasm binaries
In `evaluation/wasm_of_ocaml`, run:
```
./benchmark.py --folder ./binaries/
```
See [./evaluation/wasm_of_ocaml/setup.md](./evaluation/wasm_of_ocaml/setup.md) for more information

## Performance evaluation C -> Wasm binaries
In `evaluation/c_to_wasm_emscripten`, run:
```
./benchmark.py --folder ./binaries/
```
See [./evaluation/c_to_wasm_emscripten/setup.md](./evaluation/c_to_wasm_emscripten/setup.md) for more information

## Demos

### Quick sha256 demo (unrelated to sha demo website)
This compiles extracts a sha256 sum (taken from A.W. Appel) to wasm and runs it with Node.js.
Run `make sha`, or `make sha_explicit`.

### sha256 website demo
In `website_demo_sha256`, start dev-browser by:
```
make develop
```

## Test import script for WasmCert
The script `wasm_to_coq.py` takes a given .wasm file and outputs a Coq file, importing the binary to WasmCert-Coq.
