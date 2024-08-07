# Experimental compilation of a ConCert smart contract to Wasm (Concordium)

## Setup and versions
The binary `certicoqwasm/src/COUNTER_MODULE.wasm` is generated by CertiCoq-Wasm using:
- Coq 8.17
- MetaCoq v1.3-8.17
- [ConCert](https://github.com/womeier/ConCert) (95d1c12)
- [CertiCoq-Wasm](https://github.com/womeier/certicoqwasm/tree/demo_smartcontracts)

## Running it
### Node.js demo
One only needs Node.js 22 installed. The files are located in `node/`,
the Wasm file is generated by standard CertiCoq-Wasm (an old version, but the current one would likey also work with small fixes).

Type `make run-node` to run.

### Running local tests
One needs Rust (e.g. version 1.77.2, but shouldn't matter I guess), wasm-tools, wabt installed.

Type `make run-concordium-test` to run, this will run the
smart contract extracted via CertiCoq-Wasm (Concordium blockchain API bindings are hand-written).

### Deploying to Concordium testnet
See [here](./deployment) for more information.
