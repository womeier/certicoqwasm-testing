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
From Wasm Require Import datatypes pp.

From CertiCoq Require Import LambdaANF.toplevel Common.Common Common.compM Common.Pipeline_utils.
Require Import ExtLib.Structures.Monad.
From MetaCoq.Utils Require Import bytestring MCString.
From Coq Require Import ZArith List.

From CertiCoq Require Import LambdaANF.cps LambdaANF.cps_show CodegenWasm.LambdaANF_to_Wasm.
Import MonadNotation.

From Coq.Strings Require Import Byte.

From Wasm Require Import binary_format_parser binary_format_printer host
                         datatypes_properties check_toks instantiation_func instantiation_spec.

From mathcomp Require Import eqtype.

From mathcomp Require Import seq.

Module TestModule.

Variable host_function : eqType.
Let store_record := store_record host_function.
Let function_closure := function_closure host_function.


Definition test_bytes : list Byte.byte := x00 :: x61 :: x73 :: x6d :: x01 :: x00 :: x00 :: x00 :: x01 :: x07 :: x01 :: x60 :: x02 :: x7f :: x7f :: x01 :: x7f :: x03 :: x02 :: x01 :: x00 :: x07 :: x0b :: x01 :: x07 :: x61 :: x64 :: x64 :: x5f :: x69 :: x33 :: x32 :: x00 :: x00 :: x0a :: x09 :: x01 :: x07 :: x00 :: x20 :: x00 :: x20 :: x01 :: x6a :: x0b :: nil.

Definition test_module_opt : option module := run_parse_module test_bytes.
Compute test_module_opt.


Definition test_module := {|
  mod_types := [:: Tf [:: T_i32; T_i32] [:: T_i32]; Tf [] []];
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
  mod_imports := [:: {| imp_module := String.print "env"
                         ; imp_name := String.print write_char_function_name
                         ; imp_desc := ID_func 0
                         |} ];
  mod_exports :=
    [:: {|
          modexp_name := [:: "a"; "d"; "d"; "_"; "i"; "3"; "2"];
          modexp_desc := MED_func (Mk_funcidx 1)
        |}]
|}.

Definition imps_option := module_type_checker test_module.
Compute imps_option.

Compute option_map (fun ie => fst ie) imps_option.


Definition type_check_test_module_bytes :=
  m <- test_module_opt ;;
  module_type_checker m.

Compute type_check_test_module_bytes.

Definition test_function_type := Tf [T_i32; T_i32] [T_i32].
Definition test_function := {|
                modfunc_type := Mk_typeidx 0;
                modfunc_locals := [T_i32];
                modfunc_body :=
                  [BI_get_local 0; BI_get_local 1;
                  BI_binop T_i32 (Binop_i BOI_add)]
              |}.

End TestModule.


Section TestInst.
From Coq Require Import String.
Import TestModule.
Import eqtype seq host ssrbool.

Check test_module_opt.

Variable host_function : eqType.
Let store_record := store_record host_function.
Let function_closure := function_closure host_function.

Let host := host host_function.

Variable host_instance : host.

Let interp_alloc_module := interp_alloc_module host_function.
Let check_bounds_elem := check_bounds_elem host_function.
Let check_bounds_data := check_bounds_data host_function.
Let init_tabs := init_tabs host_function.
Let init_mems := init_mems host_function.

(* guarantee non-divergence during instantiation, only allow const *)
Definition extract_const g := match g.(modglob_init) with
| [:: BI_const c] => Ret c
| _ => Err "only constants allowed during instantiation"%bs
end : error value.

Definition extract_i32 instr :=  match instr with
   | [:: BI_const (VAL_int32 i)] => Ret i
   | _ => Err "expected const i32"%bs
end : error i32.

(* error monad from certicoq *)
Definition interp_instantiate (s : store_record) (m : module) (v_imps : list v_ext)
  : error (store_record * instance * list module_export) :=
  match module_type_checker m with
  | None => Err "module_type_checker failed"%bs
  | Some (t_imps, t_exps) =>
    if seq.all2 (external_type_checker s) v_imps t_imps then
      let inst_c := {|
            inst_types := nil;
            inst_funcs := nil;
            inst_tab := nil;
            inst_memory := nil;
            inst_globs := List.map (fun '(Mk_globalidx i) => i) (ext_globs v_imps);
          |} in
      (* init global vars *)
      g_inits <- sequence (List.map extract_const m.(mod_globals));;

      let '(s', inst, v_exps) := interp_alloc_module s m v_imps g_inits in

      e_offs <- sequence (List.map (fun e => extract_i32 e.(modelem_offset)) m.(mod_elem));;
      d_offs <- sequence (List.map (fun d => extract_i32 d.(moddata_offset)) m.(mod_data));;

      if check_bounds_elem inst s' m e_offs &&
         check_bounds_data inst s' m d_offs then
        match m.(mod_start) with
        | Some _ => Err "start function not supported"%bs
        | None =>
          let s'' := init_tabs s' inst (List.map nat_of_int e_offs) m.(mod_elem) in
          let s_end := init_mems s' inst (List.map N_of_int d_offs) m.(mod_data) in
          Ret (s_end, inst, v_exps)
        end
      else Err "bounds check failed"%bs
    else Err "external_type_checker failed"%bs
  end.

Definition empty_store_record : store_record := {|
    s_funcs := nil;
    s_tables := nil;
    s_mems := nil;
    s_globals := nil;
  |}.

Definition interp_instantiate_wrapper (m : module) imps
  : error (store_record * instance * list module_export) :=
  interp_instantiate empty_store_record m imps.

Definition inst_module : error (store_record * instance * list module_export) :=
  interp_instantiate_wrapper test_module [MED_func (Mk_funcidx 0)].
Compute inst_module.

Definition fn : error (store_record * frame * seq administrative_instruction)  :=
  m <- inst_module;;
  match lookup_exported_function [:: "a"; "d"; "d"; "_"; "i"; "3"; "2"] m with
  | Some x => Ret x
  | None => Err "function name not found"%bs
  end.

Compute fn.

End TestInst.
