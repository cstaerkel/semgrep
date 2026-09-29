(* Christopher Staerkel
 *
 * Copyright (c) 2026 tripunkt GmbH
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * version 2.1 as published by the Free Software Foundation, with the
 * special exception on linking described in file LICENSE.
 *
 * This library is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the file
 * LICENSE for more details.
 *)
open Fpath_.Operators
module CST = Tree_sitter_pascal.CST
module H = Parse_tree_sitter_helpers
module G = AST_generic
module H2 = AST_generic_helpers

(*****************************************************************************)
(* Prelude *)
(*****************************************************************************)
(* Pascal (Delphi / Free Pascal) parser using tree-sitter-lang/semgrep-pascal
 * and converting directly to AST_generic.
 *
 * Source files are first run through Pascal_preprocessor, which resolves
 * {$IFDEF}-style conditional compilation while preserving all positions.
 *
 * Main design choices:
 *  - Pascal is case-insensitive: every identifier gets an id_info flagged
 *    case_insensitive, so `FreeAndNil` in a pattern matches `freeandnil`.
 *  - An expression statement is always a call in Pascal (`Obj.Free;` calls
 *    Free), so a non-call expression statement is turned into a Call with
 *    no arguments. `Obj.Free;` and `Obj.Free();` are thus equivalent.
 *    Metavariables and ellipses are left alone so that `$X;` and `...;` in a
 *    pattern keep their usual meaning.
 *  - The pseudo-procedures Exit, Break and Continue become Return, Break and
 *    Continue statements.
 *  - `inherited` becomes the Super special identifier, so `inherited;` is a
 *    call to Super and `inherited Create(A)` a call to Super.Create.
 *  - `=` is equality (Eq), `:=` is assignment.
 *)

(*****************************************************************************)
(* Helpers *)
(*****************************************************************************)

type context = Program | Pattern
type env = context H.env

let token = H.token
let fb = Tok.unsafe_fake_bracket
let fk s = Tok.unsafe_fake_tok s
let todo_kind (env : env) s tok : G.todo_kind = (s, token env tok)

(* Identifiers may be escaped with '&' to use a reserved word (&Type). *)
let str (env : env) (tok : Tree_sitter_run.Token.t) : G.ident =
  let s, t = H.str env tok in
  if String.length s > 1 && s.[0] = '&' then
    (String.sub s 1 (String.length s - 1), t)
  else (s, t)

let id_info () = G.empty_id_info ~case_insensitive:true ()
let name_of_id id = G.Id (id, id_info ())
let expr_of_id id = G.N (name_of_id id) |> G.e
let ty_of_id id = G.TyN (name_of_id id) |> G.t

let is_metavar_or_ellipsis_name (s : string) =
  String.length s > 1 && s.[0] = '$'

let lower = String.lowercase_ascii

(* Delphi hex literals are written $FF. *)
let parse_int ((s, t) : string * G.tok) : Parsed_int.t =
  if String.length s > 1 && s.[0] = '$' then
    Parsed_int.parse ("0x" ^ String.sub s 1 (String.length s - 1), t)
  else if String.length s > 1 && s.[0] = '%' then
    Parsed_int.parse ("0b" ^ String.sub s 1 (String.length s - 1), t)
  else Parsed_int.parse (s, t)

let block_of_stmts ?(l = fk "begin") ?(r = fk "end") stmts =
  G.Block (l, stmts, r) |> G.s

let stmt_of_stmts = function
  | [ s ] -> s
  | xs -> block_of_stmts xs

let entity_of_ident ?(attrs = []) id =
  { G.name = G.EN (name_of_id id); attrs; tparams = None }

let deopt = List.filter_map Fun.id

(* `a, b, c` in the CST: (x * sep) list option * x *)
let delimited (f : 'a -> 'b) ((xs, last) : ('a * 'sep) list option * 'a) :
    'b list =
  let xs =
    match xs with
    | Some xs -> List.map fst xs
    | None -> []
  in
  List.map f (xs @ [ last ])

(* In Pascal, a statement consisting of an expression is a call. *)
let callify (e : G.expr) : G.expr =
  match e.e with
  | G.N (G.Id ((s, _), _)) when is_metavar_or_ellipsis_name s -> e
  | G.N _
  | G.DotAccess _
  | G.ArrayAccess _
  | G.DeRef _ ->
      G.Call (e, fb []) |> G.e
  | _ -> e

(* Pascal allows calling a routine without parentheses: `TFoo.Create`,
 * `List.Clear`, `Now`. In expression position we cannot know whether
 * `A.B` is a field or a parameterless call, so in a *pattern*, a call
 * with no arguments or with only `...` also matches the callee alone:
 * `$C.Create(...)` matches both `TFoo.Create(nil)` and `TFoo.Create`.
 * A bare metavariable callee ($F(...)) is left alone, otherwise it would
 * match any expression. *)
let maybe_paramless_call (env : env) (call : G.expr) : G.expr =
  match (env.extra, call.e) with
  | Pattern, G.Call ({ e = G.N (G.Id ((s, _), _)); _ }, _)
    when is_metavar_or_ellipsis_name s ->
      call
  (* `inherited;` must not match `inherited Create(...)` *)
  | Pattern, G.Call ({ e = G.N (G.IdSpecial _); _ }, _) -> call
  | Pattern, G.Call (callee, (_, ([] | [ G.Arg { e = G.Ellipsis _; _ } ]), _))
    ->
      G.DisjExpr (call, callee) |> G.e
  | _ -> call

(* Exit, Exit(X), Break, Continue *)
let special_stmt_of_expr (_env : env) (e : G.expr) : G.stmt option =
  match e.e with
  | G.N (G.Id ((s, t), _)) -> (
      match lower s with
      | "exit" -> Some (G.Return (t, None, G.sc) |> G.s)
      | "break" -> Some (G.Break (t, G.LNone, G.sc) |> G.s)
      | "continue" -> Some (G.Continue (t, G.LNone, G.sc) |> G.s)
      | _ -> None)
  | G.Call ({ e = G.N (G.Id ((s, t), _)); _ }, (_, args, _)) -> (
      match (lower s, args) with
      | "exit", [ G.Arg a ] -> Some (G.Return (t, Some a, G.sc) |> G.s)
      | "exit", [] -> Some (G.Return (t, None, G.sc) |> G.s)
      | _ -> None)
  | _ -> None

let expr_stmt (env : env) (e : G.expr) (sc : G.tok) : G.stmt =
  let e =
    match e.e with
    (* undo the pattern disjunction added by map_ref *)
    | G.DisjExpr (({ e = G.Call _; _ } as call), _) -> call
    | _ -> e
  in
  let e = callify e in
  match special_stmt_of_expr env e with
  | Some st -> st
  (* At statement level `X.Free;` is unambiguously a call with no
   * arguments, so no disjunction here (it must not match X.Free(P)). *)
  | None -> G.ExprStmt (e, sc) |> G.s

(*****************************************************************************)
(* Names and literals *)
(*****************************************************************************)

let map_identifier (env : env) (tok : CST.identifier) : G.ident = str env tok

let map_modulename (env : env) ((xs, last) : CST.modulename) : G.dotted_ident =
  let xs =
    match xs with
    | Some xs -> List.map (fun (id, _dot) -> map_identifier env id) xs
    | None -> []
  in
  xs @ [ map_identifier env last ]

let map_literalint (env : env) (x : CST.literalint) : G.literal =
  match x with
  | `Imm_tok_pat_ec19546 tok
  | `Imm_tok_pat_d238afd tok
  | `Imm_tok_pat_f57674d tok ->
      G.Int (parse_int (str env tok))

let map_literalnumber (env : env) (x : CST.literalnumber) : G.literal =
  match x with
  | `Lite_65d24c1 x -> map_literalint env x
  | `Lite_bdeb053 tok ->
      let s, t = str env tok in
      if String.contains s '.' || String.contains s 'e' || String.contains s 'E'
      then G.Float (float_of_string_opt s, t)
      else G.Int (parse_int (s, t))

(* 'It''s' -> It's *)
let unquote_pascal_string (s : string) : string =
  let n = String.length s in
  let inner =
    if n >= 6 && String.sub s 0 3 = "'''" then
      (* multi-line string: strip the ''' delimiters *)
      String.sub s 3 (n - 6)
    else if n >= 2 then String.sub s 1 (n - 2)
    else s
  in
  let b = Buffer.create (String.length inner) in
  let i = ref 0 in
  let m = String.length inner in
  while !i < m do
    if inner.[!i] = '\'' && !i + 1 < m && inner.[!i + 1] = '\'' then (
      Buffer.add_char b '\'';
      i := !i + 2)
    else (
      Buffer.add_char b inner.[!i];
      incr i)
  done;
  Buffer.contents b

(* A Pascal string literal is a sequence of fragments: 'abc'#13#10'def' *)
let map_literalstring (env : env) (xs : CST.literalstring) : G.literal =
  let parts =
    xs
    |> List.map (fun (x : CST.literalstring_) ->
        match x with
        | `Pat_6c79139 tok
        | `Pat_cdd9bad tok ->
            let s, t = str env tok in
            (unquote_pascal_string s, t)
        | `Lite (hash, n) -> (
            let t = token env hash in
            match map_literalint env n with
            | G.Int pi -> (
                match Parsed_int.to_int_opt pi with
                | Some c when c >= 0 && c < 128 ->
                    (String.make 1 (Char.chr c), t)
                | _ -> ("?", t))
            | _ -> ("?", t)))
  in
  match parts with
  | [ (s, t) ] -> G.String (fb (s, t))
  | (_, t0) :: rest ->
      let s = String.concat "" (List.map fst parts) in
      let t = Tok.combine_toks t0 (List.map snd rest) in
      G.String (fb (s, t))
  | [] -> G.String (fb ("", fk "''"))

let map_literal (env : env) (x : CST.literal) : G.literal =
  match x with
  | `Lite_4d69a90 x -> map_literalstring env x
  | `Lite_f64c399 x -> map_literalnumber env x
  | `Knil tok -> G.Null (token env tok)
  | `Ktrue tok -> G.Bool (true, token env tok)
  | `Kfalse tok -> G.Bool (false, token env tok)

(* In Delphi, $FF is a hexadecimal number, so in a pattern the lexer reads
 * common metavariable names like $E, $F, $A or $DB as numbers. In a pattern,
 * a "hex number" made only of the letters A-F is therefore turned back
 * into a metavariable. To match a hex literal whose digits are all letters,
 * write it with a leading zero in the pattern ($0FF) or in decimal. *)
let metavar_of_hex_literal (env : env) (x : CST.literal) : G.ident option =
  match (env.extra, x) with
  | Pattern, `Lite_f64c399 (`Lite_65d24c1 (`Imm_tok_pat_d238afd tok)) ->
      let s, t = str env tok in
      let is_upper_af c = c >= 'A' && c <= 'F' in
      let body = String.sub s 1 (String.length s - 1) in
      if String.length body >= 1 && String.for_all is_upper_af body then
        Some (s, t)
      else None
  | _ -> None

(*****************************************************************************)
(* Types *)
(*****************************************************************************)

let rec map_typeref_ (env : env) (x : CST.typeref_) : G.type_ =
  match x with
  | `Id tok -> ty_of_id (map_identifier env tok)
  | `Type_3d7091c (a, dot, b) -> (
      (* Unit.TType *)
      let ta = map_typeref_ env a and tb = map_typeref_ env b in
      match (ta.t, tb.t) with
      | G.TyN n1, G.TyN (G.Id (id, _)) ->
          let ids = H2.dotted_ident_of_name n1 @ [ id ] in
          G.TyN (H2.name_of_ids ~case_insensitive:true ids) |> G.t
      | _ ->
          G.OtherType (todo_kind env "TypeDot" dot, [ G.T ta; G.T tb ]) |> G.t)
  | `Type_90e8385 (base, l, args, r) ->
      let base = map_typeref_ env base in
      let args = map_typerefargs env args in
      G.TyApply (base, (token env l, args, token env r)) |> G.t
  | `Type_cae2886 (hat, t) ->
      G.TyPointer (token env hat, map_typeref_ env t) |> G.t
  | `Ppfr tok -> G.OtherType (todo_kind env "PpFragment" tok, []) |> G.t

and map_typerefargs (env : env) ((xs, last) : CST.typerefargs) :
    G.type_argument list =
  delimited (fun t -> G.TA (map_typeref_ env t)) (xs, last)

let map_typeref (env : env) ((_spec, t, _depr) : CST.typeref) : G.type_ =
  map_typeref_ env t

let map_genericname_to_ids (env : env) (x : CST.genericname) :
    (G.ident * G.type_argument list option) list =
  let rec aux (x : CST.genericname) =
    match x with
    | `Id tok -> [ (map_identifier env tok, None) ]
    | `Gene_067353e (a, _dot, b) -> aux a @ aux b
    | `Gene_4088af4 (a, l, (xs, last), r) -> (
        let targs =
          delimited
            (fun ((_names, id, _constraint, _default) : CST.genericarg) ->
              G.TA (ty_of_id (map_identifier env id)))
            (xs, last)
        in
        ignore (l, r);
        match List.rev (aux a) with
        | (id, _) :: rest -> List.rev ((id, Some targs) :: rest)
        | [] -> [])
  in
  aux x

let name_of_genericname (env : env) (x : CST.genericname) : G.name =
  match map_genericname_to_ids env x with
  | [ (id, None) ] -> name_of_id id
  | ids -> (
      let ids_with_targs =
        List.map
          (fun (id, targs) -> (id, Option.map (fun xs -> fb xs) targs))
          ids
      in
      let name = H2.name_of_ids_with_opt_typeargs ids_with_targs in
      (* make the whole name case-insensitive *)
      match name with
      | G.IdQualified q -> G.IdQualified { q with name_info = id_info () }
      | G.Id (id, _) -> G.Id (id, id_info ())
      | n -> n)

let tparams_of_genericname (env : env) (x : CST.genericname) :
    G.type_parameters option =
  match x with
  | `Gene_4088af4 (_a, l, (xs, last), r) ->
      let tps =
        delimited
          (fun ((more, id, constr, _default) : CST.genericarg) ->
            let ids =
              (match more with
                | Some xs -> List.map (fun (i, _) -> map_identifier env i) xs
                | None -> [])
              @ [ map_identifier env id ]
            in
            let bounds =
              match constr with
              | Some (_colon, t) -> [ map_typeref env t ]
              | None -> []
            in
            List.map
              (fun tp_id ->
                G.TP
                  {
                    G.tp_id;
                    tp_attrs = [];
                    tp_bounds = bounds;
                    tp_default = None;
                    tp_variance = None;
                  })
              ids)
          (xs, last)
        |> List_.flatten
      in
      Some (token env l, tps, token env r)
  | _ -> None

(*****************************************************************************)
(* Expressions *)
(*****************************************************************************)

let binop env (a : G.expr) (op : G.operator) tok (b : G.expr) : G.expr =
  G.opcall (op, token env tok) [ a; b ]

let rec map_expr (env : env) (x : CST.expr) : G.expr =
  match x with
  | `Ref x -> map_ref env x
  | `Expr_ef29a06 x -> map_exprbinary env x
  | `Expr_5c4be6d x -> map_exprunary env x
  | `Expr_3037366 (_if, c, _then, a, _else, b) ->
      G.Conditional (map_expr env c, map_expr env a, map_expr env b) |> G.e

and map_exprbinary (env : env) (x : CST.exprbinary) : G.expr =
  let e = map_expr env in
  match x with
  | `Expr_klt_expr (a, t, b) -> binop env (e a) G.Lt t (e b)
  | `Ref_klt_expr (a, t, b) -> binop env (map_ref env a) G.Lt t (e b)
  | `Expr_keq_expr (a, t, b) -> binop env (e a) G.Eq t (e b)
  | `Expr_kneq_expr (a, t, b) -> binop env (e a) G.NotEq t (e b)
  | `Expr_kgt_expr (a, t, b) -> binop env (e a) G.Gt t (e b)
  | `Expr_klte_expr (a, t, b) -> binop env (e a) G.LtE t (e b)
  | `Expr_kgte_expr (a, t, b) -> binop env (e a) G.GtE t (e b)
  | `Expr_kin_expr (a, t, b) -> binop env (e a) G.In t (e b)
  | `Expr_kis_expr (a, t, b) ->
      G.Call
        ( G.Special (G.Instanceof, token env t) |> G.e,
          fb [ G.Arg (e a); G.ArgType (G.TyExpr (e b) |> G.t) ] )
      |> G.e
  | `Expr_knot_kin_expr (a, _not, t, b) -> binop env (e a) G.NotIn t (e b)
  | `Expr_expr_expr (a, (tis, tnot), b) ->
      let inst =
        G.Call
          ( G.Special (G.Instanceof, token env tis) |> G.e,
            fb [ G.Arg (e a); G.ArgType (G.TyExpr (e b) |> G.t) ] )
        |> G.e
      in
      G.opcall (G.Not, token env tnot) [ inst ]
  | `Expr_kadd_expr (a, t, b) -> binop env (e a) G.Plus t (e b)
  | `Expr_ksub_expr (a, t, b) -> binop env (e a) G.Minus t (e b)
  | `Expr_kor_expr (a, t, b) -> binop env (e a) G.Or t (e b)
  | `Expr_kxor_expr (a, t, b) -> binop env (e a) G.Xor t (e b)
  | `Expr_kmul_expr (a, t, b) -> binop env (e a) G.Mult t (e b)
  | `Expr_kfdiv_expr (a, t, b) -> binop env (e a) G.Div t (e b)
  | `Expr_kdiv_expr (a, t, b) -> binop env (e a) G.FloorDiv t (e b)
  | `Expr_kmod_expr (a, t, b) -> binop env (e a) G.Mod t (e b)
  | `Expr_kand_expr (a, t, b) -> binop env (e a) G.And t (e b)
  | `Expr_kshl_expr (a, t, b) -> binop env (e a) G.LSL t (e b)
  | `Expr_kshr_expr (a, t, b) -> binop env (e a) G.LSR t (e b)

and map_exprunary (env : env) (x : CST.exprunary) : G.expr =
  match x with
  | `Knot_expr (t, a) -> G.opcall (G.Not, token env t) [ map_expr env a ]
  | `Kadd_expr (t, a) -> G.opcall (G.Plus, token env t) [ map_expr env a ]
  | `Ksub_expr (t, a) -> (
      let a = map_expr env a in
      match a.e with
      (* keep -1 a literal *)
      | G.L (G.Int pi) -> G.L (G.Int (Parsed_int.neg pi)) |> G.e
      | _ -> G.opcall (G.Minus, token env t) [ a ])
  | `Kat_expr (t, a) -> G.Ref (token env t, map_expr env a) |> G.e

and map_exprargs (env : env) ((xs, last, _fmt) : CST.exprargs) : G.argument list
    =
  let xs =
    match xs with
    | Some xs -> List.map (fun (e, _fmt, _comma) -> e) xs
    | None -> []
  in
  List.map (fun e -> G.Arg (map_expr env e)) (xs @ [ last ])

and map_expr_or_range (env : env) (x : CST.anon_choice_expr_0b0705b) : G.expr =
  match x with
  | `Expr e -> map_expr env e
  | `Range r -> map_range env r

and map_range (env : env) ((a, dots, b) : CST.range) : G.expr =
  G.opcall (G.Range, token env dots) [ map_expr env a; map_expr env b ]

and map_ref (env : env) (x : CST.ref) : G.expr =
  match x with
  | `Choice_kspe_id (`Kspe_id (_spec, id)) -> expr_of_id (map_identifier env id)
  | `Choice_kspe_id (`Kspe tok) -> expr_of_id (str env tok)
  | `Id tok -> expr_of_id (map_identifier env tok)
  | `Lit x -> (
      match metavar_of_hex_literal env x with
      | Some id -> expr_of_id id
      | None -> G.L (map_literal env x) |> G.e)
  | `Inhe (tinh, idopt) -> (
      let super =
        G.N (G.IdSpecial ((G.Super, token env tinh), id_info ())) |> G.e
      in
      match idopt with
      | None -> super
      | Some id ->
          G.DotAccess (super, fk ".", G.FN (name_of_id (map_identifier env id)))
          |> G.e)
  | `Expr_4f305a9 (a, dot, b) -> (
      let a = map_ref env a in
      let tdot = token env dot in
      match b with
      | `Id tok ->
          G.DotAccess (a, tdot, G.FN (name_of_id (map_identifier env tok)))
          |> G.e
      | `Semg_ellips tok ->
          (* $X. ... *)
          G.DotAccessEllipsis (a, token env tok) |> G.e
      | _ ->
          (* a.b(...) / a.b[...]: re-associate so the call applies to the
           * dotted access: Obj.Method(X) is Call(DotAccess(Obj, Method)) *)
          reassociate_dot env a tdot b)
  | `Exprbs (l, contents, r) ->
      let xs =
        match contents with
        | Some (xs, last) -> delimited (map_expr_or_range env) (xs, last)
        | None -> []
      in
      G.Container (G.Array, (token env l, xs, token env r)) |> G.e
  | `Exprps (_l, e, _r) -> map_expr env e
  | `Expr_2b043f4 (a, l, args, r) -> (
      let a = map_ref env a in
      let args =
        map_exprargs env args
        |> List.map (function
          | G.Arg e -> e
          | _ -> assert false)
      in
      match args with
      | [ i ] -> G.ArrayAccess (a, (token env l, i, token env r)) |> G.e
      | xs ->
          G.ArrayAccess
            (a, (token env l, G.Container (G.Tuple, fb xs) |> G.e, token env r))
          |> G.e)
  | `Expr_31f068a (f, l, args, r) ->
      let f = map_ref env f in
      let args =
        match args with
        | Some args -> map_exprargs env args
        | None -> []
      in
      G.Call (f, (token env l, args, token env r))
      |> G.e |> maybe_paramless_call env
  | `Expr_abfcfa5 (e, hat) -> G.DeRef (token env hat, map_expr env e) |> G.e
  | `Expras (e, tas, t) ->
      G.Cast (G.TyExpr (map_expr env t) |> G.t, token env tas, map_expr env e)
      |> G.e
  | `Expr_1293f4f (base, l, xs, last, r) -> (
      (* TList<Integer> in expression position *)
      let targs = delimited (fun t -> G.TA (map_typeref_ env t)) (xs, last) in
      let base = map_ref env base in
      match base.e with
      | G.N (G.Id (id, _)) ->
          G.N
            (G.IdQualified
               {
                 G.name_last = (id, Some (token env l, targs, token env r));
                 name_middle = None;
                 name_top = None;
                 name_info = id_info ();
               })
          |> G.e
      | _ ->
          G.OtherExpr
            ( todo_kind env "TypeApply" l,
              G.E base :: List.map (fun ta -> G.Ta ta) targs )
          |> G.e)
  | `Lambda (kind, args, ret, locals, body) ->
      let tkind =
        match kind with
        | `Kpro t
        | `Kfun t ->
            token env t
      in
      let fdef =
        {
          G.fkind = (G.LambdaKind, tkind);
          fparams = map_declargs_opt env args;
          frettype = Option.map (fun (_, t) -> map_typeref env t) ret;
          fbody = G.FBStmt (map_body env locals body);
        }
      in
      G.Lambda fdef |> G.e
  | `Ppfr tok -> G.OtherExpr (todo_kind env "PpFragment" tok, []) |> G.e
  | `Semg_ellips tok -> G.Ellipsis (token env tok) |> G.e
  | `Deep_ellips (l, e, r) ->
      G.DeepEllipsis (token env l, map_expr env e, token env r) |> G.e

(* The grammar parses `a.b(x)` as exprDot(a, exprCall(b, x)) because of
 * precedences; rebuild it as Call(DotAccess(a, b), x). *)
and reassociate_dot (env : env) (a : G.expr) (tdot : G.tok) (b : CST.ref) :
    G.expr =
  let b' = map_ref env b in
  let rec rebuild (b' : G.expr) : G.expr =
    match b'.e with
    | G.N name -> G.DotAccess (a, tdot, G.FN name) |> G.e
    | G.Call (f, args) -> G.Call (rebuild f, args) |> G.e
    | G.ArrayAccess (x, idx) -> G.ArrayAccess (rebuild x, idx) |> G.e
    | G.DeRef (t, x) -> G.DeRef (t, rebuild x) |> G.e
    | G.DotAccess (x, t, fld) -> G.DotAccess (rebuild x, t, fld) |> G.e
    | G.DisjExpr (x, y) -> G.DisjExpr (rebuild x, rebuild y) |> G.e
    | _ -> G.DotAccess (a, tdot, G.FDynamic b') |> G.e
  in
  rebuild b'

(*****************************************************************************)
(* Parameters *)
(*****************************************************************************)

and map_defaultvalue (env : env) ((_eq, init) : CST.defaultvalue) : G.expr =
  map_initializer env init

and map_initializer (env : env) (x : CST.initializer_) : G.expr =
  match x with
  | `Expr e -> map_expr env e
  | `Reci (l, xs, last, _semi, r) ->
      let fields =
        List.map fst xs @ [ last ]
        |> List.map (fun (f : CST.recinitializerfield) ->
            match f with
            | `Id_COLON_init (id, _colon, init) ->
                let id = map_identifier env id in
                G.basic_field id (Some (map_initializer env init)) None
            | `Init init -> G.F (G.exprstmt (map_initializer env init)))
      in
      G.Record (token env l, fields, token env r) |> G.e
  | `Arri (l, xs, last, r) ->
      let xs =
        (match xs with
          | Some xs -> List.map fst xs
          | None -> [])
        @ [ last ]
      in
      G.Container
        (G.Array, (token env l, List.map (map_initializer env) xs, token env r))
      |> G.e

and map_declargs_opt (env : env) (x : CST.declargs option) : G.parameters =
  match x with
  | None -> fb []
  | Some (l, contents, r) ->
      let params =
        match contents with
        | None -> []
        | Some (xs, last) ->
            delimited (map_declarg env) (xs, last) |> List_.flatten
      in
      (token env l, params, token env r)

and map_declarg (env : env) (x : CST.declarg) : G.parameter list =
  match x with
  | `Semg_ellips tok -> [ G.ParamEllipsis (token env tok) ]
  | `Choice_choice_kvar_opt_rep1_id_COMMA_id_opt_COLON_type_opt_defa x -> (
      match x with
      | `Choice_kvar_opt_rep1_id_COMMA_id_opt_COLON_type_opt_defa
          (modifier, more, id, typ) ->
          let attrs =
            match modifier with
            | `Kvar t -> [ G.KeywordAttr (G.Var, token env t) ]
            | `Kout t -> [ G.OtherAttribute (todo_kind env "out" t, []) ]
            | `Kcon t -> [ G.KeywordAttr (G.Const, token env t) ]
            | `Kconst_opt_rttias (t, _attrs) ->
                [ G.KeywordAttr (G.Const, token env t) ]
          in
          let ptype, pdefault =
            match typ with
            | Some (_colon, t, def) ->
                (Some (map_type env t), Option.map (map_defaultvalue env) def)
            | None -> (None, None)
          in
          let ids =
            (match more with
              | Some xs -> List.map (fun (i, _) -> map_identifier env i) xs
              | None -> [])
            @ [ map_identifier env id ]
          in
          List.map
            (fun id ->
              G.Param
                {
                  G.pname = Some id;
                  ptype;
                  pdefault;
                  pattrs = attrs;
                  pinfo = id_info ();
                })
            ids
      | `Opt_rep1_id_COMMA_id_COLON_type_opt_defa
          ((more, id, _colon, t, def) : CST.declvariantfield) ->
          let ptype = Some (map_type env t) in
          let pdefault = Option.map (map_defaultvalue env) def in
          let ids =
            (match more with
              | Some xs -> List.map (fun (i, _) -> map_identifier env i) xs
              | None -> [])
            @ [ map_identifier env id ]
          in
          List.map
            (fun id ->
              G.Param
                {
                  G.pname = Some id;
                  ptype;
                  pdefault;
                  pattrs = [];
                  pinfo = id_info ();
                })
            ids)

(*****************************************************************************)
(* Types (full) *)
(*****************************************************************************)

and map_type (env : env) (x : CST.type_) : G.type_ =
  match x with
  | `Type t -> map_typeref env t
  | `Decl_172a5fa (tclass, _of, t) ->
      G.OtherType (todo_kind env "ClassOf" tclass, [ G.T (map_typeref env t) ])
      |> G.t
  | `Decl_b2059ac (l, _, _, _) ->
      (* anonymous enumeration: (a, b, c) *)
      G.OtherType (todo_kind env "Enum" l, []) |> G.t
  | `Decl_9b757b1 (tset, _of, t) ->
      G.OtherType (todo_kind env "SetOf" tset, [ G.T (map_type env t) ]) |> G.t
  | `Decl_fb3a596 (_packed, tarray, dims, _of, t) ->
      let elt = map_type env t in
      let dim =
        match dims with
        | Some (_l, Some (xs, last), _r) -> (
            match
              delimited
                (fun (x : CST.anon_choice_range_ff5eaed) ->
                  match x with
                  | `Range r -> map_range env r
                  | `Expr e -> map_expr env e)
                (xs, last)
            with
            | [ d ] -> Some d
            | ds -> Some (G.Container (G.Tuple, fb ds) |> G.e))
        | _ -> None
      in
      G.TyArray ((token env tarray, dim, fk "]"), elt) |> G.t
  | `Decl_d33f432 (tfile, _) ->
      G.OtherType (todo_kind env "File" tfile, []) |> G.t
  | `Decl_4e1d441 (tstring, _, _) -> ty_of_id (str env tstring)
  | `Decl_4eec7e9 (_ref, kind, args, ret, _ofobject, _cc) ->
      let params = map_declargs_opt env args in
      let _, params, _ = params in
      let ret =
        match ret with
        | Some (_, t) -> map_typeref env t
        | None ->
            let t =
              match kind with
              | `Kpro t
              | `Kfun t ->
                  token env t
            in
            G.TyN (name_of_id ("void", t)) |> G.t
      in
      G.TyFun (params, ret) |> G.t
  | `Decl_0ebbf4b (a, dots, b) ->
      G.OtherType
        ( todo_kind env "SubRange" dots,
          [ G.E (map_subrangebound env a); G.E (map_subrangebound env b) ] )
      |> G.t
  | `Decl_dd9f703 (_packed, trecord, body) ->
      let fields = map_declclass_ env body in
      G.TyRecordAnon ((G.Class, token env trecord), fields) |> G.t

and map_subrangebound (env : env) (x : CST.subrangebound) : G.expr =
  match x with
  | `Lite_f64c399 n -> G.L (map_literalnumber env n) |> G.e
  | `Choice_DASH_lite (sign, n) -> (
      let lit = map_literalnumber env n in
      match (sign, lit) with
      | `DASH _, G.Int pi -> G.L (G.Int (Parsed_int.neg pi)) |> G.e
      | (`DASH t | `PLUS t), lit ->
          G.opcall
            ( (match sign with
              | `DASH _ -> G.Minus
              | `PLUS _ -> G.Plus),
              token env t )
            [ G.L lit |> G.e ])
  | `Lite_4d69a90 s -> G.L (map_literalstring env s) |> G.e
  | `Type_ t -> (
      let t = map_typeref_ env t in
      match t.t with
      | G.TyN n -> G.N n |> G.e
      | _ -> G.TypedMetavar (("_", fk "_"), fk ":", t) |> G.e)

(*****************************************************************************)
(* Statements *)
(*****************************************************************************)

and map_assignment (env : env) ((lhs, op, rhs) : CST.assignment) : G.stmt =
  let rhs = map_expr env rhs in
  match lhs with
  | `Vara (tvar, id, typ) ->
      (* inline variable: var X := ...; var X: T := ...; *)
      let id = map_identifier env id in
      let ent =
        entity_of_ident ~attrs:[ G.KeywordAttr (G.Var, token env tvar) ] id
      in
      G.DefStmt
        ( ent,
          G.VarDef
            {
              G.vinit = Some rhs;
              vtype = Option.map (fun (_, t) -> map_typeref env t) typ;
              vtok = G.no_sc;
            } )
      |> G.s
  | `Expr lhs -> (
      let lhs = map_expr env lhs in
      match op with
      | `Kass_82d56ca t -> G.exprstmt (G.Assign (lhs, token env t, rhs) |> G.e)
      | `Kass_ba783c9 t ->
          G.exprstmt (G.AssignOp (lhs, (G.Plus, token env t), rhs) |> G.e)
      | `Kass_4c2e9df t ->
          G.exprstmt (G.AssignOp (lhs, (G.Minus, token env t), rhs) |> G.e)
      | `Kass_f4032f6 t ->
          G.exprstmt (G.AssignOp (lhs, (G.Mult, token env t), rhs) |> G.e)
      | `Kass_e6faaf6 t ->
          G.exprstmt (G.AssignOp (lhs, (G.Div, token env t), rhs) |> G.e))

and map_vardef (env : env) ((tvar, id, _colon, t) : CST.vardef) : G.stmt =
  let ent =
    entity_of_ident
      ~attrs:[ G.KeywordAttr (G.Var, token env tvar) ]
      (map_identifier env id)
  in
  G.DefStmt
    ( ent,
      G.VarDef
        { G.vinit = None; vtype = Some (map_typeref env t); vtok = G.no_sc } )
  |> G.s

and map_label (env : env) ((id, _colon) : CST.label) : G.ident =
  map_identifier env id

and map_statementtr_opt (env : env) (x : CST.statementtr option) : G.stmt =
  match x with
  | Some s -> map_statementtr env s
  | None -> block_of_stmts []

and map_if (env : env) tif cond then_ else_ : G.stmt =
  G.If (token env tif, G.Cond (map_expr env cond), then_, else_) |> G.s

and map_then_branch (env : env) (x : CST.anon_choice_stat_2a62092 option) :
    G.stmt =
  match x with
  | None -> block_of_stmts []
  | Some (`Stat s) -> map_statementtr env s
  | Some (`If (tif, c, _then, s)) -> map_if env tif c (map_statement env s) None

and map_for (env : env) tfor (asgn : CST.assignment) dir (e_end : CST.expr)
    (body : G.stmt) : G.stmt =
  let init = map_assignment env asgn in
  let var =
    match init.s with
    | G.ExprStmt ({ e = G.Assign (v, _, _); _ }, _) -> Some v
    | G.DefStmt (({ name = G.EN n; _ } : G.entity), _) -> Some (G.N n |> G.e)
    | _ -> None
  in
  let init_x =
    match init.s with
    | G.ExprStmt (e, _) -> [ G.ForInitExpr e ]
    | G.DefStmt (ent, G.VarDef vd) -> [ G.ForInitVar (ent, vd) ]
    | _ -> []
  in
  let op, tdir =
    match dir with
    | `Kto t -> (G.LtE, token env t)
    | `Kdow t -> (G.GtE, token env t)
  in
  let cond =
    Option.map (fun v -> G.opcall (op, tdir) [ v; map_expr env e_end ]) var
  in
  G.For (token env tfor, G.ForClassic (init_x, cond, None), body) |> G.s

and map_foreach (env : env) tfor (iter : CST.anon_choice_expr_2fa3e6e) tin coll
    body : G.stmt =
  let pat =
    match iter with
    | `Expr e -> H2.expr_to_pattern (map_expr env e)
    | `Vara (_tvar, id, _typ) ->
        let id = map_identifier env id in
        G.PatId (id, id_info ())
  in
  G.For (token env tfor, G.ForEach (pat, token env tin, map_expr env coll), body)
  |> G.s

and map_try (env : env) ttry body
    (handlers : CST.anon_choice_kexc_opt_choice_stat__d8e7a89) : G.stmt =
  let body = map_statementstr_opt env body in
  match handlers with
  | `Kfin_opt_stat_ (tfin, stmts) ->
      let fin = map_statementstr_opt env stmts in
      G.Try (token env ttry, body, [], None, Some (token env tfin, fin)) |> G.s
  | `Kexc_opt_choice_stat_ (texc, content) ->
      let texc = token env texc in
      let catch_all body = (texc, G.CatchPattern (G.PatWildcard texc), body) in
      let catches =
        match content with
        | None -> [ catch_all (block_of_stmts []) ]
        | Some (`Stat_ stmts) -> [ catch_all (map_statementstr env stmts) ]
        | Some (`Exce (hs, last, else_)) ->
            let hs = List.map (map_exceptionhandler env) hs in
            let last =
              match last with
              | `Exce_66e7373 h -> map_exceptionhandler env h
              | `Exce_89cca21 (ton, lbl, t, _do, s) ->
                  map_handler env ton lbl t (map_statementtr_opt env s)
            in
            let else_ =
              match else_ with
              | Some (telse, xs, last) ->
                  [
                    ( token env telse,
                      G.CatchPattern (G.PatWildcard (token env telse)),
                      stmt_of_stmts
                        (List.map (map_statement env) (xs @ [ last ])) );
                  ]
              | None -> []
            in
            hs @ [ last ] @ else_
      in
      G.Try (token env ttry, body, catches, None, None) |> G.s

and map_exceptionhandler (env : env)
    ((ton, lbl, t, _do, s) : CST.exceptionhandler) : G.catch =
  map_handler env ton lbl t (map_statement env s)

and map_handler (env : env) ton (lbl : CST.label option) t body : G.catch =
  let ty = map_typeref env t in
  let pname = Option.map (map_label env) lbl in
  ( token env ton,
    G.CatchParam
      {
        G.pname;
        ptype = Some ty;
        pdefault = None;
        pattrs = [];
        pinfo = id_info ();
      },
    body )

and map_caselabel (env : env) ((xs, last, _colon) : CST.caselabel) : G.case list
    =
  delimited
    (fun x -> G.CaseEqualExpr (fk "case", map_expr_or_range env x))
    (xs, last)

and map_case (env : env) tcase e (cases : CST.casecase list)
    (lastcase : CST.casecasetr option)
    (else_ : CST.anon_choice_kelse_opt_COLON_opt_stat__c22ab7e option) : G.stmt
    =
  let cases =
    List.map
      (fun ((lbl, s) : CST.casecase) ->
        G.CasesAndBody (map_caselabel env lbl, map_statement env s))
      cases
  in
  let lastcase =
    match lastcase with
    | Some (lbl, s) ->
        [ G.CasesAndBody (map_caselabel env lbl, map_statementtr_opt env s) ]
    | None -> []
  in
  let default =
    match else_ with
    | Some (kelse, _colon, stmts) ->
        let t =
          match kelse with
          | `Kelse t
          | `Koth t ->
              token env t
        in
        [ G.CasesAndBody ([ G.Default t ], map_statementstr_opt env stmts) ]
    | None -> []
  in
  G.Switch
    (token env tcase, Some (G.Cond (map_expr env e)), cases @ lastcase @ default)
  |> G.s

and map_with (env : env) twith (xs : CST.anon_opt_rep1_expr_COMMA_39d8f3f)
    (last : CST.expr) body : G.stmt =
  let es =
    (match xs with
      | Some xs -> List.map fst xs
      | None -> [])
    @ [ last ]
  in
  G.OtherStmtWithStmt
    ( G.OSWS_With,
      G.Tk (token env twith) :: List.map (fun e -> G.E (map_expr env e)) es,
      body )
  |> G.s

and map_raise (env : env) traise (e : CST.expr option) at sc : G.stmt =
  let t = token env traise in
  match e with
  | Some e -> (
      let e = map_expr env e in
      match at with
      | None -> G.Throw (t, e, sc) |> G.s
      | Some (tat, addr) ->
          G.OtherStmt
            ( G.OS_ThrowArgsLocation,
              [ G.Tk t; G.E e; G.Tk (token env tat); G.E (map_expr env addr) ]
            )
          |> G.s)
  | None -> G.OtherStmt (G.OS_ThrowNothing, [ G.Tk t ]) |> G.s

and map_asm (env : env) tasm tend : G.stmt =
  G.OtherStmt (G.OS_Asm, [ G.Tk (token env tasm); G.Tk (token env tend) ])
  |> G.s

and map_statement (env : env) (x : CST.statement) : G.stmt =
  match x with
  | `SEMI t ->
      G.Block (fb []) |> G.s |> fun s ->
      ignore t;
      s
  | `Assign_SEMI (a, _sc) -> map_assignment env a
  | `Vardef_SEMI (v, _sc) -> map_vardef env v
  | `Stmt_ (`Expr_SEMI (e, sc)) -> expr_stmt env (map_expr env e) (token env sc)
  | `If (tif, c, _then, s) -> map_if env tif c (map_statement env s) None
  | `Ifelse (tif, c, _then, then_, _else, else_) ->
      map_if env tif c
        (map_then_branch env then_)
        (Some (map_statement env else_))
  | `While (twhile, c, _do, s) ->
      G.While (token env twhile, G.Cond (map_expr env c), map_statement env s)
      |> G.s
  | `Repeat (trepeat, body, _until, c, _sc) -> map_repeat env trepeat body c
  | `For (tfor, asgn, dir, e, _do, s) ->
      map_for env tfor asgn dir e (map_statement env s)
  | `Fore (tfor, iter, tin, coll, _do, s) ->
      map_foreach env tfor iter tin coll (map_statement env s)
  | `Try (ttry, body, handlers, _end, _sc) -> map_try env ttry body handlers
  | `Case (tcase, e, _of, cases, lastcase, else_, _end, _sc) ->
      map_case env tcase e cases lastcase else_
  | `Blk (tbegin, stmts, tend, _sc) -> map_block env tbegin stmts tend
  | `With (twith, xs, last, _do, s) ->
      map_with env twith xs last (map_statement env s)
  | `Raise (traise, e, at, sc) -> map_raise env traise e at (token env sc)
  | `Goto (tgoto, id, sc) ->
      G.Goto (token env tgoto, map_identifier env id, token env sc) |> G.s
  | `Asm (tasm, _body, tend, _sc) -> map_asm env tasm tend
  | `Semg_ellips tok -> G.exprstmt (G.Ellipsis (token env tok) |> G.e)

and map_repeat (env : env) trepeat body c : G.stmt =
  (* repeat S until C  ~  do S while not C *)
  let t = token env trepeat in
  let body = map_statementstr_opt env body in
  G.DoWhile (t, body, G.opcall (G.Not, fk "not") [ map_expr env c ]) |> G.s

and map_block (env : env) tbegin stmts tend : G.stmt =
  let stmts =
    match stmts with
    | Some x -> map_statementstr_list env x
    | None -> []
  in
  G.Block (token env tbegin, stmts, token env tend) |> G.s

and map_statementtr (env : env) (x : CST.statementtr) : G.stmt =
  match x with
  | `Assign a -> map_assignment env a
  | `Vardef v -> map_vardef env v
  | `Stat_ (`Expr e) -> expr_stmt env (map_expr env e) G.sc
  | `Iftr (tif, c, _then, s) ->
      map_if env tif c (map_statementtr_opt env s) None
  | `Ifel (tif, c, _then, then_, _else, else_) ->
      map_if env tif c
        (map_then_branch env then_)
        (Some (map_statementtr_opt env else_))
  | `Whil (twhile, c, _do, s) ->
      G.While
        (token env twhile, G.Cond (map_expr env c), map_statementtr_opt env s)
      |> G.s
  | `Repe (trepeat, body, _until, c) -> map_repeat env trepeat body c
  | `Fortr (tfor, asgn, dir, e, _do, s) ->
      map_for env tfor asgn dir e (map_statementtr_opt env s)
  | `Fore (tfor, iter, tin, coll, _do, s) ->
      map_foreach env tfor iter tin coll (map_statementtr_opt env s)
  | `Trytr (ttry, body, handlers, _end) -> map_try env ttry body handlers
  | `Casetr (tcase, e, _of, cases, lastcase, else_, _end) ->
      map_case env tcase e cases lastcase else_
  | `Bloc (tbegin, stmts, tend) -> map_block env tbegin stmts tend
  | `Withtr (twith, xs, last, _do, s) ->
      map_with env twith xs last (map_statementtr_opt env s)
  | `Rais (traise, e, at) -> map_raise env traise e at G.sc
  | `Gototr (tgoto, id) ->
      G.Goto (token env tgoto, map_identifier env id, G.sc) |> G.s
  | `Asmtr (tasm, _body, tend) -> map_asm env tasm tend

(* Labels (L:) prefix the statement that follows them. *)
and attach_labels (items : [ `Stmt of G.stmt | `Label of G.ident ] list) :
    G.stmt list =
  let rec aux acc = function
    | [] -> List.rev acc
    | `Label id :: rest -> (
        match aux [] rest with
        | s :: rest' -> List.rev acc @ [ G.Label (id, s) |> G.s ] @ rest'
        | [] -> List.rev acc @ [ G.Label (id, block_of_stmts []) |> G.s ])
    | `Stmt s :: rest -> aux (s :: acc) rest
  in
  aux [] items

and map_statementstr_list (env : env) ((xs, last) : CST.statementstr) :
    G.stmt list =
  let items =
    List.filter_map
      (fun x ->
        match x with
        | `Stmt s -> Some (`Stmt (map_statement env s))
        | `Label l -> Some (`Label (map_label env l))
        | `Ppbl b -> Some (`Stmt (map_ppblock env b))
        | `Ppfr _ -> None)
      xs
  in
  let last =
    match last with
    | `Stat s -> Some (`Stmt (map_statementtr env s))
    | `Stmt s -> Some (`Stmt (map_statement env s))
    | `Ppbl b -> Some (`Stmt (map_ppblock env b))
    | `Ppfr _ -> None
  in
  attach_labels (items @ Option.to_list last)
  (* drop empty statements produced by stray semicolons *)
  |> List.filter (fun (s : G.stmt) ->
      match s.s with
      | G.Block (_, [], _) -> false
      | _ -> true)

and map_statementstr (env : env) (x : CST.statementstr) : G.stmt =
  block_of_stmts (map_statementstr_list env x)

and map_statementstr_opt (env : env) (x : CST.statementstr option) : G.stmt =
  match x with
  | Some x -> map_statementstr env x
  | None -> block_of_stmts []

(* Should not happen after preprocessing, but the grammar supports it. *)
and map_ppblock (env : env) ((tif, xs, elses, _tend) : CST.ppblock) : G.stmt =
  let branch xs = List.concat_map (map_pp_item env) xs in
  let first = branch xs in
  let others = List.concat_map (fun (_telse, xs) -> branch xs) elses in
  ignore tif;
  stmt_of_stmts (first @ others)

and map_pp_item (env : env) (x : CST.anon_choice_decl_fe4bcc4) : G.stmt list =
  match x with
  | `Decl_c64a659 d -> map_decltype env d
  | `Decl_a20e53a d -> map_declvar env ~is_field:false d
  | `Decl_d45e488 d -> map_declconst env d
  | `Decl_6ec32a9 d -> [ map_declproc env d ]
  | `Decl_5f998b5 d -> [ map_declprop env d ]
  | `Decl_8dd77dd d -> [ map_declprocfwd env d ]
  | `Decl_497d63e d -> map_declfield env d
  | `Declts d -> map_decltypes env d
  | `Declvs d -> map_declvars env d
  | `Declcs d -> map_declconsts env d
  | `Defp d -> [ map_defproc env d ]
  | `Declus d -> map_decluses env d
  | `Declls _
  | `Decles _ ->
      []
  | `Stmt s -> [ map_statement env s ]
  | `Ppbl b -> [ map_ppblock env b ]
  | `SEMI _
  | `COMMA _ ->
      []

(*****************************************************************************)
(* Declarations *)
(*****************************************************************************)

and map_attributes_procattr_ (env : env) (x : CST.procattribute_) : G.attribute
    =
  let kw k t = G.KeywordAttr (k, token env t) in
  let other t = G.OtherAttribute (todo_kind env (fst (H.str env t)) t, []) in
  match x with
  | `Ksta t -> kw G.Static t
  | `Kvir t -> other t
  | `Kdyn t -> other t
  | `Kabs t -> kw G.Abstract t
  | `Kove_98086b9 t -> kw G.Override t
  | `Kinl t -> kw G.Inline t
  | `Choice_kmes_opt_kname_expr (_, e) ->
      G.OtherAttribute (("message", fk "message"), [ G.E (map_expr env e) ])
  | `Choice_kexp_expr (_, e) ->
      G.OtherAttribute (("export", fk "export"), [ G.E (map_expr env e) ])
  | `Kdis_expr (t, e) ->
      G.OtherAttribute (todo_kind env "dispid" t, [ G.E (map_expr env e) ])
  | `Kove_a43f97e t
  | `Krei t
  | `Kstd t
  | `Kcdecl t
  | `Kpas t
  | `Kreg t
  | `Ksaf t
  | `Kass t
  | `Knor t
  | `Klocal t
  | `Kfar t
  | `Knear t
  | `Kdef t
  | `Knod t
  | `Kdep t
  | `Kexp t
  | `Kpla t
  | `Kuni t
  | `Kcpp t
  | `Kcvar t
  | `Kmwp t
  | `Knos t
  | `Kint t
  | `Kioc t
  | `Khar t
  | `Ksof t
  | `Kms_abi_defa t
  | `Kms_abi_cdecl t
  | `Ksaves t
  | `Ksysv_abi_defa t
  | `Ksysv_abi_cdecl t
  | `Kvec t
  | `Kvaras t
  | `Kwin t
  | `Kpub t ->
      other t

and map_procattribute (env : env) (x : CST.procattribute) : G.attribute list =
  match x with
  | `Proc__SEMI (a, _) -> [ map_attributes_procattr_ env a ]
  | `LBRACK_opt_opt_rep1_choice_proc__COMMA_choice_proc__RBRACK_SEMI
      (_l, contents, _r, _sc) -> (
      match contents with
      | None -> []
      | Some (xs, last) ->
          delimited
            (fun (x : CST.anon_choice_proc__b0bc660) ->
              match x with
              | `Proc_ a -> Some (map_attributes_procattr_ env a)
              | `Proc _ -> None)
            (xs, last)
          |> deopt)

and map_procattributenoext (env : env) (x : CST.procattributenoext) :
    G.attribute list =
  match x with
  | `Choice_proc__SEMI (`Proc_ a, _) -> [ map_attributes_procattr_ env a ]
  | `Choice_proc__SEMI (`Ppif_proc__rep_ppelse_proc__ppen (_, a, xs, _), _) ->
      map_attributes_procattr_ env a
      :: List.map (fun (_, a) -> map_attributes_procattr_ env a) xs
  | `LBRACK_opt_opt_rep1_choice_proc__SEMI_choice_proc__RBRACK_SEMI
      (_l, contents, _r, _sc) -> (
      match contents with
      | None -> []
      | Some (xs, `Proc_ last) ->
          (match xs with
            | Some xs ->
                List.map
                  (fun (`Proc_ a, _) -> map_attributes_procattr_ env a)
                  xs
            | None -> [])
          @ [ map_attributes_procattr_ env last ])

and map_rttiattributes (env : env) (x : CST.rttiattributes option) :
    G.attribute list =
  match x with
  | None -> []
  | Some xs ->
      xs
      |> List.concat_map (fun (l, _lbl, contents, _r) ->
          match contents with
          | None -> []
          | Some (xs, last) ->
              delimited
                (fun r ->
                  let e = map_ref env r in
                  match e.e with
                  | G.N n -> G.NamedAttr (token env l, n, fb [])
                  | G.Call ({ e = G.N n; _ }, args) ->
                      G.NamedAttr (token env l, n, args)
                  | _ -> G.OtherAttribute (("Attribute", token env l), [ G.E e ]))
                (xs, last))

(* procedure/function/constructor/destructor header *)
and map_declproc_ (env : env) ?(extra_attrs = []) (x : CST.declproc_) :
    G.entity * G.function_definition =
  let _generic, tclass, kind, name, args, ret, _cc, _assign, _sc, attrs = x in
  let kind_attrs, tkind =
    match kind with
    | `Kpro t -> ([], token env t)
    | `Kfun t -> ([], token env t)
    | `Kcon t -> ([ G.KeywordAttr (G.Ctor, token env t) ], token env t)
    | `Kdes t -> ([ G.KeywordAttr (G.Dtor, token env t) ], token env t)
  in
  let class_attrs =
    match tclass with
    | Some t -> [ G.KeywordAttr (G.Static, token env t) ]
    | None -> []
  in
  let attrs = List.concat_map (map_procattributenoext env) attrs in
  let ent =
    {
      G.name = G.EN (name_of_genericname env name);
      attrs = extra_attrs @ class_attrs @ kind_attrs @ attrs;
      tparams = tparams_of_genericname env name;
    }
  in
  let fdef =
    {
      G.fkind = (G.Function, tkind);
      fparams = map_declargs_opt env args;
      frettype = Option.map (fun (_, t) -> map_typeref env t) ret;
      fbody = G.FBDecl G.sc;
    }
  in
  (ent, fdef)

and map_decloperator (env : env) (x : CST.decloperator) :
    G.entity * G.function_definition =
  let _class, top, opname, args, _result, ret, _assign, _sc, attrs = x in
  let name =
    match opname with
    | `Gene n -> name_of_genericname env n
    | `Oper_ _
    | `Oper _ ->
        name_of_id ("operator", token env top)
  in
  let ent =
    {
      G.name = G.EN name;
      attrs = List.concat_map (map_procattributenoext env) attrs;
      tparams = None;
    }
  in
  ( ent,
    {
      G.fkind = (G.Function, token env top);
      fparams = map_declargs_opt env args;
      frettype = Option.map (fun (_, t) -> map_type env t) ret;
      fbody = G.FBDecl G.sc;
    } )

and map_declproc_header (env : env) ((rtti, x) : CST.declproc) :
    G.entity * G.function_definition =
  let rtti = map_rttiattributes env rtti in
  match x with
  | `Decl_ d -> map_declproc_ env ~extra_attrs:rtti d
  | `Decl d ->
      let ent, fdef = map_decloperator env d in
      ({ ent with attrs = rtti @ ent.attrs }, fdef)

and map_declproc (env : env) (x : CST.declproc) : G.stmt =
  let ent, fdef = map_declproc_header env x in
  G.DefStmt (ent, G.FuncDef fdef) |> G.s

and map_declprocfwd (env : env) ((d, _fwd, attrs) : CST.declprocfwd) : G.stmt =
  let ent, fdef = map_declproc_ env d in
  let attrs = List.concat_map (map_procattribute env) attrs in
  G.DefStmt ({ ent with attrs = ent.attrs @ attrs }, G.FuncDef fdef) |> G.s

(* local declarations + begin ... end *)
and map_body (env : env) (locals : CST.definitions option)
    (body : CST.anon_choice_bloc_1cb9769) : G.stmt =
  let locals =
    match locals with
    | Some defs -> map_definitions env defs
    | None -> []
  in
  let body =
    match body with
    | `Bloc (tbegin, stmts, tend) -> map_block env tbegin stmts tend
    | `Asmtr (tasm, _, tend) -> map_asm env tasm tend
  in
  match (locals, body.s) with
  | [], _ -> body
  | _, G.Block (l, stmts, r) -> G.Block (l, locals @ stmts, r) |> G.s
  | _ -> block_of_stmts (locals @ [ body ])

and map_defproc (env : env) ((header, rest) : CST.defproc) : G.stmt =
  let ent, fdef = map_declproc_header env header in
  let body =
    match rest with
    | `Opt_defins_choice_bloc_SEMI (locals, body, _sc) ->
        map_body env locals body
    | `Tok_prec_p5_pat_6f93d17_opt_defins_choice_bloc_SEMI_rep_tok_prec_p5_pat_b66c674_opt_defins_choice_bloc_SEMI_tok_prec_p5_pat_9f5699f
        (_, locals, body, _, _, _) ->
        map_body env locals body
  in
  let fdef = { fdef with G.fbody = G.FBStmt body } in
  G.DefStmt (ent, G.FuncDef fdef) |> G.s

and ids_of_list (env : env) (more : CST.anon_opt_rep1_decl_COMMA_64c033f) id =
  (match more with
    | Some xs -> List.map (fun (i, _) -> map_identifier env i) xs
    | None -> [])
  @ [ map_identifier env id ]

and map_declvar (env : env) ~is_field (x : CST.declvar) : G.stmt list =
  let rtti, more, id, _colon, t, init, _sc, _attrs = x in
  let attrs = map_rttiattributes env rtti in
  let vtype = Some (map_type env t) in
  let vinit =
    match init with
    | Some (`Defa d) -> Some (map_defaultvalue env d)
    | Some (`Kabs_ref (_, r)) -> Some (map_ref env r)
    | None -> None
  in
  ids_of_list env more id
  |> List.map (fun id ->
      let ent = entity_of_ident ~attrs id in
      let vd = { G.vinit; vtype; vtok = G.no_sc } in
      G.DefStmt (ent, if is_field then G.FieldDefColon vd else G.VarDef vd)
      |> G.s)

and map_declfield (env : env) (x : CST.declfield) : G.stmt list =
  let rtti, more, id, _colon, t, init, _sc = x in
  let attrs = map_rttiattributes env rtti in
  let vtype = Some (map_type env t) in
  let vinit = Option.map (map_defaultvalue env) init in
  ids_of_list env more id
  |> List.map (fun id ->
      G.DefStmt
        ( entity_of_ident ~attrs id,
          G.FieldDefColon { G.vinit; vtype; vtok = G.no_sc } )
      |> G.s)

and map_declconst (env : env) (x : CST.declconst) : G.stmt list =
  let rtti, id, t, value, _hint, _sc, _attrs = x in
  let attrs = map_rttiattributes env rtti in
  let id = map_identifier env id in
  let ent =
    entity_of_ident ~attrs:(G.KeywordAttr (G.Const, snd id) :: attrs) id
  in
  [
    G.DefStmt
      ( ent,
        G.VarDef
          {
            G.vinit = Some (map_defaultvalue env value);
            vtype = Option.map (fun (_, t) -> map_type env t) t;
            vtok = G.no_sc;
          } )
    |> G.s;
  ]

and map_declvars (env : env) ((_class, _kvar, xs) : CST.declvars) : G.stmt list
    =
  xs
  |> List.concat_map (fun x ->
      match x with
      | `Decl d -> map_declvar env ~is_field:false d
      | `Ppbl b -> [ map_ppblock env b ]
      | `Semg_ellips t -> [ G.exprstmt (G.Ellipsis (token env t) |> G.e) ])

and map_declconsts (env : env) ((_class, _kconst, xs) : CST.declconsts) :
    G.stmt list =
  xs
  |> List.concat_map (fun x ->
      match x with
      | `Decl d -> map_declconst env d
      | `Ppbl b -> [ map_ppblock env b ])

and map_declprop (env : env) (x : CST.declprop) : G.stmt =
  let rtti, _class, tprop, id, _args, typ, specs, _sc, _attrs = x in
  let attrs = map_rttiattributes env rtti in
  let id = map_identifier env id in
  let accessors =
    specs
    |> List.filter_map (fun spec ->
        match spec with
        | `Kread_prop (t, acc) ->
            Some (G.ArgKwd (("read", token env t), map_propaccessor env acc))
        | `Kwrite_prop (t, acc) ->
            Some (G.ArgKwd (("write", token env t), map_propaccessor env acc))
        | `Kdef_expr (t, e) ->
            Some (G.ArgKwd (("default", token env t), map_expr env e))
        | `Kindex_expr (t, e) ->
            Some (G.ArgKwd (("index", token env t), map_expr env e))
        | `Ksto_expr (t, e) ->
            Some (G.ArgKwd (("stored", token env t), map_expr env e))
        | _ -> None)
  in
  let ent =
    entity_of_ident
      ~attrs:
        (attrs
        @ [
            G.NamedAttr
              ( token env tprop,
                name_of_id ("property", token env tprop),
                fb accessors );
          ])
      id
  in
  G.DefStmt
    ( ent,
      G.FieldDefColon
        {
          G.vinit = None;
          vtype = Option.map (fun (_, t) -> map_type env t) typ;
          vtok = G.no_sc;
        } )
  |> G.s

and map_propaccessor (env : env) (x : CST.propaccessor) : G.expr =
  match x with
  | `Id tok -> expr_of_id (map_identifier env tok)
  | `Prop (a, dot, id) ->
      G.DotAccess
        ( map_propaccessor env a,
          token env dot,
          G.FN (name_of_id (map_identifier env id)) )
      |> G.e

and map_classdeclarations (env : env) (xs : CST.classdeclarations) : G.stmt list
    =
  xs
  |> List.concat_map (fun x ->
      match x with
      | `Declts d -> map_decltypes env d
      | `Declvs d -> map_declvars env d
      | `Declcs d -> map_declconsts env d
      | `Decl_6ec32a9 d -> [ map_declproc env d ]
      | `Decl_5f998b5 d -> [ map_declprop env d ]
      | `Ppbl b -> [ map_ppblock env b ]
      | `Semg_ellips t -> [ G.exprstmt (G.Ellipsis (token env t) |> G.e) ])

and map_declfields (env : env) (xs : CST.declfields) : G.stmt list =
  xs
  |> List.concat_map (fun x ->
      match x with
      | `Decl d -> map_declfield env d
      | `Ppbl b -> [ map_ppblock env b ])

and visibility_attr (env : env) (x : CST.anon_choice_visi_5a3c750) : G.attribute
    =
  match x with
  | `Visi (`Kpub_1e1f5a9 t) -> G.OtherAttribute (todo_kind env "published" t, [])
  | `Visi (`Kpub_659fa63 t) -> G.KeywordAttr (G.Public, token env t)
  | `Visi (`Kpro t) -> G.KeywordAttr (G.Protected, token env t)
  | `Visi (`Kpri t) -> G.KeywordAttr (G.Private, token env t)
  | `Kreq t
  | `Kopt t ->
      G.OtherAttribute (todo_kind env "objc" t, [])

and add_attr_to_def (attr : G.attribute) (s : G.stmt) : G.stmt =
  match s.s with
  | G.DefStmt (ent, def) ->
      G.DefStmt ({ ent with attrs = attr :: ent.attrs }, def) |> G.s
  | _ -> s

and map_declclass_ (env : env)
    ((fields, decls, sections, _variant, _tend) : CST.declclass_) :
    G.field list G.bracket =
  let items =
    (match fields with
      | Some f -> map_declfields env f
      | None -> [])
    @ (match decls with
      | Some d -> map_classdeclarations env d
      | None -> [])
    @ List.concat_map
        (fun x ->
          let strict, vis, f, d =
            match x with
            | `Decl (strict, vis, f, d) -> (strict, vis, f, d)
            | `Ppde (_, strict, vis, _, f, d) -> (strict, vis, f, d)
          in
          ignore strict;
          let attr = visibility_attr env vis in
          ((match f with
             | Some f -> map_declfields env f
             | None -> [])
          @
          match d with
          | Some d -> map_classdeclarations env d
          | None -> [])
          |> List.map (add_attr_to_def attr))
        sections
  in
  fb (List.map (fun s -> G.F s) items)

and map_parents (env : env)
    (x : CST.anon_LPAR_opt_opt_rep1_type_COMMA_type_RPAR_116e8a8 option) :
    G.type_ list =
  match x with
  | Some (_l, Some (xs, last), _r) -> delimited (map_typeref env) (xs, last)
  | _ -> []

and map_decltype (env : env) (x : CST.decltype) : G.stmt list =
  let rtti, _generic, name, _eq, def, _sc, _attrs = x in
  let attrs = map_rttiattributes env rtti in
  let ent =
    {
      G.name = G.EN (name_of_genericname env name);
      attrs;
      tparams = tparams_of_genericname env name;
    }
  in
  let def =
    match def with
    | `Opt_ktype_type (_, `Decl_b2059ac (_l, xs, last, _r))
    | `Choice_type (`Type (`Decl_b2059ac (_l, xs, last, _r))) ->
        let elts =
          delimited
            (fun ((id, v) : CST.declenumvalue) ->
              G.OrEnum
                (map_identifier env id, Option.map (map_defaultvalue env) v))
            (xs, last)
        in
        G.TypeDef { G.tbody = G.OrType elts }
    | `Opt_ktype_type (_, `Decl_dd9f703 (_packed, trecord, body))
    | `Choice_type (`Type (`Decl_dd9f703 (_packed, trecord, body))) ->
        G.ClassDef
          {
            G.ckind = (G.Class, token env trecord);
            cextends = [];
            cimplements = [];
            cmixins = [];
            cparams = fb [];
            cbody = map_declclass_ env body;
          }
    | `Opt_ktype_type (Some _ktype, t) ->
        G.TypeDef { G.tbody = G.NewType (map_type env t) }
    | `Opt_ktype_type (None, t)
    | `Choice_type (`Type t) ->
        G.TypeDef { G.tbody = G.AliasType (map_type env t) }
    | `Decl_7f52a4c ((_packed, kind, _mod, parents, body) : CST.declclass) ->
        let tkind, ckind =
          match kind with
          | `Kclass t -> (token env t, G.Class)
          | `Krec t -> (token env t, G.Class)
          | `Kobj_46ccc5a t -> (token env t, G.Object)
          | `Kobj_c680b59 t
          | `Kobj_3b0f491 t ->
              (token env t, G.Class)
          | `Kobj_ef2d785 t -> (token env t, G.Interface)
        in
        let parents = map_parents env parents in
        let cextends, cimplements =
          match parents with
          | [] -> ([], [])
          | p :: rest -> ([ (p, None) ], rest)
        in
        G.ClassDef
          {
            G.ckind = (ckind, tkind);
            cextends;
            cimplements;
            cmixins = [];
            cparams = fb [];
            cbody =
              (match body with
              | Some b -> map_declclass_ env b
              | None -> fb []);
          }
    | `Decl_acc2c34 ((_packed, kind, parents, _guid, body) : CST.declintf) ->
        let tkind =
          match kind with
          | `Kint t
          | `Kdis t ->
              token env t
        in
        G.ClassDef
          {
            G.ckind = (G.Interface, tkind);
            cextends = List.map (fun t -> (t, None)) (map_parents env parents);
            cimplements = [];
            cmixins = [];
            cparams = fb [];
            cbody =
              (match body with
              | Some b -> map_declclass_ env b
              | None -> fb []);
          }
    | `Decl_11ac719 ((kind, _helper, parents, _for, t, body) : CST.declhelper)
      ->
        let tkind =
          match kind with
          | `Kclass t
          | `Krec t
          | `Ktype t ->
              token env t
        in
        G.ClassDef
          {
            G.ckind = (G.Trait, tkind);
            cextends =
              (map_typeref env t, None)
              :: List.map (fun t -> (t, None)) (map_parents env parents);
            cimplements = [];
            cmixins = [];
            cparams = fb [];
            cbody = map_declclass_ env body;
          }
  in
  [ G.DefStmt (ent, def) |> G.s ]

and map_decltypes (env : env) ((_ktype, xs) : CST.decltypes) : G.stmt list =
  xs
  |> List.concat_map (fun x ->
      match x with
      | `Decl d -> map_decltype env d
      | `Ppbl b -> [ map_ppblock env b ]
      | `Semg_ellips t -> [ G.exprstmt (G.Ellipsis (token env t) |> G.e) ])

and map_decluses (env : env) ((tuses, x) : CST.decluses) : G.stmt list =
  let tuses = token env tuses in
  (* One import per unit, located at the unit name so that each entry of a
   * multi-line uses clause is reported on its own line. *)
  let import (dotted : G.dotted_ident) =
    let tok =
      match dotted with
      | (_, t) :: _ -> t
      | [] -> tuses
    in
    G.DirectiveStmt
      { G.d = G.ImportAll (tok, G.DottedName dotted, fk "*"); d_attrs = [] }
    |> G.s
  in
  let rec entries (xs : CST.anon_choice_modu_eefd7e7 list) =
    List.concat_map
      (fun (x : CST.anon_choice_modu_eefd7e7) ->
        match x with
        | `Modu m -> [ import (map_modulename env m) ]
        | `Ppus b -> ppuses b
        | `COMMA _ -> [])
      xs
  and ppuses ((_, xs, elses, _) : CST.ppusesblock) =
    entries xs @ List.concat_map (fun (_, xs) -> entries xs) elses
  in
  match x with
  | `Rep1_uses_SEMI (xs, _sc) ->
      xs
      |> List.concat_map (fun (x : CST.usesclauseentry) ->
          match x with
          | `Modu_5b9c6b7 m -> [ import (map_modulename env m) ]
          | `Modu_fdf97ab (m, _in, _file) -> [ import (map_modulename env m) ]
          | `Ppus b -> ppuses b
          | `COMMA _ -> []
          (* `uses ..., Foo, ...;` : the ellipses are implicit in a
           * sequence of statements *)
          | `Semg_ellips _ -> [])
  | `Ppus (_, xs, _, elses, _) ->
      entries xs @ List.concat_map (fun (_, xs, _) -> entries xs) elses

and map_definition (env : env) (x : CST.definition) : G.stmt list =
  match x with
  | `Declts d -> map_decltypes env d
  | `Declvs d -> map_declvars env d
  | `Declcs d -> map_declconsts env d
  | `Defp d -> [ map_defproc env d ]
  | `Decl d -> [ map_declprocfwd env d ]
  | `Declls _ -> []
  | `Declus d -> map_decluses env d
  | `Decles _ -> []
  | `Ppbl b -> [ map_ppblock env b ]
  | `Bloc (tbegin, stmts, tend) -> [ map_block env tbegin stmts tend ]
  | `Semg_ellips t -> [ G.exprstmt (G.Ellipsis (token env t) |> G.e) ]

and map_definitions (env : env) (xs : CST.definitions) : G.stmt list =
  List.concat_map (map_definition env) xs

let map_declarations (env : env) (xs : CST.declarations) : G.stmt list =
  xs
  |> List.concat_map (fun x ->
      match x with
      | `Declts d -> map_decltypes env d
      | `Declvs d -> map_declvars env d
      | `Declcs d -> map_declconsts env d
      | `Decl_6ec32a9 d -> [ map_declproc env d ]
      | `Decl_5f998b5 d -> [ map_declprop env d ]
      | `Decl_8dd77dd d -> [ map_declprocfwd env d ]
      | `Declus d -> map_decluses env d
      | `Declls _
      | `Decles _ ->
          []
      | `Ppbl b -> [ map_ppblock env b ]
      | `Semg_ellips t -> [ G.exprstmt (G.Ellipsis (token env t) |> G.e) ])

(*****************************************************************************)
(* Toplevel *)
(*****************************************************************************)

let package (env : env) tok (name : CST.modulename) : G.stmt =
  G.DirectiveStmt
    { G.d = G.Package (token env tok, map_modulename env name); d_attrs = [] }
  |> G.s

let map_unit (env : env) ((tunit, name, _sc, sections, _end, _dot) : CST.unit_)
    : G.stmt list =
  let items =
    sections
    |> List.concat_map (fun x ->
        match x with
        | `Inte (_t, decls) -> (
            match decls with
            | Some d -> map_declarations env d
            | None -> [])
        | `Impl (_t, defs) -> (
            match defs with
            | Some d -> map_definitions env d
            | None -> [])
        | `Init (t, stmts)
        | `Fina (t, stmts) ->
            [
              (match stmts with
              | Some s ->
                  G.Block (token env t, map_statementstr_list env s, fk "end")
                  |> G.s
              | None -> block_of_stmts []);
            ])
  in
  package env tunit name :: items

let map_root (env : env) (x : CST.root) : G.any =
  match x with
  | `Opt_choice_prog None -> G.Pr []
  | `Opt_choice_prog (Some x) -> (
      match x with
      | `Prog (tprog, name, _sc, defs, (tbegin, stmts, tend), _dot) ->
          let defs =
            match defs with
            | Some d -> map_definitions env d
            | None -> []
          in
          G.Pr
            ((package env tprog name :: defs)
            @ [ map_block env tbegin stmts tend ])
      | `Libr (tlib, name, _sc, defs, body, _dot) ->
          let defs =
            match defs with
            | Some d -> map_definitions env d
            | None -> []
          in
          let body =
            match body with
            | `Bloc (tbegin, stmts, tend) -> [ map_block env tbegin stmts tend ]
            | `Kend _ -> []
          in
          G.Pr ((package env tlib name :: defs) @ body)
      | `Unit u -> G.Pr (map_unit env u)
      | `Defins defs -> (
          let xs = map_definitions env defs in
          match (env.extra, xs) with
          | Pattern, [ x ] -> G.S x
          | Pattern, xs -> G.Ss xs
          | Program, xs -> G.Pr xs))
  | `Pack (tpkg, name, _, _requires, _contains, _, _) ->
      G.Pr [ package env tpkg name ]
  | `Semg_exp (_, e) -> G.E (map_expr env e)
  | `Semg_stmts (_, stmts) -> (
      match map_statementstr_list env stmts with
      | [ s ] -> G.S s
      | xs -> G.Ss xs)
  | `Semg_declas (_, xs) -> (
      let stmts =
        xs
        |> List.concat_map (fun x ->
            match x with
            | `Decl_c64a659 d -> map_decltype env d
            | `Decl_a20e53a d -> map_declvar env ~is_field:false d
            | `Decl_d45e488 d -> map_declconst env d
            | `Decl_497d63e d -> map_declfield env d
            | `Decl_5f998b5 d -> [ map_declprop env d ]
            | `Decl_6ec32a9 d -> [ map_declproc env d ]
            | `Decl_8dd77dd d -> [ map_declprocfwd env d ]
            | `Declts d -> map_decltypes env d
            | `Declvs d -> map_declvars env d
            | `Declcs d -> map_declconsts env d
            | `Declus d -> map_decluses env d
            | `Semg_ellips t -> [ G.exprstmt (G.Ellipsis (token env t) |> G.e) ])
      in
      match stmts with
      | [ s ] -> G.S s
      | xs -> G.Ss xs)

(*****************************************************************************)
(* Entry points *)
(*****************************************************************************)

let parse (file : Fpath.t) =
  H.wrap_parser
    (fun () ->
      let src = Pascal_preprocessor.preprocess_file file in
      Tree_sitter_pascal.Parse.string ~src_file:!!file src)
    (fun cst _extras ->
      let env = { H.file; conv = H.line_col_to_pos file; extra = Program } in
      match map_root env cst with
      | G.Pr xs -> xs
      | G.S s -> [ s ]
      | G.Ss xs -> xs
      | G.E e -> [ G.exprstmt e ]
      | _ -> failwith "not a program")

(* `if C then A else B` is both a statement and (since Delphi 12) an
 * expression; in a pattern the statement is what people mean. *)
let starts_with_statement_keyword (str : string) : bool =
  let s = String.lowercase_ascii (String.trim str) in
  let word =
    let n = String.length s in
    let i = ref 0 in
    while
      !i < n
      &&
      match s.[!i] with
      | 'a' .. 'z' -> true
      | _ -> false
    do
      incr i
    done;
    String.sub s 0 !i
  in
  List.mem word
    [ "if"; "while"; "for"; "repeat"; "try"; "case"; "with"; "raise"; "begin" ]

let parse_pattern_cst (str : string) =
  (* Try the most specific interpretation first. *)
  let expr = "__SEMGREP_EXPRESSION " ^ str
  and stmts = "__SEMGREP_STATEMENTS " ^ str
  and decls = "__SEMGREP_DECLARATIONS " ^ str in
  let attempts =
    if starts_with_statement_keyword str then [ stmts; expr; str; decls ]
    else [ expr; stmts; str; decls ]
  in
  let rec try_ first_res = function
    | [] -> (
        match first_res with
        | Some res -> res
        | None -> Tree_sitter_pascal.Parse.string str)
    | s :: rest -> (
        let res = Tree_sitter_pascal.Parse.string s in
        match res.errors with
        | [] -> res
        | _ ->
            let first_res =
              match first_res with
              | None when s == str -> Some res
              | x -> x
            in
            try_ first_res rest)
  in
  try_ None attempts

let parse_pattern (str : string) =
  H.wrap_parser
    (fun () -> parse_pattern_cst str)
    (fun cst _extras ->
      let file = Fpath.v "<pattern>" in
      let env =
        { H.file; conv = H.line_col_to_pos_pattern str; extra = Pattern }
      in
      map_root env cst)
