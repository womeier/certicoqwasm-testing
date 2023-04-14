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

From CertiCoq Require Import LambdaANF.cps LambdaANF.cps_show CodegenWASM.wasm_map_util CodegenWASM.LambdaANF_to_WASM.
Import MonadNotation.

From Coq.Strings Require Import Byte.

From Wasm Require Import binary_format_parser binary_format_printer host
                         datatypes_properties check_toks instantiation.



Module TestModule.

Definition test_bytes : list Byte.byte := x00 :: x61 :: x73 :: x6d :: x01 :: x00 :: x00 :: x00 :: x01 :: x07 :: x01 :: x60 :: x02 :: x7f :: x7f :: x01 :: x7f :: x03 :: x02 :: x01 :: x00 :: x07 :: x0b :: x01 :: x07 :: x61 :: x64 :: x64 :: x5f :: x69 :: x33 :: x32 :: x00 :: x00 :: x0a :: x09 :: x01 :: x07 :: x00 :: x20 :: x00 :: x20 :: x01 :: x6a :: x0b :: nil.

Definition test_module_opt : option module := run_parse_module test_bytes.
Compute test_module_opt.

From mathcomp Require Import seq.

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

Definition test_function_type := Tf [T_i32; T_i32] [T_i32].
Definition test_function := {|
                modfunc_type := Mk_typeidx 0;
                modfunc_locals := [T_i32];
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
Require Import Lia.
Import Relations.Relation_Operators.

From Wasm Require Import interpreter_sound.

From mathcomp Require Import ssreflect ssrfun ssrnat ssrbool eqtype seq.
From StrongInduction Require Import StrongInduction Inductions.

Set Implicit Arguments.
Unset Strict Implicit.
Unset Printing Implicit Defensive.


From Wasm Require Import operations opsem interpreter_func interpreter_func_sound properties common.

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

(** The lemmas [r_eliml] and [r_elimr] are the fundamental framing lemmas.
  They enable to focus on parts of the stack, ignoring the context. **)

Lemma r_eliml: forall s f es s' f' es' lconst hs hs',
    const_list lconst ->
    reduce hs s f es hs' s' f' es' ->
    reduce hs s f (lconst ++ es) hs' s' f' (lconst ++ es').
Proof.
  move => s f es s' f' es' lconst hs hs' HConst H.
  apply: r_label; try apply/lfilledP.
  - by apply: H.
  - replace (lconst++es) with (lconst++es++[::]); first by apply: LfilledBase.
    f_equal. by apply: cats0.
  - replace (lconst++es') with (lconst++es'++[::]); first by apply: LfilledBase.
    f_equal. by apply: cats0.
Qed.

Lemma r_elimr: forall s f es s' f' es' les hs hs',
    reduce hs s f es hs' s' f' es' ->
    reduce hs s f (es ++ les) hs' s' f' (es' ++ les).
Proof.
  move => s f es s' f' es' les hs hs' H.
  apply: r_label; try apply/lfilledP.
  - apply: H.
  - replace (es++les) with ([::]++es++les) => //. by apply: LfilledBase.
  - replace (es'++les) with ([::]++es'++les) => //. by apply: LfilledBase.
Qed.

(** [r_eliml_empty] and [r_elimr_empty] are useful instantiations on empty stacks. **)

Lemma r_eliml_empty: forall s f es s' f' lconst hs hs',
    const_list lconst ->
    reduce hs s f es hs' s' f' [::] ->
    reduce hs s f (lconst ++ es) hs' s' f' lconst.
Proof.
  move => s f es s' f' lconst hs hs' HConst H.
  assert (reduce hs s f (lconst++es) hs' s' f' (lconst++[::])); first by apply: r_eliml.
  by rewrite cats0 in H0.
Qed.

Lemma r_elimr_empty: forall s f es s' f' les hs hs',
    reduce hs s f es hs' s' f' [::] ->
    reduce hs s f (es ++ les) hs' s' f' les.
Proof.
  move => s f es s' f' les hs hs' H.
  assert (reduce hs s f (es++les) hs' s' f' ([::] ++les)); first by apply: r_elimr.
  by rewrite cat0s in H0.
Qed.

Lemma run_step_fuel_not_zero : forall tt,
  run_step_fuel tt <> 0.
Proof.
  move=> [[st vs] es].
  rewrite/run_step_fuel.
  unfold interpreter_func.run_step_fuel.
  destruct st.
  by lias.
Qed.

Local Lemma ves_projection: forall vs e es vs' e' es',
  const_list vs ->
  const_list vs' ->
  ~ is_const e ->
  ~ is_const e' ->
  vs ++ e :: es = vs' ++ e' :: es' ->
  e = e'.
Proof.
  move => vs. induction vs => //=.
  - move => e es vs' e' es' _ HConstList HNConst HNConst'.
    destruct vs' => //=.
    + move => H. by inversion H.
    + simpl in HConstList. move => H. inversion H. subst.
      move/andP in HConstList. destruct HConstList as [Ha _].
      rewrite Ha in HNConst. exfalso. by apply HNConst.
  - move => e es vs' e' es' HConstList HConstList' HNConst HNConst'.
    destruct vs' => //=.
    + move => H. inversion H. subst.
      move/andP in HConstList. destruct HConstList as [He' _].
      exfalso. by apply HNConst'.
    + simpl in HConstList'. move => H. inversion H. subst.
      move/andP in HConstList. move/andP in HConstList'.
      destruct HConstList as [Ha Hvs]. destruct HConstList' as [Ha' Hvs'].
      eapply IHvs => //=.
      * by apply Hvs'.
      * by apply H2.
Qed.

Lemma lfilled0: forall es,
  lfilledInd 0 (LH_base [::] [::]) es es.
Proof.
  move => es.
  assert (lfilledInd 0 (LH_base [::] [::]) es ([::]++es++[::])) as H; first by apply LfilledBase.
  simpl in H. by rewrite cats0 in H.
Qed.

Lemma lfilled0_frame_l: forall vs es es' LI vs',
  lfilledInd 0 (LH_base vs es') es LI ->
  const_list vs' ->
  lfilledInd 0 (LH_base (vs' ++ vs) es') es (vs' ++ LI).
Proof.
  move => vs es es' LI vs' HLF HConst. inversion HLF; subst; clear HLF.
  assert (HList: vs' ++ vs ++ es ++ es' = (vs' ++ vs) ++ es ++ es'); first by repeat rewrite catA.
  rewrite HList.
  apply LfilledBase. by rewrite const_list_concat.
Qed.

Lemma lfilled0_frame_l_empty: forall es es' LI vs',
  lfilledInd 0 (LH_base [::] es') es LI ->
  const_list vs' ->
  lfilledInd 0 (LH_base vs' es') es (vs' ++ LI).
Proof.
  move => es es' LI vs' HLF HConst. inversion HLF; subst; clear HLF.
  repeat rewrite catA.
  rewrite cats0.
  rewrite -catA.
  by apply LfilledBase.
Qed.

Lemma lfilled0_frame_r: forall vs es es' LI es'',
  lfilledInd 0 (LH_base vs es') es LI ->
  lfilledInd 0 (LH_base vs (es' ++ es'')) es (LI ++ es'').
Proof.
  move => vs es es' LI es'' HLF. inversion HLF; subst; clear HLF.
  repeat rewrite -catA.
  by apply LfilledBase.
Qed.

Lemma lfilled0_frame_r_empty: forall vs es LI es'',
  lfilledInd 0 (LH_base vs [::]) es LI ->
  lfilledInd 0 (LH_base vs es'') es (LI ++ es'').
Proof.
  move => vs es LI es'' HLF. inversion HLF; subst; clear HLF.
  repeat rewrite -catA.
  by apply LfilledBase.
Qed.

Lemma lfilled0_take_drop: forall vs es n es',
  const_list vs ->
  n <= size vs ->
  lfilledInd 0 (LH_base (take n vs) es') (drop n vs ++ es) (vs ++ es ++ es').
Proof.
  move => vs es n es' HConst HSize.
  replace (vs++es++es') with (take n vs ++ (drop n vs ++ es) ++ es').
  apply LfilledBase. by apply const_list_take.
  { repeat rewrite catA. by rewrite cat_take_drop. }
Qed.

(** The following tactics are meant to help the proof of [run_step_soundness] below. **)

(** Simplify an hypothesis, possibly rewriting it everywhere. **)
Ltac simplify_hypothesis Hb :=
  repeat rewrite length_is_size in Hb;
  repeat match type of Hb with
  | is_true (es_is_trap _) => move/es_is_trapP: Hb => Hb
  | is_true (const_list (_ :: _)) => rewrite const_list_cons in Hb
  | ?b = true => fold (is_true b) in Hb
  | (_ == _) = false => move/eqP in Hb
  | context C [size (rev _)] => rewrite size_rev in Hb
  | context C [take _ (rev _)] => rewrite take_rev in Hb
  | context C [rev (rev _)] => rewrite revK in Hb
  | context C [true && _] => rewrite Bool.andb_true_l in Hb
  | context C [_ && true] => rewrite Bool.andb_true_r in Hb
  | context C [false || _] => rewrite Bool.orb_false_l in Hb
  | context C [_ || false] => rewrite Bool.orb_false_r in Hb
  | is_true true => clear Hb
  | is_true false => exfalso; apply: notF; apply: Hb
  | is_true (_ == _) => move/eqP in Hb
  | ?x = ?x => clear Hb
  | _ = _ => rewrite Hb in *
  end.

(** Apply [simplify_hypothesis] to all hypotheses. **)
Ltac simplify_goal :=
  repeat match goal with H: _ |- _ => progress simplify_hypothesis H end.

(** A common pattern in the proof: using an hypothesis on the form [rev l = l'] to rewrite [l]. **)
Ltac subst_rev_const_list :=
 repeat lazymatch goal with
 | HRevConst: rev ?lconst = ?h :: ?t |- _ =>
   apply rev_move in HRevConst; rewrite HRevConst; rewrite -cat1s; rewrite rev_cat;
   rewrite -v_to_e_cat; rewrite -catA
 end.

(** Simplify the lists in the goal. **)
Ltac simplify_lists :=
  (** Common rewriting rules. **)
  repeat first [
      rewrite drop_rev
    | rewrite take_rev
    | rewrite revK
    | rewrite length_is_size
    | rewrite size_take
    | rewrite size_drop
    | rewrite size_rev
    | rewrite v_to_e_size
    | rewrite rev_cat
    | rewrite rev_cons -cats1
    | rewrite -v_to_e_cat
    | rewrite -v_to_e_rev
    | rewrite -v_to_e_take
    | rewrite -v_to_e_drop];
  (** Putting all the lists into a normal form, as concatenations of as many things.
    Because [cat1s] conflicts with [cats0], replacing any occurence of [[X]] to
    [[X] ++ [::]], it has to be done separately.
    Rewrite with the associated [math goal with] is avoid to deal with existential
    vairables. **)
  repeat match goal with
  |- context C [?x :: ?l] =>
     lazymatch l with [::] => fail | _ => rewrite -(cat1s x l) end
  end;
  repeat lazymatch goal with
  | |- context C [[::] ++ _] => rewrite cat0s
  | |- context C [_ ++ [::]] => rewrite cats0
  | |- context C [rcons _ _] => rewrite -cats1
  | |- context C [(_ ++ _) ++ _] => rewrite -catA
  | |- context C [rev [::]] => rewrite rev0
  | |- context C [v_to_e_list [::]] => rewrite v_to_e_list0
  | |- context C [v_to_e_list [:: _]] => rewrite v_to_e_list1
  end;
  try subst_rev_const_list.

(** Explode a tuple into all its components. **)
Ltac explode_value v :=
  lazymatch type of v with
  | (_ * _)%type =>
    let v1 := fresh "v1" in
    let v2 := fresh "v2" in
    destruct v as [v1 v2];
    explode_value v1;
    explode_value v2
  | _ => idtac
  end.

(** Try to find which variable to pattern match on, destruct it,
  then simplify the destructing equality. **)
Ltac explode_and_simplify :=
  repeat lazymatch goal with
  | |- ?T = _ -> _ =>
    lazymatch T with
    | context C [split_n ?l ?n] => rewrite (split_n_is_take_drop l n)
    | context C [vs_to_es ?l] => rewrite/vs_to_es
    | context C [host_application_impl _ _ _ _ _ _] =>
      destruct host_application_impl
    | context C [match ?b with true => ?v1 | false => ?v2 end] =>
      let Hb := fresh "if_expr" in
      destruct b eqn:Hb;
      simplify_hypothesis Hb;
      try by [|apply: Hb]
    | context C [match rev ?lconst with
                 | _ :: _ => _
                 | _ => _
                 end] =>
      let HRevConst := fresh "HRevConst" in
      destruct (rev lconst) eqn:HRevConst;
      simplify_hypothesis HRevConst;
      try by [|apply: HRevConst]
    | context C [match ?v with
                 | VAL_int32 _ => _
                 | _ => _
                 end] =>
      let Hb := fresh "Ev" in
      destruct v eqn:Hb;
      simplify_hypothesis Hb;
      try by []
    | context C [match ?v with
                 | Some _ => _
                 | _ => _
                 end] =>
      let Hv := fresh "option_expr" in
      let v' := fresh "v" in
      destruct v as [v'|] eqn:Hv; [ explode_value v' |];
      simplify_hypothesis Hv;
      try by [|apply: Hv]
    | context C [match ?cl with
                 | FC_func_native _ _ _ _ => _
                 | FC_func_host _ _ => _
                 end] =>
      let Hcl := fresh "Hcl" in
      destruct cl eqn:Hcl;
      simplify_hypothesis Hcl;
      try by []
    | context C [match ?tf with
                 | Tf _ _ => _
                 end] =>
      let Hcl := fresh "Htf" in
      destruct tf eqn:Htf;
      simplify_hypothesis Htf;
      try by []
    | context C [match ?v with
                 | T_i32 => _
                 | T_i64 => _
                 | T_f32 => _
                 | T_f64 => _
                 end] =>
      let Hv := fresh "Ev" in
      destruct v eqn:Hv;
      simplify_hypothesis Hv;
      try by []
    | context C [match ?v with
                 | CVO_convert => _
                 | CVO_reinterpret => _
                 end] =>
      let Hv := fresh "Ecvtop" in
      destruct v eqn:Hv;
      simplify_hypothesis Hv;
      try by []
    | context C [match ?v with
                 | Tf _ _ => _
                 end] =>
      let vs1 := fresh "vs" in
      let vs2 := fresh "vs" in
      let Hv := fresh "Eft" in
      destruct v as [vs1 vs2] eqn:Hv;
      simplify_hypothesis Hv;
      try by []
    | context C [expect ?X ?f ?err] =>
       let HExpect := fresh "HExpect" in
       destruct X eqn:HExpect;
       simplify_hypothesis HExpect;
       simpl;
       try by [|apply: HExpect]
    | context C [match ?l with
                 | _ :: _ => _
                 | _ => _
                 end] =>
      destruct l;
      try by []
    end
  end;
  simplify_lists.

(** If the goal is on the form [c1 = c2 -> property] where [c1] and [c2] are two configurations,
  then invert it. **)
Ltac pattern_match :=
  let go _ :=
    lazymatch goal with
    | |- (_, _, _, _) = (_, _, _, _) -> _ =>
      let H := fresh in
      move=> H; inversion H; subst; clear H
    end in
  go tt || (simpl; go tt).

(** Eliminate the stack frame, by applying [r_elimr] and [r_eliml] according to some heuristics. **)
Ltac stack_frame :=
  repeat lazymatch goal with
  | |- reduce _ _ _ (_ :: ?l) _ _ _ _ =>
    rewrite -cat1s
  | |- reduce _ _ _ (?l1 ++ ?l2 :: ?l3) _ _ _ ((?l5 ++ ?l4) ++ ?l3) =>
    rewrite -cat1s; rewrite catA;
    apply: r_elimr; try apply: r_eliml; try apply: v_to_e_is_const_list
  | |- reduce _ _ _ (?l1 ++ ?l2 :: ?l3) _ _ _ (?l5 ++ ?l3) =>
    rewrite -cat1s; rewrite catA;
    apply: r_elimr; try apply: r_eliml_empty; try apply: v_to_e_is_const_list
  | |- reduce _ _ _ (operations.v_to_e_list ?l1 ++ _) _ _ _ (operations.v_to_e_list (take ?n ?l1) ++ _) =>
    rewrite (v_to_e_take_drop_split l1 n); rewrite -catA;
    apply: r_eliml; try apply: v_to_e_is_const_list
  end.

(** Try to solve a goal of the form [const_list _]. **)
Ltac solve_const_list :=
  repeat rewrite const_list_concat;
  repeat rewrite const_list_cons;
  by [| apply: v_to_e_is_const_list ].

(** Try to solve a goal of the form [l1 = l2] where [l1] and [l2] are two lists. **)
Ltac show_list_equality :=
  simplify_lists; simplify_goal;
  by [| repeat f_equal
      | repeat rewrite catA; repeat f_equal
      | repeat rewrite -catA; repeat f_equal
      | eauto
      | erewrite cats0; eauto
      | erewrite cat0s; eauto
      | repeat (repeat rewrite catA; f_equal; repeat rewrite -catA; f_equal)
      | repeat (repeat rewrite -catA; f_equal; repeat rewrite catA; f_equal) ].

(** Given a left and a right frame, rewrite the goal to move these frames out. **)
Ltac frame_out l r :=
  lazymatch goal with
  | |- reduce _ _ _ ?st1 _ _ _ ?st2 =>
    let sta := fresh "st1" in
    evar (sta : seq administrative_instruction);
    let stb := fresh "st2" in
    evar (stb : seq administrative_instruction);
    let Est1 := fresh "E_before" in
    assert (Est1: st1 = (l ++ sta) ++ r); [
        rewrite/sta {sta stb}; try show_list_equality
      | let Est2 := fresh "E_after" in
        assert (Est2: st2 = (l ++ stb) ++ r); [
            rewrite/stb {Est1 sta stb}; try show_list_equality
          | rewrite Est1 Est2;
            apply r_elimr with (les := r);
            apply r_eliml with (lconst := l); first try solve_const_list;
            rewrite /sta /stb {Est1 Est2 sta stb};
            try by repeat constructor ] ]
  end.

(** Same as [frame_out], by the frames are inferred (syntactically). **)
Ltac auto_frame :=
  simplify_lists;
  let empty := constr:([::] : list administrative_instruction) in
  let left _ :=
    repeat rewrite -catA;
    repeat lazymatch goal with
    | |- reduce _ _ _ (?l ++ _) _ _ _ (?l ++ _) =>
      frame_out l empty
    | |- reduce _ _ _ (?l ++ _) _ _ _ ?l =>
      frame_out l empty
    | |- reduce _ _ _ ?l _ _ _ (?l ++ _) =>
      frame_out l empty
    end in
  let right _ :=
    repeat rewrite catA;
    repeat lazymatch goal with
    | |- reduce _ _ _ (_ ++ ?r) _ _ _ (_ ++ ?r) =>
      frame_out empty r
    | |- reduce _ _ _ (_ ++ ?r) _ _ _ ?r =>
      frame_out empty r
    | |- reduce _ _ _ ?r _ _ _ (_ ++ ?r) =>
      frame_out empty r
    end;
    (** Renormalising back. **)
    repeat (rewrite -catA) in
  repeat first [ progress left tt | progress right tt ].

(** Same as [frame_out], by the frames are existential variables. **)
Ltac eframe :=
  let l := fresh "l" in
  evar (l : seq administrative_instruction);
  let r := fresh "r" in
  evar (r : seq administrative_instruction);
  frame_out l r.

(***********)

From Wasm Require Import interpreter_func_sound.

(* rt: rt_step, rt_refl, rt_trans *)
Check instance.
Print instance.
Lemma test_reduces (inst : instance) (hs_initial : host_state)
                   (hs_result : host_state) :
  reduce_trans (hs_initial, empty_store_record host_function, Build_frame [nat_to_i32 1; nat_to_i32 2] inst , map AI_basic test_function.(modfunc_body) (* [BI_const (nat_to_i32 1); BI_const (nat_to_i32 3); BI_binop T_i32 (Binop_i BOI_add)] *) )
               (hs_initial, empty_store_record host_function, Build_frame [nat_to_i32 1; nat_to_i32 2] inst, [AI_basic (BI_const (nat_to_i32 3))]).
Proof.
  cbn.
  eapply rt_trans with (y := (?[hs], ?[sr], ?[f], ?[s] ++ ?[t])).
  apply rt_step. cbn.
  explode_and_simplify.
  replace ([:: AI_basic (BI_get_local 0); AI_basic (BI_get_local 1);
      AI_basic (BI_binop T_i32 (Binop_i BOI_add))]) with
      ([:: AI_basic (BI_get_local 0)] ++ ([AI_basic (BI_get_local 1);
      AI_basic (BI_binop T_i32 (Binop_i BOI_add))])).
  - apply r_elimr. apply r_get_local. cbn. reflexivity.
  - reflexivity.
  - cbn.
  eapply rt_trans with (y := (?[hs], ?[sr], ?[f], ?[s] ++ ?[t])).
  eapply rt_step. cbn.
  explode_and_simplify.
  rewrite catA.
  apply r_elimr.
  - apply r_eliml; auto.
  - apply r_get_local. reflexivity.
  - cbn. apply rt_step. cbn. apply r_simple. constructor. cbn. reflexivity.
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
Section OpsemTest.
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


Let executable_host := executable_host host_function.

Import Monads.
Import MonadNotation.

From Coq Require Import String.
From Wasm Require Import interpreter.
From mathcomp Require Import seq.

Import TestModule.

Unset Universe Checking.

Check lookup_exported_function.

Check name.
Print name.

Check eqtype.Equality.type.

Print interp_instantiate_wrapper.
Definition to_seq {A} (l : list A) : seq A := l.

Definition run :=
  interp_instantiate_wrapper host_function test_module.
  Some instantiated_module.
  (* cfg_tuple <- lookup_exported_function (to_seq (list_byte_of_string "add_i32")) instantiated_module;;*)
  Some 1.
*)
