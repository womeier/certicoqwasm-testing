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

### bernstein_yang
- unchecked_arith: needed type-annotations for anonymous lambda functions (i64)

### color
- naive: doesn't compile, binary too large for rustc
- unchecked_arith: works

### sha:
- works for naive extraction
- unchecked_arith: needs additional type annotations at anonymous lambdas (i64)

# Known to run
- for some of them you need node --stack-size=10000000
## naive
- demo1 demo2 list_sum sha_fast sm_gauss_N even_10000 binom ack_3_9
## unchecked_arith
- demo1 demo2 list_sum sha_fast sm_gauss_N even_10000 binom ack_3_9

# Known to fail
see https://github.com/rustwasm/wasm-bindgen/issues/3910
## naive
- sm_gauss_nat, bernstein_yang: mem access out of bounds
## unchecked_arith
- sm_gauss_nat, bernstein_yang: mem access out of bounds
