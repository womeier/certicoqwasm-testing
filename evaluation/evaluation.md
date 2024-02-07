Evaluation of CertiCoq-Wasm
---------------------------

#### CPS vs non-CPS, all 0ary constrs boxed (naive)

For non-cps, PROPER: tail calls for all tailcalls, BAD: normal calls instead of tail calls (script can't handle mix of both normal and tail calls).

|      |                |  vs_easy | vs_hard |  sha_fast | binom | comment          | reproduce
|-----:|:---------------|---------:|--------:|----------:|------:|------------------|----------
|    C | (gcc -O2)      |     7 ms |   44 ms |     35 ms |  6 ms | CPS              | [cps-gcc](https://github.com/womeier/certicoqwasm/tree/eval-ccomp) with Makefile[gcc/ccomp]
|    C | (CompCert -O2) |    10 ms |   59 ms |     43 ms | 16 ms | CPS              | [cps-ccomp](https://github.com/womeier/certicoqwasm/tree/eval-ccomp)
| Wasm | (Node.js)      |    81 ms |  700 ms |    190 ms | 13 ms | CPS              | [cps-Wasm](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/cps-feb-01-24)
| Wasm | (Node.js)      |    31 ms |  101 ms |     71 ms | 21 ms | non-CPS          | [non-cps-Wasm](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/non-cps-PROPER-feb-07-24)


TODO

| Wasm | (Node.js opt -O2)      |  TODO  | TODO   |  TODO   | TODO  | CPS, binaryen -O2 [cps-binaryen-Wasm](https://github.com/womeier/certicoqwasm-testing/tree/master/evaluation/binaries/cps-feb-01-24)
| Wasm | (Node.js)      |    75 ms |  550 ms |   TODO ms | 11 ms | CPS, 0ary constr. unboxed

TODO
Wasm | (Node.js)              |  TODO ms | TODO ms  |   TODO ms | TODO    % non-CPS, 0ary constr. unboxed

Wasm | (wasmtime)     |   ms     |  ms   |   ms    |  ms   % CPS, new
Wasm | (wasmtime)     |   ms     |  ms   |   ms    |  ms   % non-CPS, new
