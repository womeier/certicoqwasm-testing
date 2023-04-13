(*
(module
  (func (export "add_i32")
  (param $val_1 i32) (param $val_2 i32)
    (result i32)
      local.get $val_1
      local.get $val_2
      i32.add
  )
) wasm_to_coq.py

*)

Unset Universe Checking.
From Wasm Require Import datatypes prettyprint.

From CertiCoq Require Import LambdaANF.toplevel Common.Common Common.compM Common.Pipeline_utils.
Require Import ExtLib.Structures.Monad.
From MetaCoq.Template Require Import bytestring MCString.
From Coq Require Import ZArith List.

From CertiCoq Require Import LambdaANF.cps LambdaANF.cps_show CodegenWASM.wasm_map_util.
Import MonadNotation.

From Coq.Strings Require Import Byte.

From Wasm Require Import binary_format_parser binary_format_printer
                         datatypes_properties check_toks instantiation.


Module TestModule.

Definition test_bytes : list Byte.byte := x00 :: x61 :: x73 :: x6d :: x01 :: x00 :: x00 :: x00 :: x01 :: x07 :: x01 :: x60 :: x02 :: x7f :: x7f :: x01 :: x7f :: x03 :: x02 :: x01 :: x00 :: x07 :: x0b :: x01 :: x07 :: x61 :: x64 :: x64 :: x5f :: x69 :: x33 :: x32 :: x00 :: x00 :: x0a :: x09 :: x01 :: x07 :: x00 :: x20 :: x00 :: x20 :: x01 :: x6a :: x0b :: nil.

Definition test_module_opt : option module := run_parse_module test_bytes.
Compute test_module_opt.

Definition type_check_test_module :=
  m <- test_module_opt ;;
  module_type_checker m.

Compute type_check_test_module.

Definition test_function_type := Tf [T_i32; T_i32] [T_i32].
Definition test_function := {|
                modfunc_type := Mk_typeidx 0;
                modfunc_locals := [];
                modfunc_body :=
                  [BI_get_local 0; BI_get_local 1;
                  BI_binop T_i32 (Binop_i BOI_add)]
              |}.

End TestModule.


Definition nat_to_i32 (n : nat) :=
  VAL_int32 (Wasm_int.Int32.repr (BinInt.Z.of_nat n)).

Import TestModule.
From mathcomp Require Import eqtype.
From Wasm Require Import host opsem instantiation.

Section OpsemTest.
Variable host_function : eqType.
Let host := host host_function.

Variable host_instance : host.

Let store_record := store_record host_function.
Let host_state := host_state host_instance.

Require Import Lia.
Import Relations.Relation_Operators.

(* rt: rt_step, rt_refl, rt_trans *)
(* From CertiCoq Require Import CodegenWASM.LamdaANF_to_WASM. *)
Check instance.
Print instance.
Lemma test_reduces (inst : instance) (hs_initial : host_state)
                   (hs_result : host_state) :
  reduce_trans (hs_initial, empty_store_record host_function, Build_frame [] inst , map AI_basic (* test_function.(modfunc_body) *) [BI_const (nat_to_i32 1); BI_const (nat_to_i32 3); BI_binop T_i32 (Binop_i BOI_add)] )
               (hs_initial, empty_store_record host_function, Build_frame [] inst, [AI_basic (BI_const (nat_to_i32 4))]).
Proof.
  apply rt_step. cbn. constructor. constructor. reflexivity.
Qed.


End OpsemTest.

From Wasm Require Import interpreter_func common operations opsem interpreter_func properties.

From mathcomp Require Import seq.

Section InterpTest.
(* preamble pasted from interpreter_func_sound.v*)

Variable host_function : eqType.
Let store_record := store_record host_function.
Let function_closure := function_closure host_function.
(*Let administrative_instruction := administrative_instruction host_function.

Let to_e_list : seq basic_instruction -> seq administrative_instruction := @to_e_list _.
Let to_b_list : seq administrative_instruction -> seq basic_instruction := @to_b_list _.*)
Let e_typing : store_record -> t_context -> seq administrative_instruction -> function_type -> Prop :=
  @e_typing _.
Let inst_typing : store_record -> instance -> t_context -> bool := @inst_typing _.
(*Let reduce_simple : seq administrative_instruction -> seq administrative_instruction -> Prop :=
  @reduce_simple _.
Let const_list : seq administrative_instruction -> bool := @const_list _.
Let lholed := lholed host_function.
Let lfilled : depth -> lholed -> seq administrative_instruction -> seq administrative_instruction -> bool :=
  @lfilled _.
Let lfilledInd : depth -> lholed -> seq administrative_instruction -> seq administrative_instruction -> Prop :=
  @lfilledInd _.
Let es_is_basic : seq administrative_instruction -> Prop := @es_is_basic _.*)

Let host := host host_function.

(*Let run_one_step_fuel := @run_one_step_fuel host_function.*)

Let RS_crash := interpreter_func.RS_crash.
Let RS_break := interpreter_func.RS_break.
Let RS_return := interpreter_func.RS_return.
Let RS_normal := interpreter_func.RS_normal.

Variable host_instance : host.

Let run_step_fuel := @run_step_fuel host_function host_instance.

Let host_state := host_state host_instance.

Let reduce : host_state -> store_record -> frame -> seq administrative_instruction ->
             host_state -> store_record -> frame -> seq administrative_instruction -> Prop
  := @reduce _ _.

Variable host_application_impl : host_state -> store_record -> function_type -> host_function -> seq value ->
                       (host_state * option (store_record * result)).

Hypothesis host_application_impl_correct :
  (forall hs s ft hf vs hs' hres, (host_application_impl hs s ft hf vs = (hs', hres)) -> host_application hs s ft hf vs hs' hres).


Let run_one_step := @run_one_step host_function host_instance host_application_impl.
Let run_step := @run_step host_function host_instance host_application_impl.
Let run_step_with_fuel := @run_step_with_fuel host_function host_instance host_application_impl.
Let run_v := @run_v host_function host_instance host_application_impl.

(* Fixpoint run_v (fuel : fuel) (d : depth) (cfg : config_tuple) : ((host_state * store_record * res)%type) := *)

Definition test_run (inst : instance) (hs_initial : host_state) :=
  run_v 10 5 (hs_initial, empty_store_record host_function, Build_frame [nat_to_i32 0] inst,
               map AI_basic [ BI_const (nat_to_i32 2)
                            ; BI_const (nat_to_i32 3)
                            ; BI_set_local 0
                            ; BI_get_local 0
                            ; BI_binop T_i32 (Binop_i BOI_add)
                            ]).

Compute test_run.

Lemma test_run_correct (inst : instance) (hs_initial : host_state) :
  let '(_, _, res) := test_run inst hs_initial in
  res = R_value [nat_to_i32 5].
Proof.
  vm_compute. reflexivity.
Qed.
End InterpTest.

(*
Import Monads.
Import MonadNotation.

From Coq Require Import String.
From Wasm Require Import interpreter.
From mathcomp Require Import seq.


Check lookup_exported_function.
Check name.
Print name.

Check eqtype.Equality.type.

Print interp_instantiate_wrapper.
Definition to_seq {A} (l : list A) : seq A := l.

Definition run : option nat :=
  module <- test_module ;;
  instantiated_module <- interp_instantiate_wrapper module ;;
  (* cfg_tuple <- lookup_exported_function (to_seq (list_byte_of_string "add_i32")) instantiated_module;;*)
  Some 1.
*)