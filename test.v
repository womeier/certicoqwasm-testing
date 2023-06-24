From CertiCoq.Plugin Require Import CertiCoq.
From Equations Require Import Equations.

From Coq Require Import List.
Import ListNotations.

Definition pred (n : nat) : nat :=
  match n with
  | 0 => 0
  | S n' => n'
  end.

Fixpoint odd (n : nat) : bool :=
  match n with
  | 0 => false
  | 1 => true
  | S (S n') => odd n'
  end.

Fixpoint map {A B} (f : A -> B) (l : list A) : list B :=
  match l with
  | nil => nil
  | cons hd tl => cons (f hd) (map f tl)
  end.

Definition even  (n : nat) : bool := odd (S n).

Definition inc (n : nat) : nat :=
  n + 1.

Definition const := 4.

Fixpoint mapAlternate {A B} (f g : A -> B) (l : list A) : list B :=
  match l with
  | nil => nil
  | cons hd tl => cons (f hd) (mapAlternate g f tl)
  end.

(* Definition foo := inc (const). *)
(* Definition foo := @map nat bool. *)

(* Definition foo := fun (x:bool) => inc 42. *)

(* Definition foo := map odd [100 ; 200 ; 103 ; 4]. *)

Definition foo := fold_left andb (map odd (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 nil)))))) true.
(* Definition foo := fold_left andb (map odd [1; 3; 5; 8]) true.*)

CertiCoq Show IR -cps -file "foo" foo.
CertiCoq Generate WASM -cps -file "foo" foo.

(* CertiCoq Show IR -cps -file "foo" foo. *)
(* CertiCoq Generate WASM -cps -file "foo" foo. *)
(* CertiCoq Compile -file "foo" foo. *)
