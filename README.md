# Testing certicoqwasm

This repo contains scripts and examples for testing [certicoqwasm](https://github.com/womeier/certicoqwasm).

### Performance evaluation
See [here](./evaluation/evaluation.md) for some performance comparisons.

#### How to add new binaries for evaluation
1) Create folder in `./evaluation/binaries/`, put binaries in it and a file `TESTS`
2) Insert folder with short description in `./evaluation/benchmark.py` (don't forget trailing /)
3) Then you can run the benchmark with e.g. `cd evaluation && ./benchmark.py --engine=node --folder ./binaries/cps-feb-01-24/`
4) Add expected result in file in `./evaluation/results`
5) Provide sha of version to include in `./evaluation/evaluation.md`
6) Run the `./evaluation/sanity-checks.py` script.

Wasmtime requires installation of wasmtime and wasmtime-py including this [PR](https://github.com/bytecodealliance/wasmtime-py/pull/205).

### Checking result of CertiCoq wasm backend
Run `make sha` to export the computation of a sha256 sum (taken from A.W. Appel) to wasm and run it with nodejs.

### Import wasm program in Coq
The script `wasm_to_coq.py` takes a given .wasm file and outputs the byte-list that can be parsed using WasmCert-Coq.


### Requirements
- CertiCoq with wasm backend: [certicoqwasm](https://github.com/womeier/certicoqwasm).
- nodejs
- python3
- webassembly toolkit (wabt in Ubuntu)
