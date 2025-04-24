Require Import Arith List String Uint63 BinNat BinInt Strings.Byte.
Require Import Demo.lib.sha256.
From MetaCoq.Utils Require Import bytestring MCString.
From CertiCoq.Plugin Require Import CertiCoq.

Open Scope nat.
Import ListNotations.

Fixpoint compcert_bytes_to_stdlib_bytes (bs : list compcert.lib.Integers.Byte.int) : list Byte.byte :=
  match bs with
  | [] => []
  | b::bs' => match Coq.Strings.Byte.of_N (Z.to_N (compcert.lib.Integers.Byte.intval b)) with
              | Some x => x :: compcert_bytes_to_stdlib_bytes bs'
              | None => [] (* unreachable, since in bound*)
              end
  end.

Definition stdlib_bytes_to_compcert_bytes (bs : list Byte.byte) : list compcert.lib.Integers.Byte.int :=
  str_to_bytes (string_of_list_byte bs).


Compute (compcert_bytes_to_stdlib_bytes (stdlib_bytes_to_compcert_bytes [xaf; xff; "000"%byte])).

(* Compute (SHA_256' (str_to_bytes "hallo"%string)). *)
(* Compute (bytes_to_stdlib_bytes (SHA_256' (str_to_bytes "hallo"%string))). *)


(* Definition SHA_256_stdlib_bytes (bs : list compcert.lib.Integers.byte) :=
  compcert_bytes_to_stdlib_bytes (SHA_256' bs). *)

(* Sha *)
Definition test_bytes := list_byte_of_string "hallo".
Compute test_bytes.

Definition sha_fast (bytes: list Byte.byte) :=
  compcert_bytes_to_stdlib_bytes
  match bytes with
  | _ => sha256.SHA_256' (stdlib_bytes_to_compcert_bytes bytes)
  end.

(* Compute (sha_fast []). *)

Eval compute in "Compiling sha_fast"%bs.
CertiCoq Compile Wasm (* -time -debug *) sha_fast.
CertiCoq Show IR sha_fast.
