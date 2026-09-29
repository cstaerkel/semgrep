(** Parser for Pascal (Delphi / Free Pascal) based on tree-sitter-pascal.

    Target files are preprocessed with {!Pascal_preprocessor} to resolve
    conditional compilation before parsing. *)

val parse :
  Fpath.t -> (AST_generic.program, unit) Tree_sitter_run.Parsing_result.t
(** Parse a Pascal source file (.pas, .dpr, .dpk, .lpr, .pp, .inc). *)

val parse_pattern :
  string -> (AST_generic.any, unit) Tree_sitter_run.Parsing_result.t
(** Parse a semgrep pattern: an expression, a sequence of statements, a
    definition (procedure, type, unit...) or a list of class member
    declarations. *)
