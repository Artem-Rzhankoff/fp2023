(** Copyright 2021-2023, Ilya Syresenkov *)

(** SPDX-License-Identifier: LGPL-3.0-or-later *)

(*
   TODO:
   1. Implenent standart IO funtions
*)

(** Identifiers for variables and functions names *)
type id = string

(** Binary operators *)
type binop =
  | Add (** + *)
  | Sub (** - *)
  | Div (** / *)
  | Mul (** * *)
  | Eq (** = *)
  | Neq (** <> *)

type const =
  | CInt of int (** Integers 1, 2, ... *)
  | CBool of bool (** Boolean true or false *)

(** Generally to match lists, but also could be used to match other datatypes *)
type pattern =
  | PWild (** | _ -> ... *)
  | PConst of const (** | const -> ... *)
  | PVar of id (** | varname -> ... *)
  | PCons of pattern * pattern (** | p1 :: p2 -> ... *)
  | POr of pattern * pattern (** | p1 | p2 | p3 -> ... *)

type is_rec =
  | Rec (** Recursive functions can call themselves in their body *)
  | NonRec

type expr =
  | EConst of const (** Consts *)
  | EVar of id (** Variables with their names *)
  | EBinop of binop * expr * expr (** e1 binop e2 *)
  | ETuple of expr list (** Tuples like ( 1, 2, 3 ) *)
  | EList of expr list (** Lists [1; 2; 3], ...*)
  | EBranch of expr * expr * expr (** if [cond] then [a] else [b] *)
  | EMatch of expr * (pattern * expr) list (** match [x] with | [p1] -> [e1] | ... *)
  | ELet of is_rec * id * expr * expr (** let rec f *)
  | EFun of id * expr (** Anonymous function *)
  | EApp of expr * expr (** Application f x *)