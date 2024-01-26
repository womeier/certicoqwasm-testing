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

(* required because the libraries ITree + CertiCoq break together *)
Unset Universe Checking.


(* From CertiCoq Require Import Common.Common Common.compM Common.Pipeline_utils. *)

(* From MetaCoq.Utils Require Import bytestring MCString. *)
From Coq Require Import ZArith List.

(* From CertiCoq Require Import LambdaANF.cps LambdaANF.cps_show CodegenWASM.LambdaANF_to_WASM. *)
Require Import ExtLib.Structures.Monad.
Import MonadNotation.

From Coq.Strings Require Import Byte.

From Wasm Require Import binary_format_parser binary_format_printer host
                         datatypes datatypes_properties check_toks instantiation_func interpreter_itree.

From mathcomp Require Import seq.


Check ([:: 1; 2]). (* WasmCert uses the ssreflect package a lot, these  *)
(* fails: Check ([1;2]). *)
Import ListNotations.
Check [1;2].


Module TestModule.

(* python script in certicoqwasm-testing turns .wasm in list of bytes one can copy paste here *)
Definition test_bytes : list Byte.byte := x00 :: x61 :: x73 :: x6d :: x01 :: x00 :: x00 :: x00 :: x01 :: x07 :: x01 :: x60 :: x02 :: x7f :: x7f :: x01 :: x7f :: x03 :: x02 :: x01 :: x00 :: x07 :: x0b :: x01 :: x07 :: x61 :: x64 :: x64 :: x5f :: x69 :: x33 :: x32 :: x00 :: x00 :: x0a :: x09 :: x01 :: x07 :: x00 :: x20 :: x00 :: x20 :: x01 :: x6a :: x0b :: nil.

Definition test_module_opt : option module := run_parse_module test_bytes.
Compute test_module_opt.


Definition test_module := {|
  mod_types := [:: Tf [:: T_i32; T_i32] [:: T_i32]];
  mod_funcs :=
    [:: {|
          modfunc_type := Mk_typeidx 0;
          modfunc_locals := [::];
          modfunc_body :=
            [:: BI_get_local 0; BI_get_local 1;
                BI_binop T_i32 (Binop_i BOI_add)]
        |}];
  mod_tables := [::];
  mod_mems := [::];
  mod_globals := [::];
  mod_elem := [::];
  mod_data := [::];
  mod_start := None;
  mod_imports := [::];
  mod_exports :=
    [:: {|
          modexp_name := [:: "a"; "d"; "d"; "_"; "i"; "3"; "2"];
          modexp_desc := MED_func (Mk_funcidx 0)
        |}]
|}.

Definition type_check_test_module :=
  m <- test_module_opt ;;
  module_type_checker m.

Compute type_check_test_module.

Definition test_function_type := Tf [:: T_i32; T_i32] [:: T_i32].
Definition test_function := {|
                modfunc_type := Mk_typeidx 0;
                modfunc_locals := [:: T_i32];
                modfunc_body :=
                  [:: BI_get_local 0; BI_get_local 1;
                      BI_binop T_i32 (Binop_i BOI_add)]
              |}.

End TestModule.


Definition nat_to_i32 (n : nat) :=
  VAL_int32 (Wasm_int.Int32.repr (BinInt.Z.of_nat n)).

(* Import TestModule. *)
From mathcomp Require Import eqtype.
From Wasm Require Import host opsem instantiation_func.

Section OpsemTest.
Import Lia.
Import Relations.Relation_Operators.

Import interpreter_func.

Import ssreflect ssrfun ssrnat ssrbool eqtype seq.

Set Implicit Arguments.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Import operations opsem interpreter_itree interpreter_func properties common.

Variable host_function : eqType.
Let store_record := store_record host_function.
Let host := host host_function.
Variable host_instance : host.
Let host_state := host_state host_instance.

Let reduce_trans := @reduce_trans host_function host_instance.

Definition initial_store : store_record := {|
  (* imported funcs write_int and write_char, they are not called
     but need to be present:
     s_funcs := [FC_func_host (Tf [T_i32] []) host_function; FC_func_host (Tf [T_i32] []) host_function];
     *)
    s_funcs := nil;
    s_tables := nil;
    s_mems := nil;
    s_globals := nil;
  |}.

(** The lemmas [r_eliml] and [r_elimr] are the fundamental framing lemmas.
  They enable to focus on parts of the stack, ignoring the context. **)

Lemma r_eliml: forall hs s f es hs' s' f' es' lconst,
  const_list lconst ->
  reduce (host_instance := host_instance) hs s f es hs' s' f' es' ->
  reduce hs s f (lconst ++ es) hs' s' f' (lconst ++ es').
Proof.
  move => hs s f es hs' s' f' es' lconst HConst H.
  apply: r_label; try apply/lfilledP.
  - by apply: H.
  - replace (lconst++es) with (lconst++es++[::]); first by apply: LfilledBase.
    f_equal. by apply: cats0.
  - replace (lconst++es') with (lconst++es'++[::]); first by apply: LfilledBase.
    f_equal. by apply: cats0.
Qed.

Lemma r_elimr: forall hs s f es hs' s' f' es' les,
    reduce (host_instance := host_instance) hs s f es hs' s' f' es' ->
    reduce hs s f (es ++ les) hs' s' f' (es' ++ les).
Proof.
  move => hs s f es hs' s' f' es' les H.
  apply: r_label; try apply/lfilledP.
  - apply: H.
  - replace (es++les) with ([::]++es++les) => //. by apply: LfilledBase.
  - replace (es'++les) with ([::]++es'++les) => //. by apply: LfilledBase.
Qed.

Ltac separate_instr :=
  cbn;
  repeat match goal with
  |- context C [?x :: ?l] =>
     lazymatch l with [::] => fail | _ => rewrite -(cat1s x l) end
  end.

(* applies r_elimr with es := (the first n const ++ the following instruction)
   the remaining ones are put in les *)
Ltac elimr_nary_instr n :=
  let H := fresh "H" in
  match n with
  | 0 => lazymatch goal with
         | |- reduce _ _ _ ([:: ?instr] ++ ?l3) _ _ _ ?l4 => apply r_elimr
          end
  | 1 => lazymatch goal with
         | |- reduce _ _ _ ([::AI_basic (BI_const ?c1)] ++
                            [::AI_basic ?instr] ++ ?l3) _ _ _ ?l4 =>
            assert ([:: AI_basic (BI_const c1)] ++ [:: AI_basic instr] ++ l3
                  = [:: AI_basic (BI_const c1);
                        AI_basic instr] ++ l3) as H by reflexivity; rewrite H; apply r_elimr; clear H
          end
  | 2 => lazymatch goal with
         | |- reduce _ _ _ ([::AI_basic (BI_const ?c1)] ++
                            [::AI_basic (BI_const ?c2)] ++
                            [::AI_basic ?instr] ++ ?l3) _ _ _ ?l4 =>
            assert ([:: AI_basic (BI_const c1)] ++ [:: AI_basic (BI_const c2)] ++ [:: AI_basic instr] ++ l3
                  = [:: AI_basic (BI_const c1);
                        AI_basic (BI_const c2);
                        AI_basic instr] ++ l3) as H by reflexivity; rewrite H; apply r_elimr; clear H
          end
  end.

Ltac dostep :=
  eapply rt_trans with (y := (?[hs], ?[sr], ?[f'], ?[s] ++ ?[t])); first apply rt_step; separate_instr.

(* only returns single list of instructions *)
Ltac dostep' :=
   eapply rt_trans with (y := (?[hs], ?[sr], ?[f'], ?[s])); first  apply rt_step; separate_instr.

(********************************************************************************************)

(* rt: rt_step, rt_refl, rt_trans *)
Check clos_refl_trans. Print clos_refl_trans.

(* frame, see datatypes.v *)
Check frame. Print frame.

Lemma test_reduces (hs : host_state) f :
  f.(f_locs) = [nat_to_i32 1; nat_to_i32 2] ->
  reduce_trans (hs, initial_store, f, [ AI_basic (BI_get_local 0); AI_basic (BI_get_local 1)
                                      ; AI_basic (BI_binop T_i32 (Binop_i BOI_add))])
               (hs, initial_store, f, [AI_basic (BI_const (nat_to_i32 3))]).
Proof.
  intro Hfr. cbn.
  dostep. elimr_nary_instr 0. apply r_get_local. rewrite Hfr. reflexivity.
  dostep. apply r_eliml. auto. elimr_nary_instr 0. apply r_get_local. rewrite Hfr. reflexivity.
  cbn.
  (* dostep. apply r_simple. apply rs_binop_success.
  doesn't work here, unification error with anonymous var. *)
  dostep'. apply r_simple. apply rs_binop_success. reflexivity.
  apply rt_refl.
Qed.
End OpsemTest.
