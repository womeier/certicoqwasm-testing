# Testing CertiCoq-Wasm

This repo contains scripts and examples for testing [CertiCoq-Wasm](https://github.com/womeier/certicoqwasm).

## Setup (Linux/Mac)
- CertiCoq-Wasm ([installation](https://github.com/womeier/certicoqwasm))
- Node.js ([installation](https://nodejs.org/en/download/package-manager), version 22 or higher)
- wasm-tools (cargo install wasm-tools)
```
# Check the setup
git clone https://github.com/womeier/certicoqwasm-testing
cd certicoqwasm-testing/examples/certicoqwasm && make
```

## Usage
For some small examples see `foo.v`, `sha.v` and the Makefile in `examples/certicoqwasm/`.
Compiling each Coq file generates a `.wasm` file that can be run with e.g. Node.js, run `make help` to see how.

The JavaScript files specify pretty-printing the result. For Coq's most common types we have pp functions in `evaluation/pp.js`, see `sha.js` on how to use.

The generation of pp functions is not yet automated, the reader is welcome to create an issue for help.
(We currently use CertiCoq-Wasm's `debugging` branch and `CertiCoq Generate Wasm -debug` to get the constructor environment,
and the constructors' ordinals, they're the same as with CertiCoq's C backend.)

Note that a `package.json` may be required for JavaScript imports.

## Performance Evaluation
### Setup
- wabt (apt install wabt)
- binaryen (nix profile install nixpkgs#binaryen, version 117 or higher)
- wasmtime (nix profile install nixpkgs#wasmtime, most recent version, at least version 18)
- python bindings for wasmtime (pip install wasmtime, must be same version as wasmtime)
```
# in evaluation/
./benchmark.py --engine=node --folder ./binaries/non-cps-cleanup-oct-13-24 --wasm-opt -O2
./benchmark.py --help
```
<details>
<summary> More evaluation </summary>
<br>

### Adding new CertiCoq-Wasm binaries for evaluation
1) Create branch in main repo `benchmarks_<NAME>`
1) Create folder with name `<NAME>` in `./evaluation/binaries/`, put binaries in it
3) Insert folder with short description in `./evaluation/benchmark.py`, possibly update program list
4) Then you can run the benchmark as described above.
5) Add the expected result in file in `./evaluation/results`
6) Run the `./evaluation/sanity-checks.py` script.

### Evaluation of other extraction mechanisms
To evaluate the extraction via Rust (more [information](./evaluation/rust_to_wasm/setup.md)), run the following in `evaluation/rust_to_wasm/`:
```
./benchmark.py --folder ./binaries/unchecked_arith/
```
<br>

To evaluate the extraction via OCaml (more [information](./evaluation/ocaml_to_wasm/setup.md)), run the following in `evaluation/ocaml_to_wasm/`:
```
./benchmark.py --folder ./binaries/
```
<br>

To evaluate the extraction via C and emscripten (more [information](./evaluation/c_to_wasm/setup.md)), run the following in `evaluation/c_to_wasm`:
```
./benchmark.py --folder ./binaries/
```

To evaluate the extraction via Malfunction (more [information](./evaluation/malfunction_to_wasm/setup.md)), run the following in `evaluation/malfunction_to_wasm`:
```
./benchmark.py --folder ./binaries/
```
<br>
</details>

## Demo applications
### SHA256 website demo (integrate with JavaScript)
In `demo_website_sha256/`, start dev-browser by:
```
make develop
```

### Blockchain demo (integrate with Wasm)
In `demo_blockchain_smartcontract/`, run some tests (more [information](./demo_blockchain_smartcontract/)) for the smart contract `counter` by:
```
make run-concordium-test
```

## Miscellaneous
- Small Wasm example programs in `examples/wasm/`
- Small WasmCert example proofs in `examples/wasmcert/` (including a script `wasm_to_coq.py` to import .wasm file to Coq)
