From CertiCoq.Plugin Require Import CertiCoq.
Require Import String.

Require Import sha256.

Definition text := "Hallo Welt."%string.
Definition test_sha := sha256.SHA_256' (sha256.str_to_bytes text).

(* CertiCoq Show IR -file "sha" test_sha. *)

(* Generates sha.wasm file, that can be run with `node sha.js`
   The result type is hard-coded in sha.js for pretty-printing. See sha.js for more about pp. *)
CertiCoq Compile Wasm -file "sha" test_sha.
