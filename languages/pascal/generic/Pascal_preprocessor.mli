(** Resolution of Delphi / Free Pascal conditional compilation.

    Inactive {$IFDEF}/{$IF}/{$ELSE} regions and all conditional directives
    are replaced by spaces (newlines are kept), so that the result has the
    same length and line/column layout as the input. See the .ml for the
    supported directives and the SEMGREP_PASCAL_* environment variables. *)

val default_defines : string list
(** Symbols defined when nothing else is configured (Delphi 12, Win32). *)

val eval_if : Set.Make(String).t -> string -> bool option
(** [eval_if defines expr] evaluates the argument of a {$IF} directive.
    Returns [None] when the expression cannot be evaluated. *)

val preprocess_string : ?basedir:string -> string -> string
(** [preprocess_string ~basedir src] resolves conditionals in [src].
    [basedir] is used to find files referenced by {$I file} / {$INCLUDE}. *)

val preprocess_file : Fpath.t -> string
(** Read and preprocess a file. *)
