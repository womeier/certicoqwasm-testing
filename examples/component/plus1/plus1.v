From CertiRocq.Plugin Require Import CertiRocq.
From Stdlib Require Import List Nat.
Import ListNotations.

From Stdlib Require Import Uint63 ZArith.


Definition plus1(n : int) := (n + 1)%uint63.

Compute (plus1 2).

(* Pretty-printing is hard-coded to bools, see foo.js
 * We have pretty-printing for the most important types in /evaluation/pp.js *)
CertiRocq Compile Wasm -file "rocq-plus1" plus1.
CertiRocq Show IR -file "rocq-plus1" plus1.
