From CertiRocq.Plugin Require Import CertiRocq.
From Stdlib Require Import Bool.

Definition my_negb (b : bool) := negb b.

Compute (my_negb true).
Compute (my_negb false).

CertiRocq Compile Wasm --output "rocq-negb" my_negb.
CertiRocq Show IR --output "rocq-negb" my_negb.
