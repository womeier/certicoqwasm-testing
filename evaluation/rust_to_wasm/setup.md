# Setup:
extracted Coq -> Rust -> Wasm via

# Steps to add binaries
1) run `wasm-pack build --target nodejs` in root of rust project
2) cp pkg/*.wasm into binaries/, remove "_bg" ending, add to Makefile to correct import name
3) RUN with run-node.js! (node needs `--stack-size=1000000` for some of them, e.g. ack)

# Binaries:
both are compiled with `rustc -O3, wasm-opt -O3`
certicoq-wasm repo, branch rustextraction: cd0f3142
## unchecked_arith uses
From RustExtraction Require Import ExtrRustUncheckedArith.
## naive doesn't use that

# Manual fixes:
### stack_machine:
only derive Clone, not Debug for:
`pub enum CertiCoq_Benchmarks_lib_stack_machine_Numeric<'a, A> `

### vs_easy/vs_hard
- `%s/loop/loop42/g`
- still sth. wrong TODO

### color
- doesn't compile, binary too large for rustc

### sha:
- works for naive extraction, with mapping needs additional type annotation

# Known to run
## naive
- demo1 demo2 list_sum sha sm_gauss_N even_10000 binom
- ack_3_9 with `--stack-size=1000000`
- sm_gauss_nat, bernstein_yang: mem access out of bounds
