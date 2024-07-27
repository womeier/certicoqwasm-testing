# Testing certicoqwasm

This repo contains scripts and examples for testing [CertiCoq-Wasm](https://github.com/womeier/certicoqwasm).

## Requirements & Setup
### For running the benchmarks
- Python
- Node.js (version 22 or higher)
- binaryen (version 117 or higher)
- Rust (e.g. 1.77) and wasm-tools (cargo install wasm-tools)
- wabt
- wasmtime and wasmtime-py, version 18 or later
  
### For development
- CertiCoq with wasm backend: [certicoqwasm](https://github.com/womeier/certicoqwasm)


## Evaluation
### How to run CertiCoq-Wasm binaries
To evaluate CertiCoq-Wasm binaries with Node.js, run the following in `evaluation/`:
```
./benchmark.py --engine=node --folder ./binaries/non-cps-primops-may-21-24 --wasm-opt --coalesce-locals
```

To evaluate CertiCoq-Wasm binaries with wasmtime, run the following in `evaluation/`:
```
./benchmark.py --engine=wasmtime --folder ./binaries/non-cps-primops-may-21-24 --wasm-opt --coalesce-locals
```

To evaluate CertiCoq-Wasm binaries with wasmtime-compile, run the following in `evaluation/`:
```
./benchmark.py --engine=wasmtime-compile --folder ./binaries/non-cps-primops-may-21-24 --wasm-opt --coalesce-locals
```

Note, that wasmtime-compile is only supported for the recent versions of CertiCoq-Wasm.

### How to add new CertiCoq-Wasm binaries for evaluation
1) Create branch in main repo `benchmarks_<NAME>`
1) Create folder with name `<NAME>` in `./evaluation/binaries/`, put binaries in it
3) Insert folder with short description in `./evaluation/benchmark.py`, possibly update program list
4) Then you can run the benchmark with e.g. `cd evaluation && ./benchmark.py --folder ./binaries/non-cps-primops-may-21-24 --wasm-opt --coalesce-locals`
5) Add the expected result in file in `./evaluation/results`
6) Run the `./evaluation/sanity-checks.py` script.

## Evaluation of other extraction mechanisms
To evaluate the extraction via Rust (more [information](./evaluation/rust_to_wasm/setup.md)), run the following in `evaluation/rust_to_wasm/`:
```
./benchmark.py --folder ./binaries/unchecked_arith/
```

<br>

To evaluate the extraction via OCaml (more [information](./evaluation/wasm_of_ocaml/setup.md)), run the following in `evaluation/wasm_of_ocaml/`:
```
./benchmark.py --folder ./binaries/
```
<br>

To evaluate the extraction via C and emscripten (more [information](./evaluation/c_to_wasm_emscripten/setup.md)), run the following in `evaluation/c_to_wasm_emscripten`:
```
./benchmark.py --folder ./binaries/
```

# Demos
## SHA256 website demo
In `demo_website_sha256/`, start dev-browser by:
```
make develop
```

## Blockchain demo
In `demo_blockchain_smartcontract/`, run some tests for the smart contract `counter` by:
```
make run-concordium-test
```
See [here](./demo_blockchain_smartcontract/) for more information.

# Other
- The script `wasm_to_coq.py` takes a given .wasm file and outputs a Coq file, importing the binary to WasmCert-Coq.
- Compile an example program with CertiCoq-Wasm and run the generated Wasm binary: `make sha` or `make sha_explicit`.
