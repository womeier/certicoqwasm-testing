From CertiCoq.Plugin Require Import CertiCoq.

Definition inc (n : nat) : nat :=
  n + 1.

CertiCoq Show IR -file "basic_inc" -O0 inc.

CertiCoq Show IR -file "optimized_inc" -O1 inc.
