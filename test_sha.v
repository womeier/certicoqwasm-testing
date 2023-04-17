From CertiCoq.Plugin Require Import CertiCoq.
Require Import String.

Require Import sha256.

Definition text := "Hallo Welt."%string.
Definition test_sha := sha256.SHA_256' (sha256.str_to_bytes text).

From CertiCoq.Plugin Require Import CertiCoq.
CertiCoq Show IR -cps -file "sha" test_sha.
CertiCoq Generate WASM -cps -file "sha" test_sha.
