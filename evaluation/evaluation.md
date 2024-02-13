Evaluation of CertiCoq-Wasm
---------------------------

#### CPS vs non-CPS, all 0ary constrs boxed (naive)

|      |                |  vs_easy | vs_hard |  sha_fast | binom | comment            | reproduce
|-----:|:---------------|---------:|--------:|----------:|------:|:-------------------|----------
|    C | (gcc -O2)      |     7 ms |   44 ms |     35 ms |  6 ms | CPS (in CoqPL'24)  | [code](https://github.com/womeier/certicoqwasm/tree/eval-ccomp) with Makefile[gcc/ccomp]
|    C | (CompCert -O2) |    10 ms |   59 ms |     43 ms | 16 ms | CPS (in CoqPL'24)  | [code](https://github.com/womeier/certicoqwasm/tree/eval-ccomp)
| Wasm | (Node.js)      |    81 ms |  700 ms |    190 ms | 13 ms | CPS (in CoqPL'24)  | [code](https://github.com/womeier/certicoqwasm/commit/1518307d8e6897fdd9d43c73d381ab4b9fe37e90), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/cps-feb-01-24)
| Wasm | (Node.js)      |    31 ms |  101 ms |     71 ms | 21 ms | non-CPS, WasmCert tail calls | [code](https://github.com/womeier/certicoqwasm/commit/cdf266a2a5998a4e269a1fd25147a39c430cd502), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-PROPER-feb-07-24)
| Wasm | (Node.js)      |    31 ms |   98 ms |     72 ms | 10 ms | non-CPS, WasmCert tail calls, 0ary fast | [code](https://github.com/womeier/certicoqwasm/commit/7c502b15), [binaries](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-PROPER-0aryfast-feb-13-24)


TODO

| Wasm | (Node.js opt -O2)      |  TODO  | TODO   |  TODO   | TODO  | CPS, binaryen -O2 [cps-binaryen-Wasm](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/cps-feb-01-24)
| Wasm | (Node.js)      |    75 ms |  550 ms |   TODO ms | 11 ms | CPS, 0ary constr. unboxed

TODO
Wasm | (Node.js)              |  TODO ms | TODO ms  |   TODO ms | TODO    % non-CPS, 0ary constr. unboxed

Wasm | (wasmtime)     |   ms     |  ms   |   ms    |  ms   % CPS, new
Wasm | (wasmtime)     |   ms     |  ms   |   ms    |  ms   % non-CPS, new
