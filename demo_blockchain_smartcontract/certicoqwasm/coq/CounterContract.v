(* Versions used:

Coq 8.17
MetaCoq v1.3-8.17
ConCert (95d1c12, github.com/womeier/concert)
CertiCoq-Wasm (branch demo_smartcontracts, github.com/womeier/certicoqwasm)

 *)


From ConCert.Examples.Counter Require Counter.
From ConCert.Extraction Require Import Common.
From ConCert.Extraction Require Import ConcordiumExtract.
From Coq Require Import List Uint63 ZArith Bool String.
From MetaCoq.Template Require Import All.

From ConCert.Execution Require Import Blockchain BoundedN Serializable LocalBlockchain.
Import ssreflect.

(* Extraction of the counter contract to Wasm (for Concordium) via CertiCoq-Wasm.
   concwmd_encode_state/concwmd_decode_state functions are tailored towards counter:
   We use 8 bytes to store the value of the counter on the chain,
   thus we convert the state to a Uint63.int.
   CertiCoq-Wasm represents a Uint63.int as a Wasm i64 -> easy to get/set
   To generalize for other contracts, the following is needed:
   - include the Address as parameter for decode_state (not relevant for counter contract)
   - need more bytes to store the state? a tuple/record of multiple Uint63.int would be suitable
     E.g. CertiCoq-Wasm represents a tuple (Uint63.int, Uint63.int)
     as a pointer p ---> [tag i64_0 i64_1], where the two i64s are placed directly next to each other.
   - encode Chain (currently we pass a dummy value as the counter doesn't use it)
*)

Definition AddrSize : N := (2^8)%N.

(* #[local]
Definition LocalChainBase : ChainBase :=
  {| Address := BoundedN AddrSize;
     address_eqb := BoundedN.eqb;
     address_eqb_spec := BoundedN.eqb_spec;
     address_is_contract a := (AddrSize / 2 <=? BoundedN.to_N a)%N;
   |}. *)

Record ConcordiumWasmMod (init_type receive_type : Type) (state : Type) :=
{ concwmd_init : init_type;
  concwmd_receive : receive_type;
  concwmd_encode_state : state -> Uint63.int;
  concwmd_decode_state : Uint63.int -> state;
  concwmd_make_msg : Uint63.int -> option Counter.Msg;
  concwmd_i63_to_Z : Uint63.int -> Z
}.

Definition zero : BoundedN AddrSize. apply bounded with (n := 0%N). reflexivity.
Defined.

#[global]
Instance LocalChainBase : ChainBase := LocalBlockchain.LocalChainBase AddrSize.

Definition encode_counter (s : Counter.State) : Uint63.int :=
  match s with
  | {| Counter.count := count; Counter.owner := _ |} => Uint63.of_Z count
  end.

Definition make_msg (p : Uint63.int) : option Counter.Msg :=
  let z := Uint63.to_Z p in
  if (z <? 0)%Z then Some (Counter.Dec (-z))
                else Some (Counter.Inc z).


Definition COUNTER_MODULE : ConcordiumWasmMod _ _ Counter.State :=
  {| concwmd_init := @ConCert.Examples.Counter.Counter.counter_init LocalChainBase;
     concwmd_receive := @ConCert.Examples.Counter.Counter.counter_receive LocalChainBase;
     concwmd_encode_state := encode_counter;
     concwmd_decode_state := fun p => Counter.build_state (Uint63.to_Z p) zero;
     concwmd_make_msg := make_msg;
     concwmd_i63_to_Z := Uint63.to_Z
   |}.

(* Check @COUNTER_MODULE. *)
(* Print Assumptions COUNTER_MODULE. *)

From CertiCoq.Plugin Require Import CertiCoq.

(* This produces the file ../src/COUNTER_MODULE.wasm *)
CertiCoq Compile Wasm -debug COUNTER_MODULE.
CertiCoq Show IR COUNTER_MODULE.
