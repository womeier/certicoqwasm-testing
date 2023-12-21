# testing-certicoqwasm

This repo contains scripts and examples for testing [certicoqwasm](https://github.com/womeier/certicoqwasm).

### Checking result of CertiCoq wasm backend
Run `make sha` to export the computation of a sha256 sum (taken from A.W. Appel) to wasm and run it with nodejs.

### import wasm program in Coq
The script `wasm_to_coq.py` takes a given .wasm file and outputs the byte-list that can be parsed using WasmCert-Coq.


### Requirements
- CertiCoq with wasm backend: [certicoqwasm](https://github.com/womeier/certicoqwasm).
- nodejs
- python3
- webassembly toolkit (wabt in Ubuntu)
