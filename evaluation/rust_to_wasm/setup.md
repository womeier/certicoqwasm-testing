# setup:
extracted Coq -> Rust -> Wasm via

# steps to add binaries
1) run
wasm-pack build --target nodejs
in root of rust project
2)
cp pkg/*.wasm into binaries/, remove "_bg" ending, add to Makefile to correct import name
3) RUN with run-node.js!

# binaries:
certicoq-wasm repo, branch rustextraction: cd0f3142
## uses:
From RustExtraction Require Import ExtrRustUncheckedArith.
