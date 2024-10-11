From CertiCoq.Plugin Require Import CertiCoq.
From Coq Require Import List Nat.
Import ListNotations.

Definition foo := fold_left andb (map odd [1; 3; 5; 8]) true.

(* print lANF IR *)
(* CertiCoq Show IR -file "foo" foo. *)

(* Pretty-printing is hard-coded to bools, see foo.js
 * We have pretty-printing for the most important types in /evaluation/pp.js *)
CertiCoq Compile Wasm -file "foo" foo.
