From ExtLib Require Import Monads OptionMonad.

From Coq Require Import
  ZArith List
  Strings.Byte.

From Wasm Require Import
  binary_format_parser binary_format_printer
  host
  datatypes datatypes_properties
  check_toks instantiation_func.

From mathcomp Require Import
  seq.

Import ListNotations MonadNotation.
Open Scope monad_scope.

Module TestModule.
(*
(module
  (func (export "add_i32")
  (param $val_1 i32) (param $val_2 i32)
    (result i32)
      local.get $val_1
      local.get $val_2
      i32.add
  )
)
*)
(* obtained from .wasm file with script: https://github.com/womeier/certicoqwasm-testing/blob/master/examples/wasmcert/wasm_to_coq.py *)
Definition test_bytes : list Byte.byte := x00 :: x61 :: x73 :: x6d :: x01 :: x00 :: x00 :: x00 :: x01 :: x07 :: x01 :: x60 :: x02 :: x7f :: x7f :: x01 :: x7f :: x03 :: x02 :: x01 :: x00 :: x07 :: x0b :: x01 :: x07 :: x61 :: x64 :: x64 :: x5f :: x69 :: x33 :: x32 :: x00 :: x00 :: x0a :: x09 :: x01 :: x07 :: x00 :: x20 :: x00 :: x20 :: x01 :: x6a :: x0b :: nil.

Definition test_module_opt : option module := run_parse_module test_bytes.
Compute test_module_opt.

Definition test_module := {|
  mod_types := [:: Tf [:: T_num T_i32; T_num T_i32] [:: T_num T_i32]];
  mod_funcs :=
    [:: {|
          modfunc_type := 0%N;
          modfunc_locals := [::];
          modfunc_body :=
            [:: BI_local_get 0%N; BI_local_get 1%N;
                BI_binop T_i32 (Binop_i BOI_add)]
        |}];
  mod_tables := [::];
  mod_mems := [::];
  mod_globals := [::];
  mod_elems := [::];
  mod_datas := [::];
  mod_start := None;
  mod_imports := [::];
  mod_exports :=
    [:: {|
          modexp_name := [:: "a"; "d"; "d"; "_"; "i"; "3"; "2"];
          modexp_desc := MED_func 0%N
        |}]
|}.


Definition type_check_test_module :=
  m <- test_module_opt ;;
  module_type_checker m.

Compute type_check_test_module.

Definition test_function_type := Tf [:: T_num T_i32; T_num T_i32] [:: T_num T_i32].
Definition test_function := {|
                modfunc_type := 0%N;
                modfunc_locals := [:: T_num T_i32];
                modfunc_body :=
                  [:: BI_local_get 0%N; BI_local_get 1%N;
                      BI_binop T_i32 (Binop_i BOI_add)]
              |}.

End TestModule.


Notation nat_to_i32 n := (Wasm_int.Int32.repr (BinInt.Z.of_nat n)).
Notation nat_to_value_num n := (VAL_int32 (nat_to_i32 n)).
Notation nat_to_value n := (VAL_num (nat_to_value_num n)).

(* Import TestModule. *)
Import eqtype ssreflect ssrbool.

Section OpsemTest.
Import Lia.
Import Relations.Relation_Operators.

Import host opsem instantiation_func.

Set Implicit Arguments.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

Import operations opsem properties common.

Context `{ho : host}.

Definition initial_store : store_record := {|
  (* imported funcs write_int and write_char, they are not called
     but need to be present:
     s_funcs := [FC_func_host (Tf [T_i32] []) host_function; FC_func_host (Tf [T_i32] []) host_function];
     *)
    s_funcs := nil;
    s_tables := nil;
    s_mems := nil;
    s_globals := nil;
    s_elems := nil;
    s_datas := nil;
  |}.

(** The lemmas [r_eliml] and [r_elimr] are relicts from ancient times,
    kept for compatability for now, TODO rework (use new context representation) **)

Lemma r_eliml: forall hs s f es hs' s' f' es' lconst,
  const_list lconst ->
  reduce hs s f es hs' s' f' es' ->
  reduce hs s f (lconst ++ es) hs' s' f' (lconst ++ es').
Proof.
  move => hs s f es hs' s' f' es' lconst HConst H.
  apply const_es_exists in HConst. destruct HConst as [vs ?].
  eapply r_label with (lh:=LH_base vs []). eassumption.
  - cbn. rewrite cats0. congruence.
  - cbn. rewrite cats0. congruence.
Qed.

Lemma r_elimr: forall hs s f es hs' s' f' es' les,
    reduce hs s f es hs' s' f' es' ->
    reduce hs s f (es ++ les) hs' s' f' (es' ++ les).
Proof.
  move => hs s f es hs' s' f' es' les H.
  eapply r_label with (lh:=LH_base [] les); eauto.
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
         | |- reduce _ _ _ ([:: ?instr])        _ _ _ _ => idtac
         | |- reduce _ _ _ ([:: ?instr] ++ ?l3) _ _ _ _ => apply r_elimr
         end
  | 1 => lazymatch goal with
         | |- reduce _ _ _ ([::$VN ?c1] ++ [:: ?instr])        _ _ _ _ => idtac
         | |- reduce _ _ _ ([::$VN ?c1] ++ [:: ?instr] ++ ?l3) _ _ _ _ =>
            assert ([::$VN c1] ++ [:: instr] ++ l3 =
                    [:: $VN c1; instr] ++ l3) as H by reflexivity; rewrite H;
                                                       apply r_elimr; clear H
         end
  | 2 => lazymatch goal with
         | |- reduce _ _ _ ([::$VN ?c1] ++ [::$VN ?c2] ++ [:: ?instr])        _ _ _ _ => idtac
         | |- reduce _ _ _ ([::$VN ?c1] ++ [::$VN ?c2] ++ [:: ?instr] ++ ?l3) _ _ _ _ =>
            assert ([::$VN c1] ++ [:: $VN c2] ++ [:: instr] ++ l3 =
                    [::$VN c1; $VN c2; instr] ++ l3) as H by reflexivity; rewrite H;
                                                       apply r_elimr; clear H
         end
  end.

Ltac dostep :=
  eapply rt_trans with (y := (?[hs], ?[sr], ?[f'], ?[s] ++ ?[t])); first apply rt_step; separate_instr.

(* only returns single list of instructions *)
Ltac dostep' :=
   eapply rt_trans with (y := (?[hs], ?[sr], ?[f'], ?[s])); first  apply rt_step; separate_instr.

Ltac inv H := inversion H; clear H; subst.

(********************************************************************************************)

(* rt: rt_step, rt_refl, rt_trans *)
Check clos_refl_trans. Print clos_refl_trans.

(* frame, see datatypes.v *)
Check frame. Print frame.

(* LOCAL VAR+BINOP EXAMPLE *)
Lemma test_local_add (hs : host_state) f s :
  f.(f_locs) = [nat_to_value 1; nat_to_value 2] ->
  reduce_trans (hs, s, f, [ AI_basic (BI_local_get 0%N)
                          ; AI_basic (BI_local_get 1%N)
                          ; AI_basic (BI_binop T_i32 (Binop_i BOI_add))
                          ])
               (hs, s, f, [AI_basic (BI_const_num (nat_to_value_num 3))]).
Proof.
  intro Hfr. cbn.
  dostep. elimr_nary_instr 0. apply r_local_get. rewrite Hfr. reflexivity.
  dostep. apply r_eliml. auto. elimr_nary_instr 0. apply r_local_get. rewrite Hfr. cbn. reflexivity.
  cbn.
  (* [dostep. apply r_simple. apply rs_binop_success.]
  doesn't work here, unification error with anonymous var. *)
  dostep'. apply r_simple. apply rs_binop_success. reflexivity.
  apply rt_refl.
Qed.

(* GLOBAL VAR READ/WRITE EXAMPLE *)

Definition global_var_w var (s : store_record) (f : frame) :=
  forall val, (exists s', supdate_glob s (f_inst f) var (VAL_num (VAL_int32 val)) = Some s').

Definition global_var_r var (s : store_record) (f : frame) :=
   exists v, sglob_val s (f_inst f) var = Some (VAL_num (VAL_int32 v)).

Lemma set_nth_nth_error_same : forall {X:Type} (l:seq X) e e' i vd,
    nth_error l i = Some e ->
    nth_error (set_nth vd l i e') i = Some e'.
Proof.
  intros. revert e' l vd e H.
  induction i; intros.
  - inv H. destruct l; inv H1. reflexivity.
  - cbn in H. destruct l=>//.
    eapply IHi in H. apply H.
Qed.

Lemma global_var_write_read_same : forall sr sr' i val fr,
  supdate_glob sr  (f_inst fr) i (VAL_num (VAL_int32 val)) = Some sr' ->
     sglob_val sr' (f_inst fr) i = Some (VAL_num (VAL_int32 val)).
Proof.
  unfold supdate_glob, supdate_glob_s, sglob_val, sglob, sglob_ind.
  cbn. intros.
  destruct (lookup_N (inst_globals (f_inst fr)) i) eqn:H1=>//.
  cbn in H.
  destruct (lookup_N (s_globals sr) g) eqn:H2=>//.
  inv H. cbn. unfold lookup_N.
  erewrite set_nth_nth_error_same; eauto.
Qed.

Lemma test_global_set_get (hs : host_state) f sr :
  global_var_w 0%N sr f -> (* here, I just assume this. To get a complete proof that also talks about the module,
                            one has to show that the assumption indeed holds.
                            Here, this follows if you set the global var of index 0 to be mutable. (and the module instantiates, i.e. it is well-typed)

                            Similarly, e.g. for certicoq-wasm, some invariants INV hold all throughout the execution:
                            Lemma module_instantiate_INV_and_more_hold says they hold initially and then,
                            after every step it is shown manually that its validity is preserved *)
  exists sr',
  reduce_trans (hs, sr, f, [ AI_basic (BI_const_num (nat_to_value_num 42)); AI_basic (BI_global_set 0%N)
                           ; AI_basic (BI_global_get 0%N)
                           ])
               (hs, sr', f, [ AI_basic (BI_const_num (nat_to_value_num 42))]).
Proof.
  intro HvarWritable.
  unfold global_var_w in HvarWritable.
  edestruct HvarWritable. (* edestruct so we don't have to manually specify val *)
  eexists. (* these anonymous vars are a bit annoying sometimes,
              here it is important that the var already exists when using
              [eexists], e.g. using [eexists] before the [edestruct HvarWritable],
              which creates the var, wouldn't work *)
  dostep. (* dostep introduces anonymous variables for the result *)
  elimr_nary_instr 1. (* set_global takes 1 param *)
  apply r_global_set with (v:=nat_to_value 42). apply H.

  dostep'. apply r_global_get. eapply global_var_write_read_same. eassumption.
  apply rt_refl.
Qed.

End OpsemTest.
