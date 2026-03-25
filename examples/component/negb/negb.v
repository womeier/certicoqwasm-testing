From CertiRocq.Plugin Require Import CertiRocq.
From Stdlib Require Import Bool.

Definition my_negb (b : bool) := negb b.

Compute (my_negb true).
Compute (my_negb false).

CertiRocq Compile Wasm -file "rocq-negb" my_negb.
CertiRocq Show IR -file "rocq-negb" my_negb.
