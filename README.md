# Testing certicoqwasm

This repo contains scripts and examples for testing [certicoqwasm](https://github.com/womeier/certicoqwasm).

### Performance evaluation
See [here](./evaluation/evaluation-wolfgang.md) (outdated) and [here](./evaluation/evaluation_27_03_24.org) for some performance comparisons.

#### How to add new binaries for evaluation
1) Create folder in `./evaluation/binaries/`, put binaries in it
2) Insert folder with short description in `./evaluation/benchmark.py`, possibly update program list
3) Then you can run the benchmark with e.g. `cd evaluation && ./benchmark.py --engine=node --folder ./binaries/cps-feb-01-24/`
4) Add expected result in file in `./evaluation/results`
5) Run the `./evaluation/sanity-checks.py` script.

Wasmtime requires the installation of wasmtime and wasmtime-py, version 18 or later.
`pip install "wasmtime>=18.0.0"`

### Checking result of CertiCoq wasm backend
Run `make sha` to export the computation of a sha256 sum (taken from A.W. Appel) to wasm and run it with Node.js.

### Import wasm program in Coq
The script `wasm_to_coq.py` takes a given .wasm file and outputs the byte-list that can be parsed using WasmCert-Coq.


### Requirements
- CertiCoq with wasm backend: [certicoqwasm](https://github.com/womeier/certicoqwasm).
- Node.js (version 22 or higher)
- python 3
- binaryen (version 117 or higher)
- wasm-tools: [installation](https://github.com/bytecodealliance/wasm-tools)
