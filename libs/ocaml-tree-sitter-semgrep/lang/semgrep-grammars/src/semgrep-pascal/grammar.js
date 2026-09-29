/*
 * semgrep-pascal
 *
 * Extend the tree-sitter Pascal (Delphi / Free Pascal) grammar with
 * semgrep-specific constructs used to represent semgrep patterns:
 *
 *  - metavariables:          $X, $OBJ, $...ARGS
 *  - ellipsis:               ...
 *  - deep expression:        <... $X ...>
 *  - pattern entry points:   __SEMGREP_EXPRESSION, __SEMGREP_STATEMENTS,
 *                            __SEMGREP_DECLARATIONS (prepended by semgrep-core
 *                            when parsing a pattern, never seen in targets)
 *
 * Note on metavariables vs. hex literals: Pascal writes hex numbers as $FF.
 * A metavariable whose name only contains hex digits ($A, $FF, $DEADBEEF)
 * is therefore lexed as a number. Use names with at least one non-hex
 * letter ($X, $OBJ, $VAL).
 */

const base = require('tree-sitter-pascal/grammar');

function delimited1(rule, delimiter = ',') {
  return seq(repeat(seq(rule, delimiter)), rule);
}

module.exports = grammar(base, {
  name: 'pascal',

  conflicts: ($, previous) => previous.concat([
    // needed once ocaml-tree-sitter un-hides these rules
    [$._classDeclarations, $._declFields],
  ]),

  rules: {
    semgrep_expression: $ => seq('__SEMGREP_EXPRESSION', $._expr),

    semgrep_statements: $ => seq('__SEMGREP_STATEMENTS', $._statementsTr),

    semgrep_declarations: $ => seq('__SEMGREP_DECLARATIONS',
      repeat1(choice(
        $.declType, $.declVar, $.declConst, $.declField, $.declProp,
        $.declProc, alias($.declProcFwd, $.declProc),
        $.declTypes, $.declVars, $.declConsts, $.declUses,
        $.semgrep_ellipsis,
      ))
    ),

    // Metavariables ($X) and ellipsis metavariables ($...X) are identifiers.
    // `identifier` is the `word` token, so it must stay a single regexp.
    identifier: $ => /[&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]*/,

    semgrep_ellipsis: $ => '...',

    deep_ellipsis: $ => seq('<...', $._expr, '...>'),

    _ref: ($, previous) => choice(
      ...previous.members,
      $.semgrep_ellipsis,
      $.deep_ellipsis,
    ),

    // procedure Foo(...);  procedure Foo(A: Integer; ...);
    declArg: ($, previous) => choice(previous, $.semgrep_ellipsis),

    // ... between declarations: var/type/const sections, units, classes
    _definition: ($, previous) => choice(...previous.members, $.semgrep_ellipsis),
    _declarations: $ => repeat1(choice(
      $.declTypes, $.declVars, $.declConsts, $.declProc, $.declProp,
      alias($.declProcFwd, $.declProc),
      $.declUses, $.declLabels, $.declExports,
      $.ppBlock,
      $.semgrep_ellipsis,
    )),
    _classDeclarations: $ => repeat1(choice(
      $.declTypes, $.declVars, $.declConsts, $.declProc, $.declProp,
      $.ppBlock,
      $.semgrep_ellipsis,
    )),
    declVars: $ => seq(
      optional($.kClass),
      choice($.kVar, $.kThreadvar),
      repeat(choice($.declVar, $.ppBlock, $.semgrep_ellipsis))
    ),
    declTypes: $ => seq(
      $.kType,
      repeat(choice($.declType, $.ppBlock, $.semgrep_ellipsis))
    ),
    // A statement-level `...` does not need a trailing semicolon:
    //   $X := TFoo.Create; ... $X.Free;
    _statement: ($, previous) => choice(...previous.members, prec(-1, $.semgrep_ellipsis)),

    _usesClauseEntry: ($, previous) => choice(...previous.members, $.moduleInFile, $.semgrep_ellipsis),

    // -----------------------------------------------------------------
    // Robustness fixes for real-world Delphi code (not semgrep-specific).
    // Candidates for upstreaming to tree-sitter-pascal.
    // -----------------------------------------------------------------

    root: ($, previous) => choice(
      previous,
      $.package,
      $.semgrep_expression,
      $.semgrep_statements,
      $.semgrep_declarations,
    ),

    // UTF-8 byte order mark at the start of many Delphi files.
    _space: $ => /[\s\r\n\t﻿]+/,

    // Old-style unit initialization: `begin ... end.` instead of
    // `initialization ... end.`
    unit: $ => seq(
      $.kUnit, $.moduleName, ';',
      repeat(choice(
        $.interface,
        $.implementation,
        $.initialization,
        $.finalization,
      )),
      // `begin ... end.` is absorbed as a trailing block definition
      optional($.kEnd),
      $.kEndDot
    ),

    // Delphi package (.dpk)
    package: $ => seq(
      $.kPackage, $.moduleName, ';',
      optional(seq($.kRequires, delimited1($.moduleName), ';')),
      optional(seq($.kContains, delimited1(choice($.moduleName, $.moduleInFile)), ';')),
      $.kEnd, $.kEndDot
    ),
    kPackage: $ => /package/i,
    kRequires: $ => /requires/i,
    kContains: $ => /contains/i,

    // .dpr: uses Main in 'Main.pas' {MainForm};
    moduleInFile: $ => seq(
      field('name', $.moduleName), $.kIn, field('file', $.literalString)
    ),

    // 1E-5, 2.5e+10
    _literalFloat: $ => prec(10, /[-+]?[0-9]*\.?[0-9]+([eE][+-]?[0-9]+)?/),

    // property X: T read FPoint.X write SetX;
    // property Y: T readonly dispid 1;      (type library interfaces)
    declProp: $ => seq(
      optional($.rttiAttributes),
      optional($.kClass),
      $.kProperty,
      field('name', $.identifier),
      field('args', optional($.declPropArgs)),
      optional(seq(':', field('type', $.type))),
      repeat(choice(
        seq($.kIndex, field('index', $._expr)),
        seq($.kDispId, field('dispid', $._expr)),
        seq($.kRead, field('getter', $._propAccessor)),
        seq($.kWrite, field('setter', $._propAccessor)),
        seq($.kImplements, field('implements', delimited1($._expr))),
        seq($.kDefault, field('defaultValue', $._expr)),
        seq($.kStored, field('stored', $._expr)),
        $.kNodefault,
        $.kReadonly,
        $.kWriteonly,
      )),
      ';',
      repeat($._procAttribute)
    ),
    _propAccessor: $ => choice($.identifier, alias($.propAccessorDot, $.exprDot)),
    propAccessorDot: $ => prec.left(seq(
      field('lhs', choice($.identifier, alias($.propAccessorDot, $.exprDot))),
      field('operator', $.kDot),
      field('rhs', $.identifier)
    )),
    kReadonly: $ => /readonly/i,
    kWriteonly: $ => /writeonly/i,

    // Inline record types in var / field declarations:
    //   var Msg: packed record ... end;
    type: $ => choice(
      $.typeref,
      $.declMetaClass,
      $.declEnum,
      $.declSet,
      $.declArray,
      $.declFile,
      $.declString,
      $.declProcRef,
      $.declSubRange,
      alias($.declRecordInline, $.declClass),
    ),
    declRecordInline: $ => prec(-1, seq(
      optional($.kPacked),
      $.kRecord,
      $._declClass
    )),

    // TProc = function(A: Integer): Boolean stdcall;
    declProcRef: $ => prec.right(1, seq(
      optional(seq($.kReference, $.kTo)),
      choice($.kProcedure, $.kFunction),
      field('args', optional($.declArgs)),
      optional(seq(':', field('type', $.typeref))),
      optional(seq($.kOf, $.kObject)),
      optional(field('callconv', choice(
        $.kStdcall, $.kCdecl, $.kSafecall, $.kRegister, $.kPascal, $.kWinapi
      ))),
    )),

    // asm labels: @@Loop:
    asmBody: $ => repeat1(choice(
      $.identifier,
      /[0-9a-fA-F]/,
      /[.,:;+\-*\[\]<>&%$@]/,
      /\([^*]|\)/
    )),

    // raise E at ReturnAddress;
    raise: $ => seq(
      $.kRaise,
      field('exception', optional($._expr)),
      optional(seq($.kRaiseAt, field('address', $._expr))),
      ';'
    ),
    raiseTr: $ => seq(
      $.kRaise,
      field('exception', optional($._expr)),
      optional(seq($.kRaiseAt, field('address', $._expr))),
    ),
    kRaiseAt: $ => token(prec(1, /at/i)),

    // function Foo(...): Boolean stdcall;   (calling convention before `;`)
    _declProc: $ => seq(
      optional($.kGeneric),
      optional($.kClass),
      choice($.kProcedure, $.kFunction, $.kConstructor, $.kDestructor),
      field('name', $._genericName),
      field('args', optional($.declArgs)),
      optional(seq(':', field('type', $.typeref))),
      optional(field('callconv', choice(
        $.kStdcall, $.kCdecl, $.kSafecall, $.kRegister, $.kPascal, $.kWinapi
      ))),
      field('assign', optional($.defaultValue)),
      ';',
      repeat($._procAttributeNoExt)
    ),

    // crHeaderSplit = crHSplit deprecated 'Use vrHSplit instead';
    declConst: $ => seq(
      optional($.rttiAttributes),
      field('name', $.identifier),
      optional(seq(':', field('type', $.type))),
      field('defaultValue', $.defaultValue),
      optional($._hintDirective),
      ';',
      repeat($._procAttribute)
    ),
    _hintDirective: $ => prec.right(choice(
      seq($.kDeprecated, optional($.literalString)),
      $.kPlatform,
      $.kExperimental,
    )),

    // record initializer with trailing `;` before `)`
    recInitializer: $ => seq(
      '(',
      delimited1($.recInitializerField, ';'),
      optional(';'),
      ')'
    ),

    // TFoo = 0..Count - 1;   TBar = 2..Succ(High(TDigit));
    _subRangeBound: $ => choice(
      $.literalNumber,
      seq(choice('-', '+'), $.literalNumber),
      $.literalString,
      $._typeref,
    ),

    // Delphi 12 multi-line strings: '''<newline> ... '''
    _literalString: $ => choice(
      /'''[ \t]*\r?\n([^']|'[^']|''[^'])*'''/,
      /'[^']*'/,
      $.literalChar
    ),
  },
});
