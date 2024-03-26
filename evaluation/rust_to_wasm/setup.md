# setup:
extracted Coq -> Rust -> Wasm via

# steps to add binaries
1) run `wasm-pack build --target nodejs` in root of rust project
2) cp pkg/*.wasm into binaries/, remove "_bg" ending, add to Makefile to correct import name
3) RUN with run-node.js!

# binaries:
both are compiled with `rustc -O3, wasm-opt -O3`
certicoq-wasm repo, branch rustextraction: cd0f3142
## unchecked_arith uses
From RustExtraction Require Import ExtrRustUncheckedArith.
## naive doesn't use that
