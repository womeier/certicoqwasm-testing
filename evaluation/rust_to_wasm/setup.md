# Plan:
Coq --[coq-rust-extraction]--> Rust ----[wasm-pack/wasm-bindgen]--> Wasm

## General:
- See the setup [here](https://github.com/womeier/certicoqwasm/tree/rustextraction)
- rust code is compiled with `rustc -O3`
- naive: no mapping from nats to Rust native i64s
- unchecked_arith: mapping from nats to Rust native i64s `From RustExtraction Require Import ExtrRustUncheckedArith.`


## Steps to add binaries
1) run `wasm-pack build --target nodejs` in root of rust project
2) cp pkg/*.wasm into `binaries/{naive/unchecked_arith}`, remove "_bg" ending, update and run script `replace.sh` to correct import name
3) RUN with run-node.js! (node needs `--stack-size=1000000` for some of them, e.g. ack)

## Manually applied fixes:
- stack_machine: only derive Clone, not Debug for `pub enum CertiCoq_Benchmarks_lib_stack_machine_Numeric<'a, A> `
- vs_easy/vs_hard: `%s/loop/loop42/g`, still sth. wrong TODO
- bernstein_yang (unchecked_arith): needed type-annotations for anonymous lambdas (-> annotated i64)
- color (naive): rustc takes forever to compile, too large? TODO try on Martin's laptop
- sha (unchecked_arith) needs additional type annotations at anonymous lambdas (-> annotated i64)

## Known to run (some of them need `node --stack-size=10000000`)
### naive
- demo1 demo2 list_sum sha_fast sm_gauss_N even_10000 binom ack_3_9
### unchecked_arith
- demo1 demo2 list_sum sha_fast sm_gauss_N even_10000 binom ack_3_9 color

## Known to fail
see https://github.com/rustwasm/wasm-bindgen/issues/3910
- sm_gauss_nat, bernstein_yang (both naive, unchecked_arith): mem access out of bounds
