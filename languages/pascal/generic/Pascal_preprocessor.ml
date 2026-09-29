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

(*****************************************************************************)
(* Prelude *)
(*****************************************************************************)
(* Conditional-compilation resolver for Delphi / Free Pascal.
 *
 * Real-world Delphi code is full of {$IFDEF}/{$IF}/{$ELSE}/{$ENDIF}
 * blocks, often wrapping only half of a construct (a `uses` list ending in
 * two alternative lines, an `initialization` section, a method header...).
 * A context-free parser cannot make sense of both branches at once, and
 * measured on ~900k lines of open-source Delphi code, nearly half of all
 * lines ended up inside tree-sitter ERROR nodes without this step.
 *
 * We therefore resolve conditionals *before* parsing, against a set of
 * defines (by default: Delphi 12, Win32), and blank out (replace with
 * spaces, keeping newlines) every inactive region as well as every
 * conditional directive. The output has exactly the same length and the
 * same line/column layout as the input, so all locations reported by
 * semgrep still point into the original file.
 *
 * Supported: {$IFDEF X} {$IFNDEF X} {$IF expr} {$IFOPT X+} {$ELSEIF expr}
 * {$ELSE} {$ENDIF} {$IFEND} {$DEFINE X} {$UNDEF X} and {$I file} /
 * {$INCLUDE file} (only to collect DEFINE/UNDEF from include files),
 * in both the {$...} and (*$...*) forms.
 *
 * {$IF} expressions support Defined(X), Declared(X) (always true),
 * CompilerVersion, RTLVersion, numbers, comparisons, and/or/xor/not and
 * parentheses. When an expression cannot be evaluated, the first branch
 * is taken.
 *
 * Configuration (environment variables, read once):
 *  - SEMGREP_PASCAL_DEFINES: comma- or semicolon-separated list of symbols
 *    added to the default set; prefix with '-' to remove a default, e.g.
 *    "RELEASE;PFC_SERVER;-WIN32;WIN64;CPUX64"
 *  - SEMGREP_PASCAL_NO_DEFAULT_DEFINES=1: start from an empty set
 *  - SEMGREP_PASCAL_COMPILER_VERSION: value of CompilerVersion (default 36)
 *  - SEMGREP_PASCAL_NO_PREPROCESS=1: disable this preprocessing entirely
 *)

(*****************************************************************************)
(* Defines *)
(*****************************************************************************)

module SSet = Set.Make (String)

let default_defines =
  [
    "DCC";
    "MSWINDOWS";
    "WIN32";
    "CPUX86";
    "CPU386";
    "CPU32BITS";
    "UNICODE";
    "CONDITIONALEXPRESSIONS";
    "NATIVECODE";
    "ASSEMBLER";
    "VER360";
  ]

let split_defines (s : string) : string list =
  s
  |> String.map (function
    | ';'
    | ' ' ->
        ','
    | c -> c)
  |> String.split_on_char ',' |> List.map String.trim
  |> List.filter (fun s -> s <> "")

let getenv_opt name =
  match Sys.getenv_opt name with
  | Some "" -> None
  | x -> x

let initial_defines : SSet.t Lazy_safe.t =
  Lazy_safe.from_fun (fun () ->
      let base =
        match getenv_opt "SEMGREP_PASCAL_NO_DEFAULT_DEFINES" with
        | Some ("1" | "true" | "yes") -> SSet.empty
        | _ -> SSet.of_list default_defines
      in
      match getenv_opt "SEMGREP_PASCAL_DEFINES" with
      | None -> base
      | Some s ->
          split_defines s
          |> List.fold_left
               (fun acc d ->
                 let d = String.uppercase_ascii d in
                 if String.length d > 1 && d.[0] = '-' then
                   SSet.remove (String.sub d 1 (String.length d - 1)) acc
                 else if String.length d > 1 && d.[0] = '+' then
                   SSet.add (String.sub d 1 (String.length d - 1)) acc
                 else SSet.add d acc)
               base)

let compiler_version : float Lazy_safe.t =
  Lazy_safe.from_fun (fun () ->
      match getenv_opt "SEMGREP_PASCAL_COMPILER_VERSION" with
      | Some s -> (
          match float_of_string_opt (String.trim s) with
          | Some f -> f
          | None -> 36.0)
      | None -> 36.0)

let enabled : bool Lazy_safe.t =
  Lazy_safe.from_fun (fun () ->
      match getenv_opt "SEMGREP_PASCAL_NO_PREPROCESS" with
      | Some ("1" | "true" | "yes") -> false
      | _ -> true)

(*****************************************************************************)
(* {$IF} expression evaluation *)
(*****************************************************************************)

exception Cannot_eval

type value = B of bool | N of float

let to_bool = function
  | B b -> b
  | N f -> f <> 0.0

let to_num = function
  | N f -> f
  | B true -> 1.0
  | B false -> 0.0

let is_ident_start c =
  match c with
  | 'a' .. 'z'
  | 'A' .. 'Z'
  | '_' ->
      true
  | _ -> false

let is_ident_char c =
  is_ident_start c
  ||
  match c with
  | '0' .. '9'
  | '.' ->
      true
  | _ -> false

let is_digit c = c >= '0' && c <= '9'

let tokenize (s : string) : string list =
  let n = String.length s in
  let rec loop i acc =
    if i >= n then List.rev acc
    else
      let c = s.[i] in
      if is_ident_start c then (
        let j = ref i in
        while !j < n && is_ident_char s.[!j] do
          incr j
        done;
        loop !j (String.sub s i (!j - i) :: acc))
      else if is_digit c then (
        let j = ref i in
        while !j < n && (is_digit s.[!j] || s.[!j] = '.') do
          incr j
        done;
        loop !j (String.sub s i (!j - i) :: acc))
      else if i + 1 < n then
        match String.sub s i 2 with
        | ("<>" | "<=" | ">=") as op -> loop (i + 2) (op :: acc)
        | _ -> single i c acc
      else single i c acc
  and single i c acc =
    match c with
    | '('
    | ')'
    | '='
    | '<'
    | '>'
    | '+'
    | '-'
    | '*'
    | '/'
    | ',' ->
        loop (i + 1) (String.make 1 c :: acc)
    | _ -> loop (i + 1) acc
  in
  loop 0 []

let eval_if (defs : SSet.t) (expr : string) : bool option =
  let toks = ref (tokenize expr) in
  let peek () =
    match !toks with
    | [] -> None
    | x :: _ -> Some (String.uppercase_ascii x)
  in
  let next () =
    match !toks with
    | [] -> raise Cannot_eval
    | x :: xs ->
        toks := xs;
        x
  in
  let expect s = if next () <> s then raise Cannot_eval in
  let rec expr () =
    let v = ref (andx ()) in
    let continue = ref true in
    while !continue do
      match peek () with
      | Some "OR" ->
          ignore (next ());
          let r = andx () in
          v := B (to_bool !v || to_bool r)
      | Some "XOR" ->
          ignore (next ());
          let r = andx () in
          v := B (to_bool !v <> to_bool r)
      | _ -> continue := false
    done;
    !v
  and andx () =
    let v = ref (cmp ()) in
    while peek () = Some "AND" do
      ignore (next ());
      let r = cmp () in
      v := B (to_bool !v && to_bool r)
    done;
    !v
  and cmp () =
    let v = ref (add ()) in
    let continue = ref true in
    while !continue do
      match peek () with
      | Some (("=" | "<>" | "<" | ">" | "<=" | ">=") as op) ->
          ignore (next ());
          let r = add () in
          let a = to_num !v and b = to_num r in
          v :=
            B
              (match op with
              | "=" -> a = b
              | "<>" -> a <> b
              | "<" -> a < b
              | ">" -> a > b
              | "<=" -> a <= b
              | _ -> a >= b)
      | _ -> continue := false
    done;
    !v
  and add () =
    let v = ref (unary ()) in
    let continue = ref true in
    while !continue do
      match peek () with
      | Some "+" ->
          ignore (next ());
          v := N (to_num !v +. to_num (unary ()))
      | Some "-" ->
          ignore (next ());
          v := N (to_num !v -. to_num (unary ()))
      | _ -> continue := false
    done;
    !v
  and unary () =
    match peek () with
    | Some "NOT" ->
        ignore (next ());
        B (not (to_bool (unary ())))
    | Some "-" ->
        ignore (next ());
        N (-.to_num (unary ()))
    | _ -> atom ()
  and atom () =
    let x = next () in
    let u = String.uppercase_ascii x in
    if x = "(" then (
      let v = expr () in
      expect ")";
      v)
    else if is_digit x.[0] then
      match float_of_string_opt x with
      | Some f -> N f
      | None -> raise Cannot_eval
    else
      match u with
      | "DEFINED" ->
          expect "(";
          let name = String.uppercase_ascii (next ()) in
          expect ")";
          B (SSet.mem name defs)
      | "DECLARED" ->
          expect "(";
          ignore (next ());
          expect ")";
          B true
      | "COMPILERVERSION"
      | "RTLVERSION" ->
          N (Lazy_safe.force compiler_version)
      | "TRUE" -> B true
      | "FALSE" -> B false
      | _ -> raise Cannot_eval
  in
  try
    let v = expr () in
    Some (to_bool v)
  with
  | Cannot_eval
  | Failure _
  | Invalid_argument _ ->
      None

(*****************************************************************************)
(* Directive scanning *)
(*****************************************************************************)

type frame = {
  parent_active : bool;
  mutable branch_active : bool;
  mutable taken : bool;
}

let max_include_depth = 8

(* Parse the body of a directive (without the leading '$'), returning
 * the directive name in uppercase and its argument. *)
let split_directive (body : string) : string * string =
  let n = String.length body in
  let i = ref 0 in
  while !i < n && is_ident_start body.[!i] do
    incr i
  done;
  let name = String.uppercase_ascii (String.sub body 0 !i) in
  let arg = String.trim (String.sub body !i (n - !i)) in
  (name, arg)

let first_word (s : string) : string =
  match String.split_on_char ' ' (String.trim s) with
  | w :: _ -> String.uppercase_ascii (String.trim w)
  | [] -> ""

let read_file_opt (path : string) : string option =
  try Some (UFile.read_file (Fpath.v path)) with
  | Sys_error _
  | Invalid_argument _ ->
      None

(* [process ~defs ~basedir ~depth src] returns [src] with inactive regions
 * blanked. [defs] is updated with DEFINE/UNDEF seen in active regions. *)
let rec process ~(defs : SSet.t ref) ~(basedir : string) ~(depth : int)
    (src : string) : string =
  let n = String.length src in
  let out = Bytes.of_string src in
  let blank a b =
    for k = a to b - 1 do
      match Bytes.get out k with
      | '\n'
      | '\r' ->
          ()
      | _ -> Bytes.set out k ' '
    done
  in
  let stack : frame list ref = ref [] in
  let active = ref true in
  let region_start = ref None in
  let i = ref 0 in
  (* UTF-8 BOM *)
  if n >= 3 && String.sub src 0 3 = "\xef\xbb\xbf" then (
    blank 0 3;
    i := 3);
  let find_from pos (s : string) =
    let m = String.length s in
    let rec go k =
      if k + m > n then -1 else if String.sub src k m = s then k else go (k + 1)
    in
    go pos
  in
  let find_char pos c =
    match String.index_from_opt src pos c with
    | Some k -> k
    | None -> -1
  in
  while !i < n do
    let c = src.[!i] in
    let start = !i in
    if c = '\'' then
      if
        (* string literal; multi-line strings start with ''' + newline *)
        !i + 2 < n
        && String.sub src !i 3 = "'''"
        &&
        let k = ref (!i + 3) in
        while !k < n && (src.[!k] = ' ' || src.[!k] = '\t') do
          incr k
        done;
        !k < n && (src.[!k] = '\n' || src.[!k] = '\r')
      then
        let j = find_from (!i + 3) "'''" in
        i := if j < 0 then n else j + 3
      else
        let rec close k =
          if k >= n then n
          else
            match src.[k] with
            | '\'' ->
                if k + 1 < n && src.[k + 1] = '\'' then close (k + 2) else k + 1
            | '\n' -> k (* unterminated: stop at end of line *)
            | _ -> close (k + 1)
        in
        i := close (!i + 1)
    else if c = '/' && !i + 1 < n && src.[!i + 1] = '/' then
      i :=
        match find_char !i '\n' with
        | -1 -> n
        | k -> k
    else
      let body =
        if c = '{' then (
          let j = find_char (!i + 1) '}' in
          let j = if j < 0 then n - 1 else j in
          let b = String.sub src (!i + 1) (max 0 (j - !i - 1)) in
          i := j + 1;
          Some b)
        else if c = '(' && !i + 1 < n && src.[!i + 1] = '*' then (
          let j = find_from (!i + 2) "*)" in
          let j = if j < 0 then n - 2 else j in
          let b = String.sub src (!i + 2) (max 0 (j - !i - 2)) in
          i := j + 2;
          Some b)
        else (
          incr i;
          None)
      in
      match body with
      | Some b when String.length b > 0 && b.[0] = '$' ->
          let name, arg =
            split_directive (String.sub b 1 (String.length b - 1))
          in
          let word = first_word arg in
          let cond_value v =
            match v with
            | Some b -> b
            | None -> true
          in
          let is_cond =
            match name with
            | "IFDEF"
            | "IFNDEF"
            | "IF"
            | "IFOPT"
            | "ELSEIF"
            | "ELSE"
            | "ENDIF"
            | "IFEND" ->
                true
            | _ -> false
          in
          (match name with
          | "IFDEF"
          | "IFNDEF"
          | "IF"
          | "IFOPT" ->
              let v =
                match name with
                | "IFDEF" -> SSet.mem word !defs
                | "IFNDEF" -> not (SSet.mem word !defs)
                | "IFOPT" -> true
                | _ -> cond_value (eval_if !defs arg)
              in
              let b = !active && v in
              stack :=
                { parent_active = !active; branch_active = b; taken = b }
                :: !stack;
              active := b
          | "ELSEIF" -> (
              match !stack with
              | f :: _ ->
                  let v =
                    if f.taken then false else cond_value (eval_if !defs arg)
                  in
                  f.branch_active <- f.parent_active && v;
                  f.taken <- f.taken || f.branch_active;
                  active := f.branch_active
              | [] -> ())
          | "ELSE" -> (
              match !stack with
              | f :: _ ->
                  f.branch_active <- f.parent_active && not f.taken;
                  f.taken <- true;
                  active := f.branch_active
              | [] -> ())
          | "ENDIF"
          | "IFEND" -> (
              match !stack with
              | f :: rest ->
                  stack := rest;
                  active := f.parent_active
              | [] -> ())
          | "DEFINE" when !active && word <> "" -> defs := SSet.add word !defs
          | "UNDEF" when !active && word <> "" -> defs := SSet.remove word !defs
          | "I"
          | "INCLUDE"
            when !active && depth < max_include_depth && word <> ""
                 && word.[0] <> '+'
                 && word.[0] <> '-' ->
              let fname =
                let a = String.trim arg in
                let a =
                  if String.length a >= 2 && a.[0] = '\'' then
                    String.sub a 1 (String.length a - 2)
                  else a
                in
                String.map
                  (function
                    | '\\' -> '/'
                    | c -> c)
                  a
              in
              let candidates =
                [ fname; fname ^ ".inc" ]
                |> List.map (fun f ->
                    if Filename.is_relative f then Filename.concat basedir f
                    else f)
              in
              let rec try_ = function
                | [] -> ()
                | p :: ps -> (
                    match read_file_opt p with
                    | Some contents ->
                        ignore
                          (process ~defs ~basedir:(Filename.dirname p)
                             ~depth:(depth + 1) contents)
                    | None -> try_ ps)
              in
              try_ candidates
          | _ -> ());
          if is_cond then (
            blank start !i;
            match !region_start with
            | Some rs when !active ->
                blank rs start;
                region_start := None
            | None when not !active -> region_start := Some !i
            | _ -> ())
      | _ -> ()
  done;
  (match !region_start with
  | Some rs -> blank rs n
  | None -> ());
  Bytes.to_string out

(*****************************************************************************)
(* Entry points *)
(*****************************************************************************)

let preprocess_string ?(basedir = ".") (src : string) : string =
  if not (Lazy_safe.force enabled) then src
  else
    let defs = ref (Lazy_safe.force initial_defines) in
    process ~defs ~basedir ~depth:0 src

let preprocess_file (file : Fpath.t) : string =
  let path = Fpath.to_string file in
  let src =
    match read_file_opt path with
    | Some s -> s
    | None -> failwith ("cannot read " ^ path)
  in
  preprocess_string ~basedir:(Filename.dirname path) src
