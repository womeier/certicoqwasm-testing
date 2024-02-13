Evaluation of CertiCoq-Wasm
---------------------------

#### CPS vs non-CPS, all 0ary constrs boxed (naive)

|      |                |  vs_easy | vs_hard |  sha_fast | binom | comment            | reproduce
|-----:|:---------------|---------:|--------:|----------:|------:|:-------------------|----------
|    C | (gcc -O2)      |     7 ms |   44 ms |     35 ms |  6 ms | CPS (in CoqPL'24)  | [code](https://github.com/womeier/certicoqwasm/tree/eval-ccomp) with Makefile[gcc/ccomp]
|    C | (CompCert -O2) |    10 ms |   59 ms |     43 ms | 16 ms | CPS (in CoqPL'24)  | [code](https://github.com/womeier/certicoqwasm/tree/eval-ccomp)
| Wasm | (Node.js)      |    81 ms |  700 ms |    190 ms | 13 ms | CPS (in CoqPL'24)  | [code](https://github.com/womeier/certicoqwasm/commit/1518307d8e6897fdd9d43c73d381ab4b9fe37e90), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/cps-feb-01-24)
| Wasm | (Node.js)      |    31 ms |  101 ms |     71 ms | 21 ms | non-CPS, WasmCert tail calls | [code](https://github.com/womeier/certicoqwasm/commit/cdf266a2a5998a4e269a1fd25147a39c430cd502), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-PROPER-feb-07-24)

#### 0ary constr. boxed vs. unboxed
|      |                |  vs_easy | vs_hard |  sha_fast | binom | comment            | reproduce
|-----:|:---------------|---------:|--------:|----------:|------:|:-------------------|----------
| Wasm | (Node.js)      |    31 ms |  101 ms |     71 ms | 21 ms | non-CPS, WasmCert tail calls | [code](https://github.com/womeier/certicoqwasm/commit/cdf266a2a5998a4e269a1fd25147a39c430cd502), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-PROPER-feb-07-24)
| Wasm | (Node.js)      |    31 ms |   98 ms |     72 ms | 10 ms | non-CPS, WasmCert tail calls, 0ary fast | [code](https://github.com/womeier/certicoqwasm/commit/7c502b15), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-PROPER-0aryfast-feb-13-24)
| Wasm | (Node.js)      |    81 ms |  700 ms |    190 ms | 13 ms | CPS (in CoqPL'24)  | [code](https://github.com/womeier/certicoqwasm/commit/1518307d8e6897fdd9d43c73d381ab4b9fe37e90), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/cps-feb-01-24)
| Wasm | (Node.js)      |    74 ms |  620 ms |    197 ms | 11 ms | CPS, 0ary fast  | [code](https://github.com/womeier/certicoqwasm/commit/6cf5c81f), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/cps-0aryfast-feb-13-24)


#### Binaryen optimizations (binaryen version 108)
|      |                |  vs_easy | vs_hard |  sha_fast | binom | comment            | reproduce
|-----:|:---------------|---------:|--------:|----------:|------:|:-------------------|----------
| Wasm | (Node.js)      |    31 ms |   98 ms |     72 ms | 10 ms | non-CPS, WasmCert tail calls, 0ary fast (fastest from above) | [code](https://github.com/womeier/certicoqwasm/commit/7c502b15), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-PROPER-0aryfast-feb-13-24)
| Wasm | (Node.js)      |    26 ms |   84 ms |     57 ms | 7 ms | non-CPS, WasmCert tail calls, 0ary fast (fastest from above), binaryen -O2 | [code](https://github.com/womeier/certicoqwasm/commit/7c502b15), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-PROPER-0aryfast-feb-13-24)
| Wasm | (Node.js)      |    25 ms |   80 ms |     56 ms | 6 ms | non-CPS, WasmCert tail calls, 0ary fast (fastest from above), binaryen -O3 | [code](https://github.com/womeier/certicoqwasm/commit/7c502b15), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-PROPER-0aryfast-feb-13-24)

TODO:
- wasmtime
- emscripten
- rust, concert
- more benchmarks
- instantiation: binaryen optimization -O2 reduces instantiation time drastically, investigate which opt is responsible
