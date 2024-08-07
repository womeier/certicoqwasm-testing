Evaluation of CertiCoq-Wasm
---------------------------

Note: the execution times don't include instantiation, which can be significiant for Node.js v18.19 (over a second for some benchmarks)
TODO measure with new Node.js version

#### CPS vs non-CPS, all 0ary constrs boxed (naive)

|      |                |  vs_easy | vs_hard |  sha_fast | binom | comment            | reproduction
|-----:|:---------------|---------:|--------:|----------:|------:|:-------------------|------------------------
|    C | (gcc -O2)      |     7 ms |   44 ms |     35 ms |  6 ms | CPS (in CoqPL'24)  | benchmarks_ccomp with Makefile[gcc/ccomp]
|    C | (CompCert -O2) |    10 ms |   59 ms |     43 ms | 16 ms | CPS (in CoqPL'24)  | benchmarks_ccomp
| Wasm | (Node.js)      |    81 ms |  700 ms |    190 ms | 13 ms | CPS (in CoqPL'24)  | benchmarks_cps-feb-01-24, [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/cps-feb-01-24)
| Wasm | (Node.js)      |    31 ms |  101 ms |     71 ms | 21 ms | non-CPS, WasmCert tail calls | benchmarks_non-cps-feb-07-24, [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-feb-07-24)



#### 0ary constr. boxed vs. unboxed

##### Run time

|      |                |  vs_easy | vs_hard |  sha_fast | binom | comment                      | reproduce
|-----:|:---------------|---------:|--------:|----------:|------:|:-----------------------------|----------
| Wasm | (Node.js)      |    31 ms |  101 ms |     71 ms | 21 ms | non-CPS, WasmCert tail calls | benchmarks_non-cps-feb-07-24, [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-feb-07-24)
| Wasm | (Node.js)      |    31 ms |   98 ms |     72 ms | 10 ms | non-CPS, WasmCert tail calls, 0ary fast | benchmarks_non-cps-0aryfast-return-feb-26-24 [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-0aryfast-return-feb-26-24)
| Wasm | (Node.js)      |    81 ms |  700 ms |    190 ms | 13 ms | CPS (in CoqPL'24)  | benchmarks_cps-feb-01-24
| Wasm | (Node.js)      |    74 ms |  620 ms |    197 ms | 11 ms | CPS, 0ary fast     | benchmarks_cps-0aryfast-feb-13-24, [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/cps-0aryfast-feb-13-24)

##### Memory usage


|      |                |  vs_easy  |   vs_hard |  sha_fast |  binom | comment                                | reproduce
|-----:|:---------------|----------:|----------:|----------:|-------:|:---------------------------------------|----------
| Wasm | (Node.js)      |  20826 kb | 142740 kb |  74779 kb | 504 kb | Boxed 0-ary constructors (in CoqPL'24) | benchmarks_cps-feb-01-24
| Wasm | (Node.js)      |   6128 kb |  38141 kb |  25642 kb | 248 kb | Unboxed 0-ary constructors             | benchmarks_cps-0aryfast-feb-13-24

On average, unboxed 0-ary constructors yield a ~65% decrease in memory consumption across the benchmarks. This table is false, the lower is probably non-cps?

#### Binaryen optimizations (binaryen version 108)
|      |                |  vs_easy | vs_hard |  sha_fast | binom | comment            | reproduce
|-----:|:---------------|---------:|--------:|----------:|------:|:-------------------|----------
| Wasm | (Node.js)      |    31 ms |   98 ms |     72 ms | 10 ms | non-CPS, WasmCert tail calls, 0ary fast (from above)               | see above
| Wasm | (Node.js)      |    26 ms |   84 ms |     57 ms |  7 ms | non-CPS, WasmCert tail calls, 0ary fast (from above), binaryen -O2 | see above
| Wasm | (Node.js)      |    25 ms |   80 ms |     56 ms |  6 ms | non-CPS, WasmCert tail calls, 0ary fast (from above), binaryen -O3 | see above

TODO:
- emscripten, wasmtime, rust-concert
- more benchmarks
