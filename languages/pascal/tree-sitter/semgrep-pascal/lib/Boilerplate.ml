(**
   Boilerplate to be used as a template when mapping the pascal CST
   to another type of tree.
*)

module R = Tree_sitter_run.Raw_tree

(* Disable warnings against unused variables *)
[@@@warning "-26-27"]

(* Disable warning against unused 'rec' *)
[@@@warning "-39"]

type env = unit

let token (env : env) (tok : Tree_sitter_run.Token.t) =
  R.Token tok

let blank (env : env) () =
  R.Tuple []

let map_tok_prec_p5_pat_9f5699f (env : env) (tok : CST.tok_prec_p5_pat_9f5699f) =
  (* tok_prec_p5_pat_9f5699f *) token env tok

let map_ktrue (env : env) (tok : CST.ktrue) =
  (* pattern true *) token env tok

let map_kobjcprotocol (env : env) (tok : CST.kobjcprotocol) =
  (* pattern objcprotocol *) token env tok

let map_kbegin (env : env) (tok : CST.kbegin) =
  (* pattern begin *) token env tok

let map_kfalse (env : env) (tok : CST.kfalse) =
  (* pattern false *) token env tok

let map_klabel (env : env) (tok : CST.klabel) =
  (* pattern label *) token env tok

let map_kset (env : env) (tok : CST.kset) =
  (* pattern set *) token env tok

let map_kinterface (env : env) (tok : CST.kinterface) =
  (* pattern interface *) token env tok

let map_kobject (env : env) (tok : CST.kobject) =
  (* pattern object *) token env tok

let map_kcdecl (env : env) (tok : CST.kcdecl) =
  (* pattern cdecl *) token env tok

let map_kuses (env : env) (tok : CST.kuses) =
  (* pattern uses *) token env tok

let map_imm_tok_pat_f57674d (env : env) (tok : CST.imm_tok_pat_f57674d) =
  (* pattern %[01]+ *) token env tok

let map_kdeprecated (env : env) (tok : CST.kdeprecated) =
  (* pattern deprecated *) token env tok

let map_kinline (env : env) (tok : CST.kinline) =
  (* pattern inline *) token env tok

let map_kunimplemented (env : env) (tok : CST.kunimplemented) =
  (* pattern unimplemented *) token env tok

let map_kvar (env : env) (tok : CST.kvar) =
  (* pattern var *) token env tok

let map_kinitialization (env : env) (tok : CST.kinitialization) =
  (* pattern initialization *) token env tok

let map_kiocheck (env : env) (tok : CST.kiocheck) =
  (* pattern iocheck *) token env tok

let map_kprocedure (env : env) (tok : CST.kprocedure) =
  (* pattern procedure *) token env tok

let map_koperator (env : env) (tok : CST.koperator) =
  (* pattern operator *) token env tok

let map_kgeneric (env : env) (tok : CST.kgeneric) =
  (* pattern generic *) token env tok

let map_ppendif (env : env) (tok : CST.ppendif) =
  (* ppendif *) token env tok

let map_kthreadvar (env : env) (tok : CST.kthreadvar) =
  (* pattern threadvar *) token env tok

let map_kconstructor (env : env) (tok : CST.kconstructor) =
  (* pattern constructor *) token env tok

let map_kexternal (env : env) (tok : CST.kexternal) =
  (* pattern external *) token env tok

let map_pat_cdd9bad (env : env) (tok : CST.pat_cdd9bad) =
  (* pattern "'[^']*'" *) token env tok

let map_ksaveregisters (env : env) (tok : CST.ksaveregisters) =
  (* pattern saveregisters *) token env tok

let map_kpacked (env : env) (tok : CST.kpacked) =
  (* pattern packed *) token env tok

let map_pat_cafba40 (env : env) (tok : CST.pat_cafba40) =
  (* pattern [0-9a-fA-F] *) token env tok

let map_kinherited (env : env) (tok : CST.kinherited) =
  (* pattern inherited *) token env tok

let map_kshr (env : env) (tok : CST.kshr) =
  (* pattern shr *) token env tok

let map_kdownto (env : env) (tok : CST.kdownto) =
  (* pattern downto *) token env tok

let map_kraiseat (env : env) (tok : CST.kraiseat) =
  (* kraiseat *) token env tok

let map_krequired (env : env) (tok : CST.krequired) =
  (* pattern required *) token env tok

let map_kif (env : env) (tok : CST.kif) =
  (* pattern if *) token env tok

let map_kwith (env : env) (tok : CST.kwith) =
  (* pattern with *) token env tok

let map_kconst (env : env) (tok : CST.kconst) =
  (* pattern const *) token env tok

let map_kexports (env : env) (tok : CST.kexports) =
  (* pattern exports *) token env tok

let map_knoreturn (env : env) (tok : CST.knoreturn) =
  (* pattern noreturn *) token env tok

let map_kmwpascal (env : env) (tok : CST.kmwpascal) =
  (* pattern mwpascal *) token env tok

let map_kpackage (env : env) (tok : CST.kpackage) =
  (* pattern package *) token env tok

let map_kfar (env : env) (tok : CST.kfar) =
  (* pattern far *) token env tok

let map_kobjcclass (env : env) (tok : CST.kobjcclass) =
  (* pattern objcclass *) token env tok

let map_kexport (env : env) (tok : CST.kexport) =
  (* pattern export *) token env tok

let map_tok_prec_p5_pat_ef0cc7f (env : env) (tok : CST.tok_prec_p5_pat_ef0cc7f) =
  (* tok_prec_p5_pat_ef0cc7f *) token env tok

let map_kdynamic (env : env) (tok : CST.kdynamic) =
  (* pattern dynamic *) token env tok

let map_krepeat (env : env) (tok : CST.krepeat) =
  (* pattern repeat *) token env tok

let map_koptional (env : env) (tok : CST.koptional) =
  (* pattern optional *) token env tok

let map_klibrary (env : env) (tok : CST.klibrary) =
  (* pattern library *) token env tok

let map_kvarargs (env : env) (tok : CST.kvarargs) =
  (* pattern varargs *) token env tok

let map_kshl (env : env) (tok : CST.kshl) =
  (* pattern shl *) token env tok

let map_kabstract (env : env) (tok : CST.kabstract) =
  (* pattern abstract *) token env tok

let map_kexperimental (env : env) (tok : CST.kexperimental) =
  (* pattern experimental *) token env tok

let map_kof (env : env) (tok : CST.kof) =
  (* pattern of *) token env tok

let map_kwriteonly (env : env) (tok : CST.kwriteonly) =
  (* pattern writeonly *) token env tok

let map_kcontains (env : env) (tok : CST.kcontains) =
  (* pattern contains *) token env tok

let map_kreference (env : env) (tok : CST.kreference) =
  (* pattern reference *) token env tok

let map_pat_3ea53fb (env : env) (tok : CST.pat_3ea53fb) =
  (* pattern [.,:;+\-*\[\]<>&%$@] *) token env tok

let map_knil (env : env) (tok : CST.knil) =
  (* pattern nil *) token env tok

let map_kto (env : env) (tok : CST.kto) =
  (* pattern to *) token env tok

let map_tok_prec_p5_pat_0a9b8cd (env : env) (tok : CST.tok_prec_p5_pat_0a9b8cd) =
  (* tok_prec_p5_pat_0a9b8cd *) token env tok

let map_kfinally (env : env) (tok : CST.kfinally) =
  (* pattern finally *) token env tok

let map_kindex (env : env) (tok : CST.kindex) =
  (* pattern index *) token env tok

let map_kimplements (env : env) (tok : CST.kimplements) =
  (* pattern implements *) token env tok

let map_kinterrupt (env : env) (tok : CST.kinterrupt) =
  (* pattern interrupt *) token env tok

let map_pat_588cb21 (env : env) (tok : CST.pat_588cb21) =
  (* pattern [-+]?[0-9]*\.?[0-9]+([eE][+-]?[0-9]+)? *) token env tok

let map_kor (env : env) (tok : CST.kor) =
  (* pattern or *) token env tok

let map_kdestructor (env : env) (tok : CST.kdestructor) =
  (* pattern destructor *) token env tok

let map_ppelse (env : env) (tok : CST.ppelse) =
  (* ppelse *) token env tok

let map_kunit (env : env) (tok : CST.kunit) =
  (* pattern unit *) token env tok

let map_kcase (env : env) (tok : CST.kcase) =
  (* pattern case *) token env tok

let map_kis (env : env) (tok : CST.kis) =
  (* pattern is *) token env tok

let map_kprogram (env : env) (tok : CST.kprogram) =
  (* pattern program *) token env tok

let map_kvirtual (env : env) (tok : CST.kvirtual) =
  (* pattern virtual *) token env tok

let map_knostackframe (env : env) (tok : CST.knostackframe) =
  (* pattern nostackframe *) token env tok

let map_kplatform (env : env) (tok : CST.kplatform) =
  (* pattern platform *) token env tok

let map_kgoto (env : env) (tok : CST.kgoto) =
  (* pattern goto *) token env tok

let map_kstdcall (env : env) (tok : CST.kstdcall) =
  (* pattern stdcall *) token env tok

let map_karray (env : env) (tok : CST.karray) =
  (* pattern array *) token env tok

let map_kdo (env : env) (tok : CST.kdo) =
  (* pattern do *) token env tok

let map_kconstref (env : env) (tok : CST.kconstref) =
  (* pattern constref *) token env tok

let map_kon (env : env) (tok : CST.kon) =
  (* pattern on *) token env tok

let map_klocal (env : env) (tok : CST.klocal) =
  (* pattern local *) token env tok

let map_kwhile (env : env) (tok : CST.kwhile) =
  (* pattern while *) token env tok

let map_kdefault (env : env) (tok : CST.kdefault) =
  (* pattern default *) token env tok

let map_kpublished (env : env) (tok : CST.kpublished) =
  (* pattern published *) token env tok

let map_kcvar (env : env) (tok : CST.kcvar) =
  (* pattern cvar *) token env tok

let map_ksealed (env : env) (tok : CST.ksealed) =
  (* pattern sealed *) token env tok

let map_kuntil (env : env) (tok : CST.kuntil) =
  (* pattern until *) token env tok

let map_krequires (env : env) (tok : CST.krequires) =
  (* pattern requires *) token env tok

let map_kwrite (env : env) (tok : CST.kwrite) =
  (* pattern write *) token env tok

let map_ppfragmentstmt (env : env) (tok : CST.ppfragmentstmt) =
  (* ppfragmentstmt *) token env tok

let map_krecord (env : env) (tok : CST.krecord) =
  (* pattern record *) token env tok

let map_kpascal (env : env) (tok : CST.kpascal) =
  (* pattern pascal *) token env tok

let map_kprivate (env : env) (tok : CST.kprivate) =
  (* pattern private *) token env tok

let map_kms_abi_default (env : env) (tok : CST.kms_abi_default) =
  (* pattern ms_abi_default *) token env tok

let map_kout (env : env) (tok : CST.kout) =
  (* pattern out *) token env tok

let map_identifier (env : env) (tok : CST.identifier) =
  (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env tok

let map_kreadonly (env : env) (tok : CST.kreadonly) =
  (* pattern readonly *) token env tok

let map_kraise (env : env) (tok : CST.kraise) =
  (* pattern raise *) token env tok

let map_kregister (env : env) (tok : CST.kregister) =
  (* pattern register *) token env tok

let map_kwinapi (env : env) (tok : CST.kwinapi) =
  (* pattern winapi *) token env tok

let map_kalias (env : env) (tok : CST.kalias) =
  (* pattern alias *) token env tok

let map_kdelayed (env : env) (tok : CST.kdelayed) =
  (* pattern delayed *) token env tok

let map_kreintroduce (env : env) (tok : CST.kreintroduce) =
  (* pattern reintroduce *) token env tok

let map_kforward (env : env) (tok : CST.kforward) =
  (* pattern forward *) token env tok

let map_kmessage (env : env) (tok : CST.kmessage) =
  (* pattern message *) token env tok

let map_koverload (env : env) (tok : CST.koverload) =
  (* pattern overload *) token env tok

let map_kcppdecl (env : env) (tok : CST.kcppdecl) =
  (* pattern cppdecl *) token env tok

let map_kfinalization (env : env) (tok : CST.kfinalization) =
  (* pattern finalization *) token env tok

let map_kspecialize (env : env) (tok : CST.kspecialize) =
  (* pattern specialize *) token env tok

let map_ktry (env : env) (tok : CST.ktry) =
  (* pattern try *) token env tok

let map_kstatic (env : env) (tok : CST.kstatic) =
  (* pattern static *) token env tok

let map_ksysv_abi_default (env : env) (tok : CST.ksysv_abi_default) =
  (* pattern sysv_abi_default *) token env tok

let map_kexcept (env : env) (tok : CST.kexcept) =
  (* pattern except *) token env tok

let map_knodefault (env : env) (tok : CST.knodefault) =
  (* pattern nodefault *) token env tok

let map_tok_prec_p5_pat_b66c674 (env : env) (tok : CST.tok_prec_p5_pat_b66c674) =
  (* tok_prec_p5_pat_b66c674 *) token env tok

let map_ksoftfloat (env : env) (tok : CST.ksoftfloat) =
  (* pattern softfloat *) token env tok

let map_kobjccategory (env : env) (tok : CST.kobjccategory) =
  (* pattern objccategory *) token env tok

let map_koverride (env : env) (tok : CST.koverride) =
  (* pattern override *) token env tok

let map_kproperty (env : env) (tok : CST.kproperty) =
  (* pattern property *) token env tok

let map_kelse (env : env) (tok : CST.kelse) =
  (* pattern else *) token env tok

let map_kstored (env : env) (tok : CST.kstored) =
  (* pattern stored *) token env tok

let map_pat_6c79139 (env : env) (tok : CST.pat_6c79139) =
  (* pattern "'''[ \\t]*\\r?\\n([^']|'[^']|''[^'])*'''" *) token env tok

let map_ppfragmentexpr (env : env) (tok : CST.ppfragmentexpr) =
  (* ppfragmentexpr *) token env tok

let map_imm_tok_pat_d238afd (env : env) (tok : CST.imm_tok_pat_d238afd) =
  (* pattern \$[a-fA-F0-9]+ *) token env tok

let map_kclass (env : env) (tok : CST.kclass) =
  (* pattern class *) token env tok

let map_kprotected (env : env) (tok : CST.kprotected) =
  (* pattern protected *) token env tok

let map_tok_prec_p5_pat_af36d87 (env : env) (tok : CST.tok_prec_p5_pat_af36d87) =
  (* tok_prec_p5_pat_af36d87 *) token env tok

let map_kdispinterface (env : env) (tok : CST.kdispinterface) =
  (* pattern dispinterface *) token env tok

let map_kvectorcall (env : env) (tok : CST.kvectorcall) =
  (* pattern vectorcall *) token env tok

let map_pat_f7c0026 (env : env) (tok : CST.pat_f7c0026) =
  (* pattern \([^*]|\) *) token env tok

let map_knear (env : env) (tok : CST.knear) =
  (* pattern near *) token env tok

let map_ktype (env : env) (tok : CST.ktype) =
  (* pattern type *) token env tok

let map_kimplementation (env : env) (tok : CST.kimplementation) =
  (* pattern implementation *) token env tok

let map_kresourcestring (env : env) (tok : CST.kresourcestring) =
  (* pattern resourcestring *) token env tok

let map_ksafecall (env : env) (tok : CST.ksafecall) =
  (* pattern safecall *) token env tok

let map_kend (env : env) (tok : CST.kend) =
  (* pattern end *) token env tok

let map_kin (env : env) (tok : CST.kin) =
  (* pattern in *) token env tok

let map_kmod (env : env) (tok : CST.kmod) =
  (* pattern mod *) token env tok

let map_kdispid (env : env) (tok : CST.kdispid) =
  (* pattern dispid *) token env tok

let map_khardfloat (env : env) (tok : CST.khardfloat) =
  (* pattern hardfloat *) token env tok

let map_kname (env : env) (tok : CST.kname) =
  (* pattern name *) token env tok

let map_kstring (env : env) (tok : CST.kstring) =
  (* pattern string *) token env tok

let map_kas (env : env) (tok : CST.kas) =
  (* pattern as *) token env tok

let map_khelper (env : env) (tok : CST.khelper) =
  (* pattern helper *) token env tok

let map_kpublic (env : env) (tok : CST.kpublic) =
  (* pattern public *) token env tok

let map_kxor (env : env) (tok : CST.kxor) =
  (* pattern xor *) token env tok

let map_kms_abi_cdecl (env : env) (tok : CST.kms_abi_cdecl) =
  (* pattern ms_abi_cdecl *) token env tok

let map_kasm (env : env) (tok : CST.kasm) =
  (* pattern asm *) token env tok

let map_ppif (env : env) (tok : CST.ppif) =
  (* ppif *) token env tok

let map_kotherwise (env : env) (tok : CST.kotherwise) =
  (* pattern otherwise *) token env tok

let map_kread (env : env) (tok : CST.kread) =
  (* pattern read *) token env tok

let map_ksysv_abi_cdecl (env : env) (tok : CST.ksysv_abi_cdecl) =
  (* pattern sysv_abi_cdecl *) token env tok

let map_kand (env : env) (tok : CST.kand) =
  (* pattern and *) token env tok

let map_kdiv (env : env) (tok : CST.kdiv) =
  (* pattern div *) token env tok

let map_kfile (env : env) (tok : CST.kfile) =
  (* pattern file *) token env tok

let map_kfunction (env : env) (tok : CST.kfunction) =
  (* pattern function *) token env tok

let map_kabsolute (env : env) (tok : CST.kabsolute) =
  (* pattern absolute *) token env tok

let map_kstrict (env : env) (tok : CST.kstrict) =
  (* pattern strict *) token env tok

let map_tok_prec_p5_pat_6f93d17 (env : env) (tok : CST.tok_prec_p5_pat_6f93d17) =
  (* tok_prec_p5_pat_6f93d17 *) token env tok

let map_imm_tok_pat_ec19546 (env : env) (tok : CST.imm_tok_pat_ec19546) =
  (* pattern [-+]?[0-9]+ *) token env tok

let map_knot (env : env) (tok : CST.knot) =
  (* pattern not *) token env tok

let map_kthen (env : env) (tok : CST.kthen) =
  (* pattern then *) token env tok

let map_kassembler (env : env) (tok : CST.kassembler) =
  (* pattern assembler *) token env tok

let map_kfor (env : env) (tok : CST.kfor) =
  (* pattern for *) token env tok

let map_anon_choice_kto_86c5a40 (env : env) (x : CST.anon_choice_kto_86c5a40) =
  (match x with
  | `Kto tok -> R.Case ("Kto",
      (* pattern to *) token env tok
    )
  | `Kdow tok -> R.Case ("Kdow",
      (* pattern downto *) token env tok
    )
  )

let map_literalfloat (env : env) (x : CST.literalfloat) =
  map_pat_588cb21 env x

let map_anon_choice_kstd_a801c0a (env : env) (x : CST.anon_choice_kstd_a801c0a) =
  (match x with
  | `Kstd tok -> R.Case ("Kstd",
      (* pattern stdcall *) token env tok
    )
  | `Kcdecl tok -> R.Case ("Kcdecl",
      (* pattern cdecl *) token env tok
    )
  | `Ksaf tok -> R.Case ("Ksaf",
      (* pattern safecall *) token env tok
    )
  | `Kreg tok -> R.Case ("Kreg",
      (* pattern register *) token env tok
    )
  | `Kpas tok -> R.Case ("Kpas",
      (* pattern pascal *) token env tok
    )
  | `Kwin tok -> R.Case ("Kwin",
      (* pattern winapi *) token env tok
    )
  )

let map_anon_choice_kname_ba8a152 (env : env) (x : CST.anon_choice_kname_ba8a152) =
  (match x with
  | `Kname tok -> R.Case ("Kname",
      (* pattern name *) token env tok
    )
  | `Kindex tok -> R.Case ("Kindex",
      (* pattern index *) token env tok
    )
  )

let map_visibility (env : env) (x : CST.visibility) =
  (match x with
  | `Kpub_1e1f5a9 tok -> R.Case ("Kpub_1e1f5a9",
      (* pattern published *) token env tok
    )
  | `Kpub_659fa63 tok -> R.Case ("Kpub_659fa63",
      (* pattern public *) token env tok
    )
  | `Kpro tok -> R.Case ("Kpro",
      (* pattern protected *) token env tok
    )
  | `Kpri tok -> R.Case ("Kpri",
      (* pattern private *) token env tok
    )
  )

let map_anon_choice_kelse_d520062 (env : env) (x : CST.anon_choice_kelse_d520062) =
  (match x with
  | `Kelse tok -> R.Case ("Kelse",
      (* pattern else *) token env tok
    )
  | `Koth tok -> R.Case ("Koth",
      (* pattern otherwise *) token env tok
    )
  )

let map_anon_choice_kpro_f69e586 (env : env) (x : CST.anon_choice_kpro_f69e586) =
  (match x with
  | `Kpro tok -> R.Case ("Kpro",
      (* pattern procedure *) token env tok
    )
  | `Kfun tok -> R.Case ("Kfun",
      (* pattern function *) token env tok
    )
  )

let map_literalint (env : env) (x : CST.literalint) =
  (match x with
  | `Imm_tok_pat_ec19546 x -> R.Case ("Imm_tok_pat_ec19546",
      map_imm_tok_pat_ec19546 env x
    )
  | `Imm_tok_pat_d238afd x -> R.Case ("Imm_tok_pat_d238afd",
      map_imm_tok_pat_d238afd env x
    )
  | `Imm_tok_pat_f57674d x -> R.Case ("Imm_tok_pat_f57674d",
      map_imm_tok_pat_f57674d env x
    )
  )

let map_operatorname_ (env : env) (x : CST.operatorname_) =
  (match x with
  | `Kdot tok -> R.Case ("Kdot",
      (* "." *) token env tok
    )
  | `Klt tok -> R.Case ("Klt",
      (* "<" *) token env tok
    )
  | `Keq tok -> R.Case ("Keq",
      (* "=" *) token env tok
    )
  | `Kneq tok -> R.Case ("Kneq",
      (* "<>" *) token env tok
    )
  | `Kgt tok -> R.Case ("Kgt",
      (* ">" *) token env tok
    )
  | `Klte tok -> R.Case ("Klte",
      (* "<=" *) token env tok
    )
  | `Kgte tok -> R.Case ("Kgte",
      (* ">=" *) token env tok
    )
  | `Kadd tok -> R.Case ("Kadd",
      (* "+" *) token env tok
    )
  | `Ksub tok -> R.Case ("Ksub",
      (* "-" *) token env tok
    )
  | `Kmul tok -> R.Case ("Kmul",
      (* "*" *) token env tok
    )
  | `Kfdiv tok -> R.Case ("Kfdiv",
      (* "/" *) token env tok
    )
  | `Kdiv tok -> R.Case ("Kdiv",
      (* pattern div *) token env tok
    )
  | `Kmod tok -> R.Case ("Kmod",
      (* pattern mod *) token env tok
    )
  | `Kass tok -> R.Case ("Kass",
      (* ":=" *) token env tok
    )
  | `Kor tok -> R.Case ("Kor",
      (* pattern or *) token env tok
    )
  | `Kxor tok -> R.Case ("Kxor",
      (* pattern xor *) token env tok
    )
  | `Kand tok -> R.Case ("Kand",
      (* pattern and *) token env tok
    )
  | `Kshl tok -> R.Case ("Kshl",
      (* pattern shl *) token env tok
    )
  | `Kshr tok -> R.Case ("Kshr",
      (* pattern shr *) token env tok
    )
  | `Knot tok -> R.Case ("Knot",
      (* pattern not *) token env tok
    )
  | `Kin tok -> R.Case ("Kin",
      (* pattern in *) token env tok
    )
  )

let map_exprisnot (env : env) ((v1, v2) : CST.exprisnot) =
  let v1 = (* pattern is *) token env v1 in
  let v2 = (* pattern not *) token env v2 in
  R.Tuple [v1; v2]

let map_asmbody (env : env) (xs : CST.asmbody) =
  R.List (List.map (fun x ->
    (match x with
    | `Id tok -> R.Case ("Id",
        (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env tok
      )
    | `Pat_cafba40 x -> R.Case ("Pat_cafba40",
        map_pat_cafba40 env x
      )
    | `Pat_3ea53fb x -> R.Case ("Pat_3ea53fb",
        map_pat_3ea53fb env x
      )
    | `Pat_f7c0026 x -> R.Case ("Pat_f7c0026",
        map_pat_f7c0026 env x
      )
    )
  ) xs)

let map_modulename (env : env) ((v1, v2) : CST.modulename) =
  let v1 =
    (match v1 with
    | Some xs -> R.Option (Some (
        R.List (List.map (fun (v1, v2) ->
          let v1 =
            (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v1
          in
          let v2 = (* "." *) token env v2 in
          R.Tuple [v1; v2]
        ) xs)
      ))
    | None -> R.Option None)
  in
  let v2 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v2
  in
  R.Tuple [v1; v2]

let map_anon_opt_rep1_decl_COMMA_64c033f (env : env) (opt : CST.anon_opt_rep1_decl_COMMA_64c033f) =
  (match opt with
  | Some xs -> R.Option (Some (
      R.List (List.map (fun (v1, v2) ->
        let v1 =
          (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v1
        in
        let v2 = (* "," *) token env v2 in
        R.Tuple [v1; v2]
      ) xs)
    ))
  | None -> R.Option None)

let rec map_propaccessor (env : env) (x : CST.propaccessor) =
  (match x with
  | `Id tok -> R.Case ("Id",
      (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env tok
    )
  | `Prop (v1, v2, v3) -> R.Case ("Prop",
      let v1 = map_propaccessor env v1 in
      let v2 = (* "." *) token env v2 in
      let v3 =
        (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v3
      in
      R.Tuple [v1; v2; v3]
    )
  )

let map_label (env : env) ((v1, v2) : CST.label) =
  let v1 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v1
  in
  let v2 = (* ":" *) token env v2 in
  R.Tuple [v1; v2]

let rec map_anon_opt_rep1_type__COMMA_1201331 (env : env) (opt : CST.anon_opt_rep1_type__COMMA_1201331) =
  (match opt with
  | Some xs -> R.Option (Some (
      R.List (List.map (fun (v1, v2) ->
        let v1 = map_typeref_ env v1 in
        let v2 = (* "," *) token env v2 in
        R.Tuple [v1; v2]
      ) xs)
    ))
  | None -> R.Option None)

and map_typeref_ (env : env) (x : CST.typeref_) =
  (match x with
  | `Id tok -> R.Case ("Id",
      (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env tok
    )
  | `Type_3d7091c (v1, v2, v3) -> R.Case ("Type_3d7091c",
      let v1 = map_typeref_ env v1 in
      let v2 = (* "." *) token env v2 in
      let v3 = map_typeref_ env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Type_90e8385 (v1, v2, v3, v4) -> R.Case ("Type_90e8385",
      let v1 = map_typeref_ env v1 in
      let v2 = (* "<" *) token env v2 in
      let v3 = map_typerefargs env v3 in
      let v4 = (* ">" *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Type_cae2886 (v1, v2) -> R.Case ("Type_cae2886",
      let v1 = (* "^" *) token env v1 in
      let v2 = map_typeref_ env v2 in
      R.Tuple [v1; v2]
    )
  | `Ppfr tok -> R.Case ("Ppfr",
      (* ppfragmentexpr *) token env tok
    )
  )

and map_typerefargs (env : env) ((v1, v2) : CST.typerefargs) =
  let v1 = map_anon_opt_rep1_type__COMMA_1201331 env v1 in
  let v2 = map_typeref_ env v2 in
  R.Tuple [v1; v2]

let map_anon_choice_visi_5a3c750 (env : env) (x : CST.anon_choice_visi_5a3c750) =
  (match x with
  | `Visi x -> R.Case ("Visi",
      map_visibility env x
    )
  | `Kreq tok -> R.Case ("Kreq",
      (* pattern required *) token env tok
    )
  | `Kopt tok -> R.Case ("Kopt",
      (* pattern optional *) token env tok
    )
  )

let map_literalnumber (env : env) (x : CST.literalnumber) =
  (match x with
  | `Lite_65d24c1 x -> R.Case ("Lite_65d24c1",
      map_literalint env x
    )
  | `Lite_bdeb053 x -> R.Case ("Lite_bdeb053",
      map_literalfloat env x
    )
  )

let map_asmtr (env : env) ((v1, v2, v3) : CST.asmtr) =
  let v1 = (* pattern asm *) token env v1 in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_asmbody env x
      ))
    | None -> R.Option None)
  in
  let v3 = (* pattern end *) token env v3 in
  R.Tuple [v1; v2; v3]

let rec map_anon_choice_modu_eefd7e7 (env : env) (x : CST.anon_choice_modu_eefd7e7) =
  (match x with
  | `Modu x -> R.Case ("Modu",
      map_modulename env x
    )
  | `Ppus x -> R.Case ("Ppus",
      map_ppusesblock env x
    )
  | `COMMA tok -> R.Case ("COMMA",
      (* "," *) token env tok
    )
  )

and map_ppusesblock (env : env) ((v1, v2, v3, v4) : CST.ppusesblock) =
  let v1 = map_tok_prec_p5_pat_0a9b8cd env v1 in
  let v2 =
    R.List (List.map (map_anon_choice_modu_eefd7e7 env) v2)
  in
  let v3 =
    R.List (List.map (fun (v1, v2) ->
      let v1 = map_tok_prec_p5_pat_af36d87 env v1 in
      let v2 =
        R.List (List.map (map_anon_choice_modu_eefd7e7 env) v2)
      in
      R.Tuple [v1; v2]
    ) v3)
  in
  let v4 = map_tok_prec_p5_pat_ef0cc7f env v4 in
  R.Tuple [v1; v2; v3; v4]

let map_decllabels (env : env) ((v1, v2, v3, v4) : CST.decllabels) =
  let v1 = (* pattern label *) token env v1 in
  let v2 = map_anon_opt_rep1_decl_COMMA_64c033f env v2 in
  let v3 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v3
  in
  let v4 = (* ";" *) token env v4 in
  R.Tuple [v1; v2; v3; v4]

let map_literalstring_ (env : env) (x : CST.literalstring_) =
  (match x with
  | `Pat_6c79139 x -> R.Case ("Pat_6c79139",
      map_pat_6c79139 env x
    )
  | `Pat_cdd9bad x -> R.Case ("Pat_cdd9bad",
      map_pat_cdd9bad env x
    )
  | `Lite (v1, v2) -> R.Case ("Lite",
      let v1 = (* "#" *) token env v1 in
      let v2 = map_literalint env v2 in
      R.Tuple [v1; v2]
    )
  )

let map_ppusesblockwithsemi (env : env) ((v1, v2, v3, v4, v5) : CST.ppusesblockwithsemi) =
  let v1 = map_tok_prec_p5_pat_0a9b8cd env v1 in
  let v2 =
    R.List (List.map (map_anon_choice_modu_eefd7e7 env) v2)
  in
  let v3 = (* ";" *) token env v3 in
  let v4 =
    R.List (List.map (fun (v1, v2, v3) ->
      let v1 = map_tok_prec_p5_pat_af36d87 env v1 in
      let v2 =
        R.List (List.map (map_anon_choice_modu_eefd7e7 env) v2)
      in
      let v3 = (* ";" *) token env v3 in
      R.Tuple [v1; v2; v3]
    ) v4)
  in
  let v5 = map_tok_prec_p5_pat_ef0cc7f env v5 in
  R.Tuple [v1; v2; v3; v4; v5]

let map_literalstring (env : env) (xs : CST.literalstring) =
  R.List (List.map (map_literalstring_ env) xs)

let map_literal (env : env) (x : CST.literal) =
  (match x with
  | `Lite_4d69a90 x -> R.Case ("Lite_4d69a90",
      map_literalstring env x
    )
  | `Lite_f64c399 x -> R.Case ("Lite_f64c399",
      map_literalnumber env x
    )
  | `Knil tok -> R.Case ("Knil",
      (* pattern nil *) token env tok
    )
  | `Ktrue tok -> R.Case ("Ktrue",
      (* pattern true *) token env tok
    )
  | `Kfalse tok -> R.Case ("Kfalse",
      (* pattern false *) token env tok
    )
  )

let map_subrangebound (env : env) (x : CST.subrangebound) =
  (match x with
  | `Lite_f64c399 x -> R.Case ("Lite_f64c399",
      map_literalnumber env x
    )
  | `Choice_DASH_lite (v1, v2) -> R.Case ("Choice_DASH_lite",
      let v1 =
        (match v1 with
        | `DASH tok -> R.Case ("DASH",
            (* "-" *) token env tok
          )
        | `PLUS tok -> R.Case ("PLUS",
            (* "+" *) token env tok
          )
        )
      in
      let v2 = map_literalnumber env v2 in
      R.Tuple [v1; v2]
    )
  | `Lite_4d69a90 x -> R.Case ("Lite_4d69a90",
      map_literalstring env x
    )
  | `Type_ x -> R.Case ("Type_",
      map_typeref_ env x
    )
  )

let map_hintdirective (env : env) (x : CST.hintdirective) =
  (match x with
  | `Kdep_opt_lite (v1, v2) -> R.Case ("Kdep_opt_lite",
      let v1 = (* pattern deprecated *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_literalstring env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2]
    )
  | `Kpla tok -> R.Case ("Kpla",
      (* pattern platform *) token env tok
    )
  | `Kexp tok -> R.Case ("Kexp",
      (* pattern experimental *) token env tok
    )
  )

let map_moduleinfile (env : env) ((v1, v2, v3) : CST.moduleinfile) =
  let v1 = map_modulename env v1 in
  let v2 = (* pattern in *) token env v2 in
  let v3 = map_literalstring env v3 in
  R.Tuple [v1; v2; v3]

let map_usesclauseentry (env : env) (x : CST.usesclauseentry) =
  (match x with
  | `Modu_5b9c6b7 x -> R.Case ("Modu_5b9c6b7",
      map_modulename env x
    )
  | `Ppus x -> R.Case ("Ppus",
      map_ppusesblock env x
    )
  | `COMMA tok -> R.Case ("COMMA",
      (* "," *) token env tok
    )
  | `Modu_fdf97ab x -> R.Case ("Modu_fdf97ab",
      map_moduleinfile env x
    )
  | `Semg_ellips tok -> R.Case ("Semg_ellips",
      (* "..." *) token env tok
    )
  )

let map_anon_choice_modu_685a062 (env : env) (x : CST.anon_choice_modu_685a062) =
  (match x with
  | `Modu_5b9c6b7 x -> R.Case ("Modu_5b9c6b7",
      map_modulename env x
    )
  | `Modu_fdf97ab x -> R.Case ("Modu_fdf97ab",
      map_moduleinfile env x
    )
  )

let map_decluses (env : env) ((v1, v2) : CST.decluses) =
  let v1 = (* pattern uses *) token env v1 in
  let v2 =
    (match v2 with
    | `Rep1_uses_SEMI (v1, v2) -> R.Case ("Rep1_uses_SEMI",
        let v1 = R.List (List.map (map_usesclauseentry env) v1) in
        let v2 = (* ";" *) token env v2 in
        R.Tuple [v1; v2]
      )
    | `Ppus x -> R.Case ("Ppus",
        map_ppusesblockwithsemi env x
      )
    )
  in
  R.Tuple [v1; v2]

let rec map_anon_LPAR_opt_opt_rep1_type_COMMA_type_RPAR_116e8a8 (env : env) ((v1, v2, v3) : CST.anon_LPAR_opt_opt_rep1_type_COMMA_type_RPAR_116e8a8) =
  let v1 = (* "(" *) token env v1 in
  let v2 =
    (match v2 with
    | Some (v1, v2) -> R.Option (Some (
        let v1 = map_anon_opt_rep1_type_COMMA_9c6ebb1 env v1 in
        let v2 = map_typeref env v2 in
        R.Tuple [v1; v2]
      ))
    | None -> R.Option None)
  in
  let v3 = (* ")" *) token env v3 in
  R.Tuple [v1; v2; v3]

and map_anon_choice_bloc_1cb9769 (env : env) (x : CST.anon_choice_bloc_1cb9769) =
  (match x with
  | `Bloc x -> R.Case ("Bloc",
      map_blocktr env x
    )
  | `Asmtr x -> R.Case ("Asmtr",
      map_asmtr env x
    )
  )

and map_anon_choice_decl_fe4bcc4 (env : env) (x : CST.anon_choice_decl_fe4bcc4) =
  (match x with
  | `Decl_c64a659 x -> R.Case ("Decl_c64a659",
      map_decltype env x
    )
  | `Decl_a20e53a x -> R.Case ("Decl_a20e53a",
      map_declvar env x
    )
  | `Decl_d45e488 x -> R.Case ("Decl_d45e488",
      map_declconst env x
    )
  | `Decl_6ec32a9 x -> R.Case ("Decl_6ec32a9",
      map_declproc env x
    )
  | `Decl_5f998b5 x -> R.Case ("Decl_5f998b5",
      map_declprop env x
    )
  | `Decl_8dd77dd x -> R.Case ("Decl_8dd77dd",
      map_declprocfwd env x
    )
  | `Decl_497d63e x -> R.Case ("Decl_497d63e",
      map_declfield env x
    )
  | `Declts x -> R.Case ("Declts",
      map_decltypes env x
    )
  | `Declvs x -> R.Case ("Declvs",
      map_declvars env x
    )
  | `Declcs x -> R.Case ("Declcs",
      map_declconsts env x
    )
  | `Defp x -> R.Case ("Defp",
      map_defproc env x
    )
  | `Declus x -> R.Case ("Declus",
      map_decluses env x
    )
  | `Declls x -> R.Case ("Declls",
      map_decllabels env x
    )
  | `Decles x -> R.Case ("Decles",
      map_declexports env x
    )
  | `Stmt x -> R.Case ("Stmt",
      map_statement env x
    )
  | `Ppbl x -> R.Case ("Ppbl",
      map_ppblock env x
    )
  | `SEMI tok -> R.Case ("SEMI",
      (* ";" *) token env tok
    )
  | `COMMA tok -> R.Case ("COMMA",
      (* "," *) token env tok
    )
  )

and map_anon_choice_exce_8373abe (env : env) (x : CST.anon_choice_exce_8373abe) =
  (match x with
  | `Exce_66e7373 x -> R.Case ("Exce_66e7373",
      map_exceptionhandler env x
    )
  | `Exce_89cca21 (v1, v2, v3, v4, v5) -> R.Case ("Exce_89cca21",
      let v1 = (* pattern on *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_label env x
          ))
        | None -> R.Option None)
      in
      let v3 = map_typeref env v3 in
      let v4 = (* pattern do *) token env v4 in
      let v5 =
        (match v5 with
        | Some x -> R.Option (Some (
            map_statementtr env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3; v4; v5]
    )
  )

and map_anon_choice_expr_0b0705b (env : env) (x : CST.anon_choice_expr_0b0705b) =
  (match x with
  | `Expr x -> R.Case ("Expr",
      map_expr env x
    )
  | `Range x -> R.Case ("Range",
      map_range env x
    )
  )

and map_anon_choice_expr_2fa3e6e (env : env) (x : CST.anon_choice_expr_2fa3e6e) =
  (match x with
  | `Expr x -> R.Case ("Expr",
      map_expr env x
    )
  | `Vara (v1, v2, v3) -> R.Case ("Vara",
      let v1 = (* pattern var *) token env v1 in
      let v2 =
        (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v2
      in
      let v3 =
        (match v3 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 = (* ":" *) token env v1 in
            let v2 = map_typeref env v2 in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3]
    )
  )

and map_anon_choice_kelse_opt_COLON_opt_stat__c22ab7e (env : env) ((v1, v2, v3) : CST.anon_choice_kelse_opt_COLON_opt_stat__c22ab7e) =
  let v1 = map_anon_choice_kelse_d520062 env v1 in
  let v2 =
    (match v2 with
    | Some tok -> R.Option (Some (
        (* ":" *) token env tok
      ))
    | None -> R.Option None)
  in
  let v3 =
    (match v3 with
    | Some x -> R.Option (Some (
        map_statementstr_ env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2; v3]

and map_anon_choice_kexc_opt_choice_stat__d8e7a89 (env : env) (x : CST.anon_choice_kexc_opt_choice_stat__d8e7a89) =
  (match x with
  | `Kexc_opt_choice_stat_ (v1, v2) -> R.Case ("Kexc_opt_choice_stat_",
      let v1 = (* pattern except *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_anon_choice_stat__f368a69 env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2]
    )
  | `Kfin_opt_stat_ (v1, v2) -> R.Case ("Kfin_opt_stat_",
      let v1 = (* pattern finally *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_statementstr_ env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2]
    )
  )

and map_anon_choice_proc__b0bc660 (env : env) (x : CST.anon_choice_proc__b0bc660) =
  (match x with
  | `Proc_ x -> R.Case ("Proc_",
      map_procattribute_ env x
    )
  | `Proc x -> R.Case ("Proc",
      map_procexternal env x
    )
  )

and map_anon_choice_range_ff5eaed (env : env) (x : CST.anon_choice_range_ff5eaed) =
  (match x with
  | `Range x -> R.Case ("Range",
      map_range env x
    )
  | `Expr x -> R.Case ("Expr",
      map_expr env x
    )
  )

and map_anon_choice_stat_2a62092 (env : env) (x : CST.anon_choice_stat_2a62092) =
  (match x with
  | `Stat x -> R.Case ("Stat",
      map_statementtr env x
    )
  | `If x -> R.Case ("If",
      map_nestediftr env x
    )
  )

and map_anon_choice_stat__f368a69 (env : env) (x : CST.anon_choice_stat__f368a69) =
  (match x with
  | `Stat_ x -> R.Case ("Stat_",
      map_statementstr_ env x
    )
  | `Exce (v1, v2, v3) -> R.Case ("Exce",
      let v1 = R.List (List.map (map_exceptionhandler env) v1) in
      let v2 = map_anon_choice_exce_8373abe env v2 in
      let v3 =
        (match v3 with
        | Some x -> R.Option (Some (
            map_exceptionelse env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3]
    )
  )

and map_anon_opt_kdep_opt_expr_9e396fa (env : env) (opt : CST.anon_opt_kdep_opt_expr_9e396fa) =
  (match opt with
  | Some (v1, v2) -> R.Option (Some (
      let v1 = (* pattern deprecated *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_expr env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2]
    ))
  | None -> R.Option None)

and map_anon_opt_rep1_choice_expr_COMMA_d776c0e (env : env) (opt : CST.anon_opt_rep1_choice_expr_COMMA_d776c0e) =
  (match opt with
  | Some xs -> R.Option (Some (
      R.List (List.map (fun (v1, v2) ->
        let v1 = map_anon_choice_expr_0b0705b env v1 in
        let v2 = (* "," *) token env v2 in
        R.Tuple [v1; v2]
      ) xs)
    ))
  | None -> R.Option None)

and map_anon_opt_rep1_decl_SEMI_bce1ef3 (env : env) (opt : CST.anon_opt_rep1_decl_SEMI_bce1ef3) =
  (match opt with
  | Some xs -> R.Option (Some (
      R.List (List.map (fun (v1, v2) ->
        let v1 = map_declarg env v1 in
        let v2 = (* ";" *) token env v2 in
        R.Tuple [v1; v2]
      ) xs)
    ))
  | None -> R.Option None)

and map_anon_opt_rep1_expr_COMMA_39d8f3f (env : env) (opt : CST.anon_opt_rep1_expr_COMMA_39d8f3f) =
  (match opt with
  | Some xs -> R.Option (Some (
      R.List (List.map (fun (v1, v2) ->
        let v1 = map_expr env v1 in
        let v2 = (* "," *) token env v2 in
        R.Tuple [v1; v2]
      ) xs)
    ))
  | None -> R.Option None)

and map_anon_opt_rep1_type_COMMA_9c6ebb1 (env : env) (opt : CST.anon_opt_rep1_type_COMMA_9c6ebb1) =
  (match opt with
  | Some xs -> R.Option (Some (
      R.List (List.map (fun (v1, v2) ->
        let v1 = map_typeref env v1 in
        let v2 = (* "," *) token env v2 in
        R.Tuple [v1; v2]
      ) xs)
    ))
  | None -> R.Option None)

and map_arrinitializer (env : env) ((v1, v2, v3, v4) : CST.arrinitializer) =
  let v1 = (* "(" *) token env v1 in
  let v2 =
    (match v2 with
    | Some xs -> R.Option (Some (
        R.List (List.map (fun (v1, v2) ->
          let v1 = map_initializer_ env v1 in
          let v2 = (* "," *) token env v2 in
          R.Tuple [v1; v2]
        ) xs)
      ))
    | None -> R.Option None)
  in
  let v3 = map_initializer_ env v3 in
  let v4 = (* ")" *) token env v4 in
  R.Tuple [v1; v2; v3; v4]

and map_assignment (env : env) ((v1, v2, v3) : CST.assignment) =
  let v1 = map_anon_choice_expr_2fa3e6e env v1 in
  let v2 =
    (match v2 with
    | `Kass_82d56ca tok -> R.Case ("Kass_82d56ca",
        (* ":=" *) token env tok
      )
    | `Kass_ba783c9 tok -> R.Case ("Kass_ba783c9",
        (* "+=" *) token env tok
      )
    | `Kass_4c2e9df tok -> R.Case ("Kass_4c2e9df",
        (* "-=" *) token env tok
      )
    | `Kass_f4032f6 tok -> R.Case ("Kass_f4032f6",
        (* "*=" *) token env tok
      )
    | `Kass_e6faaf6 tok -> R.Case ("Kass_e6faaf6",
        (* "/=" *) token env tok
      )
    )
  in
  let v3 = map_expr env v3 in
  R.Tuple [v1; v2; v3]

and map_blocktr (env : env) ((v1, v2, v3) : CST.blocktr) =
  let v1 = (* pattern begin *) token env v1 in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_statementstr_ env x
      ))
    | None -> R.Option None)
  in
  let v3 = (* pattern end *) token env v3 in
  R.Tuple [v1; v2; v3]

and map_casecase (env : env) ((v1, v2) : CST.casecase) =
  let v1 = map_caselabel env v1 in
  let v2 = map_statement env v2 in
  R.Tuple [v1; v2]

and map_casecasetr (env : env) ((v1, v2) : CST.casecasetr) =
  let v1 = map_caselabel env v1 in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_statementtr env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2]

and map_caselabel (env : env) ((v1, v2, v3) : CST.caselabel) =
  let v1 =
    map_anon_opt_rep1_choice_expr_COMMA_d776c0e env v1
  in
  let v2 = map_anon_choice_expr_0b0705b env v2 in
  let v3 = (* ":" *) token env v3 in
  R.Tuple [v1; v2; v3]

and map_classdeclarations (env : env) (xs : CST.classdeclarations) =
  R.List (List.map (fun x ->
    (match x with
    | `Declts x -> R.Case ("Declts",
        map_decltypes env x
      )
    | `Declvs x -> R.Case ("Declvs",
        map_declvars env x
      )
    | `Declcs x -> R.Case ("Declcs",
        map_declconsts env x
      )
    | `Decl_6ec32a9 x -> R.Case ("Decl_6ec32a9",
        map_declproc env x
      )
    | `Decl_5f998b5 x -> R.Case ("Decl_5f998b5",
        map_declprop env x
      )
    | `Ppbl x -> R.Case ("Ppbl",
        map_ppblock env x
      )
    | `Semg_ellips tok -> R.Case ("Semg_ellips",
        (* "..." *) token env tok
      )
    )
  ) xs)

and map_declarg (env : env) (x : CST.declarg) =
  (match x with
  | `Choice_choice_kvar_opt_rep1_id_COMMA_id_opt_COLON_type_opt_defa x -> R.Case ("Choice_choice_kvar_opt_rep1_id_COMMA_id_opt_COLON_type_opt_defa",
      (match x with
      | `Choice_kvar_opt_rep1_id_COMMA_id_opt_COLON_type_opt_defa (v1, v2, v3, v4) -> R.Case ("Choice_kvar_opt_rep1_id_COMMA_id_opt_COLON_type_opt_defa",
          let v1 =
            (match v1 with
            | `Kvar tok -> R.Case ("Kvar",
                (* pattern var *) token env tok
              )
            | `Kout tok -> R.Case ("Kout",
                (* pattern out *) token env tok
              )
            | `Kcon tok -> R.Case ("Kcon",
                (* pattern constref *) token env tok
              )
            | `Kconst_opt_rttias (v1, v2) -> R.Case ("Kconst_opt_rttias",
                let v1 = (* pattern const *) token env v1 in
                let v2 =
                  (match v2 with
                  | Some x -> R.Option (Some (
                      map_rttiattributes env x
                    ))
                  | None -> R.Option None)
                in
                R.Tuple [v1; v2]
              )
            )
          in
          let v2 = map_anon_opt_rep1_decl_COMMA_64c033f env v2 in
          let v3 =
            (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v3
          in
          let v4 =
            (match v4 with
            | Some (v1, v2, v3) -> R.Option (Some (
                let v1 = (* ":" *) token env v1 in
                let v2 = map_type_ env v2 in
                let v3 =
                  (match v3 with
                  | Some x -> R.Option (Some (
                      map_defaultvalue env x
                    ))
                  | None -> R.Option None)
                in
                R.Tuple [v1; v2; v3]
              ))
            | None -> R.Option None)
          in
          R.Tuple [v1; v2; v3; v4]
        )
      | `Opt_rep1_id_COMMA_id_COLON_type_opt_defa x -> R.Case ("Opt_rep1_id_COMMA_id_COLON_type_opt_defa",
          map_declvariantfield env x
        )
      )
    )
  | `Semg_ellips tok -> R.Case ("Semg_ellips",
      (* "..." *) token env tok
    )
  )

and map_declargs (env : env) ((v1, v2, v3) : CST.declargs) =
  let v1 = (* "(" *) token env v1 in
  let v2 =
    (match v2 with
    | Some (v1, v2) -> R.Option (Some (
        let v1 = map_anon_opt_rep1_decl_SEMI_bce1ef3 env v1 in
        let v2 = map_declarg env v2 in
        R.Tuple [v1; v2]
      ))
    | None -> R.Option None)
  in
  let v3 = (* ")" *) token env v3 in
  R.Tuple [v1; v2; v3]

and map_declclass (env : env) ((v1, v2, v3, v4, v5) : CST.declclass) =
  let v1 =
    (match v1 with
    | Some tok -> R.Option (Some (
        (* pattern packed *) token env tok
      ))
    | None -> R.Option None)
  in
  let v2 =
    (match v2 with
    | `Kclass tok -> R.Case ("Kclass",
        (* pattern class *) token env tok
      )
    | `Krec tok -> R.Case ("Krec",
        (* pattern record *) token env tok
      )
    | `Kobj_46ccc5a tok -> R.Case ("Kobj_46ccc5a",
        (* pattern object *) token env tok
      )
    | `Kobj_c680b59 tok -> R.Case ("Kobj_c680b59",
        (* pattern objcclass *) token env tok
      )
    | `Kobj_3b0f491 tok -> R.Case ("Kobj_3b0f491",
        (* pattern objccategory *) token env tok
      )
    | `Kobj_ef2d785 tok -> R.Case ("Kobj_ef2d785",
        (* pattern objcprotocol *) token env tok
      )
    )
  in
  let v3 =
    (match v3 with
    | Some x -> R.Option (Some (
        (match x with
        | `Kabs tok -> R.Case ("Kabs",
            (* pattern abstract *) token env tok
          )
        | `Ksea tok -> R.Case ("Ksea",
            (* pattern sealed *) token env tok
          )
        | `Kext_opt_kname_expr (v1, v2) -> R.Case ("Kext_opt_kname_expr",
            let v1 = (* pattern external *) token env v1 in
            let v2 =
              (match v2 with
              | Some (v1, v2) -> R.Option (Some (
                  let v1 = (* pattern name *) token env v1 in
                  let v2 = map_expr env v2 in
                  R.Tuple [v1; v2]
                ))
              | None -> R.Option None)
            in
            R.Tuple [v1; v2]
          )
        )
      ))
    | None -> R.Option None)
  in
  let v4 =
    (match v4 with
    | Some x -> R.Option (Some (
        map_anon_LPAR_opt_opt_rep1_type_COMMA_type_RPAR_116e8a8 env x
      ))
    | None -> R.Option None)
  in
  let v5 =
    (match v5 with
    | Some x -> R.Option (Some (
        map_declclass_ env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2; v3; v4; v5]

and map_declclass_ (env : env) ((v1, v2, v3, v4, v5) : CST.declclass_) =
  let v1 =
    (match v1 with
    | Some x -> R.Option (Some (
        map_declfields env x
      ))
    | None -> R.Option None)
  in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_classdeclarations env x
      ))
    | None -> R.Option None)
  in
  let v3 =
    R.List (List.map (fun x ->
      (match x with
      | `Decl x -> R.Case ("Decl",
          map_declsection env x
        )
      | `Ppde x -> R.Case ("Ppde",
          map_ppdeclsection env x
        )
      )
    ) v3)
  in
  let v4 =
    (match v4 with
    | Some x -> R.Option (Some (
        map_declvariant env x
      ))
    | None -> R.Option None)
  in
  let v5 = (* pattern end *) token env v5 in
  R.Tuple [v1; v2; v3; v4; v5]

and map_declconst (env : env) ((v1, v2, v3, v4, v5, v6, v7) : CST.declconst) =
  let v1 =
    (match v1 with
    | Some x -> R.Option (Some (
        map_rttiattributes env x
      ))
    | None -> R.Option None)
  in
  let v2 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v2
  in
  let v3 =
    (match v3 with
    | Some (v1, v2) -> R.Option (Some (
        let v1 = (* ":" *) token env v1 in
        let v2 = map_type_ env v2 in
        R.Tuple [v1; v2]
      ))
    | None -> R.Option None)
  in
  let v4 = map_defaultvalue env v4 in
  let v5 =
    (match v5 with
    | Some x -> R.Option (Some (
        map_hintdirective env x
      ))
    | None -> R.Option None)
  in
  let v6 = (* ";" *) token env v6 in
  let v7 = R.List (List.map (map_procattribute env) v7) in
  R.Tuple [v1; v2; v3; v4; v5; v6; v7]

and map_declconsts (env : env) ((v1, v2, v3) : CST.declconsts) =
  let v1 =
    (match v1 with
    | Some tok -> R.Option (Some (
        (* pattern class *) token env tok
      ))
    | None -> R.Option None)
  in
  let v2 =
    (match v2 with
    | `Kconst tok -> R.Case ("Kconst",
        (* pattern const *) token env tok
      )
    | `Kres tok -> R.Case ("Kres",
        (* pattern resourcestring *) token env tok
      )
    )
  in
  let v3 =
    R.List (List.map (fun x ->
      (match x with
      | `Decl x -> R.Case ("Decl",
          map_declconst env x
        )
      | `Ppbl x -> R.Case ("Ppbl",
          map_ppblock env x
        )
      )
    ) v3)
  in
  R.Tuple [v1; v2; v3]

and map_declenumvalue (env : env) ((v1, v2) : CST.declenumvalue) =
  let v1 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v1
  in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_defaultvalue env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2]

and map_declexport (env : env) ((v1, v2) : CST.declexport) =
  let v1 = map_genericname env v1 in
  let v2 =
    R.List (List.map (fun (v1, v2) ->
      let v1 = map_anon_choice_kname_ba8a152 env v1 in
      let v2 = map_expr env v2 in
      R.Tuple [v1; v2]
    ) v2)
  in
  R.Tuple [v1; v2]

and map_declexports (env : env) ((v1, v2, v3) : CST.declexports) =
  let v1 = (* pattern exports *) token env v1 in
  let v2 =
    (match v2 with
    | Some (v1, v2) -> R.Option (Some (
        let v1 =
          (match v1 with
          | Some xs -> R.Option (Some (
              R.List (List.map (fun (v1, v2) ->
                let v1 = map_declexport env v1 in
                let v2 = (* "," *) token env v2 in
                R.Tuple [v1; v2]
              ) xs)
            ))
          | None -> R.Option None)
        in
        let v2 = map_declexport env v2 in
        R.Tuple [v1; v2]
      ))
    | None -> R.Option None)
  in
  let v3 = (* ";" *) token env v3 in
  R.Tuple [v1; v2; v3]

and map_declfield (env : env) ((v1, v2, v3, v4, v5, v6, v7) : CST.declfield) =
  let v1 =
    (match v1 with
    | Some x -> R.Option (Some (
        map_rttiattributes env x
      ))
    | None -> R.Option None)
  in
  let v2 = map_anon_opt_rep1_decl_COMMA_64c033f env v2 in
  let v3 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v3
  in
  let v4 = (* ":" *) token env v4 in
  let v5 = map_type_ env v5 in
  let v6 =
    (match v6 with
    | Some x -> R.Option (Some (
        map_defaultvalue env x
      ))
    | None -> R.Option None)
  in
  let v7 = (* ";" *) token env v7 in
  R.Tuple [v1; v2; v3; v4; v5; v6; v7]

and map_declfields (env : env) (xs : CST.declfields) =
  R.List (List.map (fun x ->
    (match x with
    | `Decl x -> R.Case ("Decl",
        map_declfield env x
      )
    | `Ppbl x -> R.Case ("Ppbl",
        map_ppblock env x
      )
    )
  ) xs)

and map_declhelper (env : env) ((v1, v2, v3, v4, v5, v6) : CST.declhelper) =
  let v1 =
    (match v1 with
    | `Kclass tok -> R.Case ("Kclass",
        (* pattern class *) token env tok
      )
    | `Krec tok -> R.Case ("Krec",
        (* pattern record *) token env tok
      )
    | `Ktype tok -> R.Case ("Ktype",
        (* pattern type *) token env tok
      )
    )
  in
  let v2 = (* pattern helper *) token env v2 in
  let v3 =
    (match v3 with
    | Some x -> R.Option (Some (
        map_anon_LPAR_opt_opt_rep1_type_COMMA_type_RPAR_116e8a8 env x
      ))
    | None -> R.Option None)
  in
  let v4 = (* pattern for *) token env v4 in
  let v5 = map_typeref env v5 in
  let v6 = map_declclass_ env v6 in
  R.Tuple [v1; v2; v3; v4; v5; v6]

and map_declintf (env : env) ((v1, v2, v3, v4, v5) : CST.declintf) =
  let v1 =
    (match v1 with
    | Some tok -> R.Option (Some (
        (* pattern packed *) token env tok
      ))
    | None -> R.Option None)
  in
  let v2 =
    (match v2 with
    | `Kint tok -> R.Case ("Kint",
        (* pattern interface *) token env tok
      )
    | `Kdis tok -> R.Case ("Kdis",
        (* pattern dispinterface *) token env tok
      )
    )
  in
  let v3 =
    (match v3 with
    | Some x -> R.Option (Some (
        map_anon_LPAR_opt_opt_rep1_type_COMMA_type_RPAR_116e8a8 env x
      ))
    | None -> R.Option None)
  in
  let v4 =
    (match v4 with
    | Some x -> R.Option (Some (
        map_guid env x
      ))
    | None -> R.Option None)
  in
  let v5 =
    (match v5 with
    | Some x -> R.Option (Some (
        map_declclass_ env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2; v3; v4; v5]

and map_decloperator (env : env) ((v1, v2, v3, v4, v5, v6, v7, v8, v9) : CST.decloperator) =
  let v1 =
    (match v1 with
    | Some tok -> R.Option (Some (
        (* pattern class *) token env tok
      ))
    | None -> R.Option None)
  in
  let v2 = (* pattern operator *) token env v2 in
  let v3 = map_operatorname env v3 in
  let v4 =
    (match v4 with
    | Some x -> R.Option (Some (
        map_declargs env x
      ))
    | None -> R.Option None)
  in
  let v5 =
    (match v5 with
    | Some tok -> R.Option (Some (
        (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env tok
      ))
    | None -> R.Option None)
  in
  let v6 =
    (match v6 with
    | Some (v1, v2) -> R.Option (Some (
        let v1 = (* ":" *) token env v1 in
        let v2 = map_type_ env v2 in
        R.Tuple [v1; v2]
      ))
    | None -> R.Option None)
  in
  let v7 =
    (match v7 with
    | Some x -> R.Option (Some (
        map_defaultvalue env x
      ))
    | None -> R.Option None)
  in
  let v8 = (* ";" *) token env v8 in
  let v9 =
    R.List (List.map (map_procattributenoext env) v9)
  in
  R.Tuple [v1; v2; v3; v4; v5; v6; v7; v8; v9]

and map_declproc (env : env) ((v1, v2) : CST.declproc) =
  let v1 =
    (match v1 with
    | Some x -> R.Option (Some (
        map_rttiattributes env x
      ))
    | None -> R.Option None)
  in
  let v2 =
    (match v2 with
    | `Decl_ x -> R.Case ("Decl_",
        map_declproc_ env x
      )
    | `Decl x -> R.Case ("Decl",
        map_decloperator env x
      )
    )
  in
  R.Tuple [v1; v2]

and map_declproc_ (env : env) ((v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) : CST.declproc_) =
  let v1 =
    (match v1 with
    | Some tok -> R.Option (Some (
        (* pattern generic *) token env tok
      ))
    | None -> R.Option None)
  in
  let v2 =
    (match v2 with
    | Some tok -> R.Option (Some (
        (* pattern class *) token env tok
      ))
    | None -> R.Option None)
  in
  let v3 =
    (match v3 with
    | `Kpro tok -> R.Case ("Kpro",
        (* pattern procedure *) token env tok
      )
    | `Kfun tok -> R.Case ("Kfun",
        (* pattern function *) token env tok
      )
    | `Kcon tok -> R.Case ("Kcon",
        (* pattern constructor *) token env tok
      )
    | `Kdes tok -> R.Case ("Kdes",
        (* pattern destructor *) token env tok
      )
    )
  in
  let v4 = map_genericname env v4 in
  let v5 =
    (match v5 with
    | Some x -> R.Option (Some (
        map_declargs env x
      ))
    | None -> R.Option None)
  in
  let v6 =
    (match v6 with
    | Some (v1, v2) -> R.Option (Some (
        let v1 = (* ":" *) token env v1 in
        let v2 = map_typeref env v2 in
        R.Tuple [v1; v2]
      ))
    | None -> R.Option None)
  in
  let v7 =
    (match v7 with
    | Some x -> R.Option (Some (
        map_anon_choice_kstd_a801c0a env x
      ))
    | None -> R.Option None)
  in
  let v8 =
    (match v8 with
    | Some x -> R.Option (Some (
        map_defaultvalue env x
      ))
    | None -> R.Option None)
  in
  let v9 = (* ";" *) token env v9 in
  let v10 =
    R.List (List.map (map_procattributenoext env) v10)
  in
  R.Tuple [v1; v2; v3; v4; v5; v6; v7; v8; v9; v10]

and map_declprocfwd (env : env) ((v1, v2, v3) : CST.declprocfwd) =
  let v1 = map_declproc_ env v1 in
  let v2 =
    (match v2 with
    | `Kfor_SEMI (v1, v2) -> R.Case ("Kfor_SEMI",
        let v1 = (* pattern forward *) token env v1 in
        let v2 = (* ";" *) token env v2 in
        R.Tuple [v1; v2]
      )
    | `Proc x -> R.Case ("Proc",
        map_procexternal env x
      )
    )
  in
  let v3 = R.List (List.map (map_procattribute env) v3) in
  R.Tuple [v1; v2; v3]

and map_declprop (env : env) ((v1, v2, v3, v4, v5, v6, v7, v8, v9) : CST.declprop) =
  let v1 =
    (match v1 with
    | Some x -> R.Option (Some (
        map_rttiattributes env x
      ))
    | None -> R.Option None)
  in
  let v2 =
    (match v2 with
    | Some tok -> R.Option (Some (
        (* pattern class *) token env tok
      ))
    | None -> R.Option None)
  in
  let v3 = (* pattern property *) token env v3 in
  let v4 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v4
  in
  let v5 =
    (match v5 with
    | Some x -> R.Option (Some (
        map_declpropargs env x
      ))
    | None -> R.Option None)
  in
  let v6 =
    (match v6 with
    | Some (v1, v2) -> R.Option (Some (
        let v1 = (* ":" *) token env v1 in
        let v2 = map_type_ env v2 in
        R.Tuple [v1; v2]
      ))
    | None -> R.Option None)
  in
  let v7 =
    R.List (List.map (fun x ->
      (match x with
      | `Kindex_expr (v1, v2) -> R.Case ("Kindex_expr",
          let v1 = (* pattern index *) token env v1 in
          let v2 = map_expr env v2 in
          R.Tuple [v1; v2]
        )
      | `Kdis_expr (v1, v2) -> R.Case ("Kdis_expr",
          let v1 = (* pattern dispid *) token env v1 in
          let v2 = map_expr env v2 in
          R.Tuple [v1; v2]
        )
      | `Kread_prop (v1, v2) -> R.Case ("Kread_prop",
          let v1 = (* pattern read *) token env v1 in
          let v2 = map_propaccessor env v2 in
          R.Tuple [v1; v2]
        )
      | `Kwrite_prop (v1, v2) -> R.Case ("Kwrite_prop",
          let v1 = (* pattern write *) token env v1 in
          let v2 = map_propaccessor env v2 in
          R.Tuple [v1; v2]
        )
      | `Kimpls_rep_expr_COMMA_expr (v1, v2, v3) -> R.Case ("Kimpls_rep_expr_COMMA_expr",
          let v1 = (* pattern implements *) token env v1 in
          let v2 =
            R.List (List.map (fun (v1, v2) ->
              let v1 = map_expr env v1 in
              let v2 = (* "," *) token env v2 in
              R.Tuple [v1; v2]
            ) v2)
          in
          let v3 = map_expr env v3 in
          R.Tuple [v1; v2; v3]
        )
      | `Kdef_expr (v1, v2) -> R.Case ("Kdef_expr",
          let v1 = (* pattern default *) token env v1 in
          let v2 = map_expr env v2 in
          R.Tuple [v1; v2]
        )
      | `Ksto_expr (v1, v2) -> R.Case ("Ksto_expr",
          let v1 = (* pattern stored *) token env v1 in
          let v2 = map_expr env v2 in
          R.Tuple [v1; v2]
        )
      | `Knod tok -> R.Case ("Knod",
          (* pattern nodefault *) token env tok
        )
      | `Krea tok -> R.Case ("Krea",
          (* pattern readonly *) token env tok
        )
      | `Kwri tok -> R.Case ("Kwri",
          (* pattern writeonly *) token env tok
        )
      )
    ) v7)
  in
  let v8 = (* ";" *) token env v8 in
  let v9 = R.List (List.map (map_procattribute env) v9) in
  R.Tuple [v1; v2; v3; v4; v5; v6; v7; v8; v9]

and map_declpropargs (env : env) ((v1, v2, v3) : CST.declpropargs) =
  let v1 = (* "[" *) token env v1 in
  let v2 =
    (match v2 with
    | Some (v1, v2) -> R.Option (Some (
        let v1 = map_anon_opt_rep1_decl_SEMI_bce1ef3 env v1 in
        let v2 = map_declarg env v2 in
        R.Tuple [v1; v2]
      ))
    | None -> R.Option None)
  in
  let v3 = (* "]" *) token env v3 in
  R.Tuple [v1; v2; v3]

and map_declsection (env : env) ((v1, v2, v3, v4) : CST.declsection) =
  let v1 =
    (match v1 with
    | Some tok -> R.Option (Some (
        (* pattern strict *) token env tok
      ))
    | None -> R.Option None)
  in
  let v2 = map_anon_choice_visi_5a3c750 env v2 in
  let v3 =
    (match v3 with
    | Some x -> R.Option (Some (
        map_declfields env x
      ))
    | None -> R.Option None)
  in
  let v4 =
    (match v4 with
    | Some x -> R.Option (Some (
        map_classdeclarations env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2; v3; v4]

and map_decltype (env : env) ((v1, v2, v3, v4, v5, v6, v7) : CST.decltype) =
  let v1 =
    (match v1 with
    | Some x -> R.Option (Some (
        map_rttiattributes env x
      ))
    | None -> R.Option None)
  in
  let v2 =
    (match v2 with
    | Some tok -> R.Option (Some (
        (* pattern generic *) token env tok
      ))
    | None -> R.Option None)
  in
  let v3 = map_genericname env v3 in
  let v4 = (* "=" *) token env v4 in
  let v5 =
    (match v5 with
    | `Opt_ktype_type (v1, v2) -> R.Case ("Opt_ktype_type",
        let v1 =
          (match v1 with
          | Some tok -> R.Option (Some (
              (* pattern type *) token env tok
            ))
          | None -> R.Option None)
        in
        let v2 = map_type_ env v2 in
        R.Tuple [v1; v2]
      )
    | `Choice_type x -> R.Case ("Choice_type",
        (match x with
        | `Type x -> R.Case ("Type",
            map_type_ env x
          )
        )
      )
    | `Decl_7f52a4c x -> R.Case ("Decl_7f52a4c",
        map_declclass env x
      )
    | `Decl_acc2c34 x -> R.Case ("Decl_acc2c34",
        map_declintf env x
      )
    | `Decl_11ac719 x -> R.Case ("Decl_11ac719",
        map_declhelper env x
      )
    )
  in
  let v6 = (* ";" *) token env v6 in
  let v7 = R.List (List.map (map_procattribute env) v7) in
  R.Tuple [v1; v2; v3; v4; v5; v6; v7]

and map_decltypes (env : env) ((v1, v2) : CST.decltypes) =
  let v1 = (* pattern type *) token env v1 in
  let v2 =
    R.List (List.map (fun x ->
      (match x with
      | `Decl x -> R.Case ("Decl",
          map_decltype env x
        )
      | `Ppbl x -> R.Case ("Ppbl",
          map_ppblock env x
        )
      | `Semg_ellips tok -> R.Case ("Semg_ellips",
          (* "..." *) token env tok
        )
      )
    ) v2)
  in
  R.Tuple [v1; v2]

and map_declvar (env : env) ((v1, v2, v3, v4, v5, v6, v7, v8) : CST.declvar) =
  let v1 =
    (match v1 with
    | Some x -> R.Option (Some (
        map_rttiattributes env x
      ))
    | None -> R.Option None)
  in
  let v2 = map_anon_opt_rep1_decl_COMMA_64c033f env v2 in
  let v3 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v3
  in
  let v4 = (* ":" *) token env v4 in
  let v5 = map_type_ env v5 in
  let v6 =
    (match v6 with
    | Some x -> R.Option (Some (
        (match x with
        | `Kabs_ref (v1, v2) -> R.Case ("Kabs_ref",
            let v1 = (* pattern absolute *) token env v1 in
            let v2 = map_ref env v2 in
            R.Tuple [v1; v2]
          )
        | `Defa x -> R.Case ("Defa",
            map_defaultvalue env x
          )
        )
      ))
    | None -> R.Option None)
  in
  let v7 = (* ";" *) token env v7 in
  let v8 =
    R.List (List.map (fun x ->
      (match x with
      | `Proc_7cf9cd2 x -> R.Case ("Proc_7cf9cd2",
          map_procattribute env x
        )
      | `Proc_8049b7e x -> R.Case ("Proc_8049b7e",
          map_procexternal env x
        )
      )
    ) v8)
  in
  R.Tuple [v1; v2; v3; v4; v5; v6; v7; v8]

and map_declvariant (env : env) ((v1, v2, v3, v4, v5, v6, v7) : CST.declvariant) =
  let v1 = (* pattern case *) token env v1 in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_label env x
      ))
    | None -> R.Option None)
  in
  let v3 = map_typeref env v3 in
  let v4 = (* pattern of *) token env v4 in
  let v5 =
    (match v5 with
    | Some xs -> R.Option (Some (
        R.List (List.map (fun (v1, v2) ->
          let v1 = map_declvariantclause env v1 in
          let v2 = (* ";" *) token env v2 in
          R.Tuple [v1; v2]
        ) xs)
      ))
    | None -> R.Option None)
  in
  let v6 = map_declvariantclause env v6 in
  let v7 =
    (match v7 with
    | Some tok -> R.Option (Some (
        (* ";" *) token env tok
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2; v3; v4; v5; v6; v7]

and map_declvariantclause (env : env) ((v1, v2, v3, v4, v5) : CST.declvariantclause) =
  let v1 = map_caselabel env v1 in
  let v2 = (* "(" *) token env v2 in
  let v3 =
    (match v3 with
    | `Opt_opt_rep1_decl_SEMI_decl_opt_SEMI_decl (v1, v2) -> R.Case ("Opt_opt_rep1_decl_SEMI_decl_opt_SEMI_decl",
        let v1 =
          (match v1 with
          | Some (v1, v2) -> R.Option (Some (
              let v1 =
                (match v1 with
                | Some xs -> R.Option (Some (
                    R.List (List.map (fun (v1, v2) ->
                      let v1 = map_declvariantfield env v1 in
                      let v2 = (* ";" *) token env v2 in
                      R.Tuple [v1; v2]
                    ) xs)
                  ))
                | None -> R.Option None)
              in
              let v2 = map_declvariantfield env v2 in
              R.Tuple [v1; v2]
            ))
          | None -> R.Option None)
        in
        let v2 =
          (match v2 with
          | Some (v1, v2) -> R.Option (Some (
              let v1 = (* ";" *) token env v1 in
              let v2 = map_declvariant env v2 in
              R.Tuple [v1; v2]
            ))
          | None -> R.Option None)
        in
        R.Tuple [v1; v2]
      )
    | `Decl v1 -> R.Case ("Decl",
        map_declvariant env v1
      )
    )
  in
  let v4 =
    (match v4 with
    | Some tok -> R.Option (Some (
        (* ";" *) token env tok
      ))
    | None -> R.Option None)
  in
  let v5 = (* ")" *) token env v5 in
  R.Tuple [v1; v2; v3; v4; v5]

and map_declvariantfield (env : env) ((v1, v2, v3, v4, v5) : CST.declvariantfield) =
  let v1 = map_anon_opt_rep1_decl_COMMA_64c033f env v1 in
  let v2 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v2
  in
  let v3 = (* ":" *) token env v3 in
  let v4 = map_type_ env v4 in
  let v5 =
    (match v5 with
    | Some x -> R.Option (Some (
        map_defaultvalue env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2; v3; v4; v5]

and map_declvars (env : env) ((v1, v2, v3) : CST.declvars) =
  let v1 =
    (match v1 with
    | Some tok -> R.Option (Some (
        (* pattern class *) token env tok
      ))
    | None -> R.Option None)
  in
  let v2 =
    (match v2 with
    | `Kvar tok -> R.Case ("Kvar",
        (* pattern var *) token env tok
      )
    | `Kthr tok -> R.Case ("Kthr",
        (* pattern threadvar *) token env tok
      )
    )
  in
  let v3 =
    R.List (List.map (fun x ->
      (match x with
      | `Decl x -> R.Case ("Decl",
          map_declvar env x
        )
      | `Ppbl x -> R.Case ("Ppbl",
          map_ppblock env x
        )
      | `Semg_ellips tok -> R.Case ("Semg_ellips",
          (* "..." *) token env tok
        )
      )
    ) v3)
  in
  R.Tuple [v1; v2; v3]

and map_defaultvalue (env : env) ((v1, v2) : CST.defaultvalue) =
  let v1 = (* "=" *) token env v1 in
  let v2 = map_initializer_ env v2 in
  R.Tuple [v1; v2]

and map_definition (env : env) (x : CST.definition) =
  (match x with
  | `Declts x -> R.Case ("Declts",
      map_decltypes env x
    )
  | `Declvs x -> R.Case ("Declvs",
      map_declvars env x
    )
  | `Declcs x -> R.Case ("Declcs",
      map_declconsts env x
    )
  | `Defp x -> R.Case ("Defp",
      map_defproc env x
    )
  | `Decl x -> R.Case ("Decl",
      map_declprocfwd env x
    )
  | `Declls x -> R.Case ("Declls",
      map_decllabels env x
    )
  | `Declus x -> R.Case ("Declus",
      map_decluses env x
    )
  | `Decles x -> R.Case ("Decles",
      map_declexports env x
    )
  | `Ppbl x -> R.Case ("Ppbl",
      map_ppblock env x
    )
  | `Bloc x -> R.Case ("Bloc",
      map_blocktr env x
    )
  | `Semg_ellips tok -> R.Case ("Semg_ellips",
      (* "..." *) token env tok
    )
  )

and map_definitions (env : env) (xs : CST.definitions) =
  R.List (List.map (map_definition env) xs)

and map_defproc (env : env) ((v1, v2) : CST.defproc) =
  let v1 = map_declproc env v1 in
  let v2 =
    (match v2 with
    | `Opt_defins_choice_bloc_SEMI (v1, v2, v3) -> R.Case ("Opt_defins_choice_bloc_SEMI",
        let v1 =
          (match v1 with
          | Some x -> R.Option (Some (
              map_definitions env x
            ))
          | None -> R.Option None)
        in
        let v2 = map_anon_choice_bloc_1cb9769 env v2 in
        let v3 = (* ";" *) token env v3 in
        R.Tuple [v1; v2; v3]
      )
    | `Tok_prec_p5_pat_6f93d17_opt_defins_choice_bloc_SEMI_rep_tok_prec_p5_pat_b66c674_opt_defins_choice_bloc_SEMI_tok_prec_p5_pat_9f5699f (v1, v2, v3, v4, v5, v6) -> R.Case ("Tok_prec_p5_pat_6f93d17_opt_defins_choice_bloc_SEMI_rep_tok_prec_p5_pat_b66c674_opt_defins_choice_bloc_SEMI_tok_prec_p5_pat_9f5699f",
        let v1 = map_tok_prec_p5_pat_6f93d17 env v1 in
        let v2 =
          (match v2 with
          | Some x -> R.Option (Some (
              map_definitions env x
            ))
          | None -> R.Option None)
        in
        let v3 = map_anon_choice_bloc_1cb9769 env v3 in
        let v4 = (* ";" *) token env v4 in
        let v5 =
          R.List (List.map (fun (v1, v2, v3, v4) ->
            let v1 = map_tok_prec_p5_pat_b66c674 env v1 in
            let v2 =
              (match v2 with
              | Some x -> R.Option (Some (
                  map_definitions env x
                ))
              | None -> R.Option None)
            in
            let v3 = map_anon_choice_bloc_1cb9769 env v3 in
            let v4 = (* ";" *) token env v4 in
            R.Tuple [v1; v2; v3; v4]
          ) v5)
        in
        let v6 = map_tok_prec_p5_pat_9f5699f env v6 in
        R.Tuple [v1; v2; v3; v4; v5; v6]
      )
    )
  in
  R.Tuple [v1; v2]

and map_exceptionelse (env : env) ((v1, v2, v3) : CST.exceptionelse) =
  let v1 = (* pattern else *) token env v1 in
  let v2 = R.List (List.map (map_statement env) v2) in
  let v3 = map_statement env v3 in
  R.Tuple [v1; v2; v3]

and map_exceptionhandler (env : env) ((v1, v2, v3, v4, v5) : CST.exceptionhandler) =
  let v1 = (* pattern on *) token env v1 in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_label env x
      ))
    | None -> R.Option None)
  in
  let v3 = map_typeref env v3 in
  let v4 = (* pattern do *) token env v4 in
  let v5 = map_statement env v5 in
  R.Tuple [v1; v2; v3; v4; v5]

and map_expr (env : env) (x : CST.expr) =
  (match x with
  | `Ref x -> R.Case ("Ref",
      map_ref env x
    )
  | `Expr_ef29a06 x -> R.Case ("Expr_ef29a06",
      map_exprbinary env x
    )
  | `Expr_5c4be6d x -> R.Case ("Expr_5c4be6d",
      map_exprunary env x
    )
  | `Expr_3037366 (v1, v2, v3, v4, v5, v6) -> R.Case ("Expr_3037366",
      let v1 = (* pattern if *) token env v1 in
      let v2 = map_expr env v2 in
      let v3 = (* pattern then *) token env v3 in
      let v4 = map_expr env v4 in
      let v5 = (* pattern else *) token env v5 in
      let v6 = map_expr env v6 in
      R.Tuple [v1; v2; v3; v4; v5; v6]
    )
  )

and map_exprargs (env : env) ((v1, v2, v3) : CST.exprargs) =
  let v1 =
    (match v1 with
    | Some xs -> R.Option (Some (
        R.List (List.map (fun (v1, v2, v3) ->
          let v1 = map_expr env v1 in
          let v2 =
            (match v2 with
            | Some x -> R.Option (Some (
                map_legacyformat env x
              ))
            | None -> R.Option None)
          in
          let v3 = (* "," *) token env v3 in
          R.Tuple [v1; v2; v3]
        ) xs)
      ))
    | None -> R.Option None)
  in
  let v2 = map_expr env v2 in
  let v3 =
    (match v3 with
    | Some x -> R.Option (Some (
        map_legacyformat env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2; v3]

and map_exprbinary (env : env) (x : CST.exprbinary) =
  (match x with
  | `Expr_klt_expr (v1, v2, v3) -> R.Case ("Expr_klt_expr",
      let v1 = map_expr env v1 in
      let v2 = (* "<" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Ref_klt_expr (v1, v2, v3) -> R.Case ("Ref_klt_expr",
      let v1 = map_ref env v1 in
      let v2 = (* "<" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_keq_expr (v1, v2, v3) -> R.Case ("Expr_keq_expr",
      let v1 = map_expr env v1 in
      let v2 = (* "=" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kneq_expr (v1, v2, v3) -> R.Case ("Expr_kneq_expr",
      let v1 = map_expr env v1 in
      let v2 = (* "<>" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kgt_expr (v1, v2, v3) -> R.Case ("Expr_kgt_expr",
      let v1 = map_expr env v1 in
      let v2 = (* ">" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_klte_expr (v1, v2, v3) -> R.Case ("Expr_klte_expr",
      let v1 = map_expr env v1 in
      let v2 = (* "<=" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kgte_expr (v1, v2, v3) -> R.Case ("Expr_kgte_expr",
      let v1 = map_expr env v1 in
      let v2 = (* ">=" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kin_expr (v1, v2, v3) -> R.Case ("Expr_kin_expr",
      let v1 = map_expr env v1 in
      let v2 = (* pattern in *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kis_expr (v1, v2, v3) -> R.Case ("Expr_kis_expr",
      let v1 = map_expr env v1 in
      let v2 = (* pattern is *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_knot_kin_expr (v1, v2, v3, v4) -> R.Case ("Expr_knot_kin_expr",
      let v1 = map_expr env v1 in
      let v2 = (* pattern not *) token env v2 in
      let v3 = (* pattern in *) token env v3 in
      let v4 = map_expr env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Expr_expr_expr (v1, v2, v3) -> R.Case ("Expr_expr_expr",
      let v1 = map_expr env v1 in
      let v2 = map_exprisnot env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kadd_expr (v1, v2, v3) -> R.Case ("Expr_kadd_expr",
      let v1 = map_expr env v1 in
      let v2 = (* "+" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_ksub_expr (v1, v2, v3) -> R.Case ("Expr_ksub_expr",
      let v1 = map_expr env v1 in
      let v2 = (* "-" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kor_expr (v1, v2, v3) -> R.Case ("Expr_kor_expr",
      let v1 = map_expr env v1 in
      let v2 = (* pattern or *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kxor_expr (v1, v2, v3) -> R.Case ("Expr_kxor_expr",
      let v1 = map_expr env v1 in
      let v2 = (* pattern xor *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kmul_expr (v1, v2, v3) -> R.Case ("Expr_kmul_expr",
      let v1 = map_expr env v1 in
      let v2 = (* "*" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kfdiv_expr (v1, v2, v3) -> R.Case ("Expr_kfdiv_expr",
      let v1 = map_expr env v1 in
      let v2 = (* "/" *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kdiv_expr (v1, v2, v3) -> R.Case ("Expr_kdiv_expr",
      let v1 = map_expr env v1 in
      let v2 = (* pattern div *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kmod_expr (v1, v2, v3) -> R.Case ("Expr_kmod_expr",
      let v1 = map_expr env v1 in
      let v2 = (* pattern mod *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kand_expr (v1, v2, v3) -> R.Case ("Expr_kand_expr",
      let v1 = map_expr env v1 in
      let v2 = (* pattern and *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kshl_expr (v1, v2, v3) -> R.Case ("Expr_kshl_expr",
      let v1 = map_expr env v1 in
      let v2 = (* pattern shl *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_kshr_expr (v1, v2, v3) -> R.Case ("Expr_kshr_expr",
      let v1 = map_expr env v1 in
      let v2 = (* pattern shr *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  )

and map_exprunary (env : env) (x : CST.exprunary) =
  (match x with
  | `Knot_expr (v1, v2) -> R.Case ("Knot_expr",
      let v1 = (* pattern not *) token env v1 in
      let v2 = map_expr env v2 in
      R.Tuple [v1; v2]
    )
  | `Kadd_expr (v1, v2) -> R.Case ("Kadd_expr",
      let v1 = (* "+" *) token env v1 in
      let v2 = map_expr env v2 in
      R.Tuple [v1; v2]
    )
  | `Ksub_expr (v1, v2) -> R.Case ("Ksub_expr",
      let v1 = (* "-" *) token env v1 in
      let v2 = map_expr env v2 in
      R.Tuple [v1; v2]
    )
  | `Kat_expr (v1, v2) -> R.Case ("Kat_expr",
      let v1 = (* "@" *) token env v1 in
      let v2 = map_expr env v2 in
      R.Tuple [v1; v2]
    )
  )

and map_genericarg (env : env) ((v1, v2, v3, v4) : CST.genericarg) =
  let v1 = map_anon_opt_rep1_decl_COMMA_64c033f env v1 in
  let v2 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v2
  in
  let v3 =
    (match v3 with
    | Some (v1, v2) -> R.Option (Some (
        let v1 = (* ":" *) token env v1 in
        let v2 = map_typeref env v2 in
        R.Tuple [v1; v2]
      ))
    | None -> R.Option None)
  in
  let v4 =
    (match v4 with
    | Some x -> R.Option (Some (
        map_defaultvalue env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2; v3; v4]

and map_genericargs (env : env) ((v1, v2) : CST.genericargs) =
  let v1 =
    (match v1 with
    | Some xs -> R.Option (Some (
        R.List (List.map (fun (v1, v2) ->
          let v1 = map_genericarg env v1 in
          let v2 = (* ";" *) token env v2 in
          R.Tuple [v1; v2]
        ) xs)
      ))
    | None -> R.Option None)
  in
  let v2 = map_genericarg env v2 in
  R.Tuple [v1; v2]

and map_genericname (env : env) (x : CST.genericname) =
  (match x with
  | `Id tok -> R.Case ("Id",
      (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env tok
    )
  | `Gene_067353e (v1, v2, v3) -> R.Case ("Gene_067353e",
      let v1 = map_genericname env v1 in
      let v2 = (* "." *) token env v2 in
      let v3 = map_genericname env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Gene_4088af4 (v1, v2, v3, v4) -> R.Case ("Gene_4088af4",
      let v1 = map_genericname env v1 in
      let v2 = (* "<" *) token env v2 in
      let v3 = map_genericargs env v3 in
      let v4 = (* ">" *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  )

and map_guid (env : env) ((v1, v2, v3) : CST.guid) =
  let v1 = (* "[" *) token env v1 in
  let v2 = map_ref env v2 in
  let v3 = (* "]" *) token env v3 in
  R.Tuple [v1; v2; v3]

and map_if_ (env : env) ((v1, v2, v3, v4) : CST.if_) =
  let v1 = (* pattern if *) token env v1 in
  let v2 = map_expr env v2 in
  let v3 = (* pattern then *) token env v3 in
  let v4 = map_statement env v4 in
  R.Tuple [v1; v2; v3; v4]

and map_initializer_ (env : env) (v1 : CST.initializer_) =
  (match v1 with
  | `Expr x -> R.Case ("Expr",
      map_expr env x
    )
  | `Reci x -> R.Case ("Reci",
      map_recinitializer env x
    )
  | `Arri x -> R.Case ("Arri",
      map_arrinitializer env x
    )
  )

and map_legacyformat (env : env) (xs : CST.legacyformat) =
  R.List (List.map (fun (v1, v2) ->
    let v1 = (* ":" *) token env v1 in
    let v2 = map_expr env v2 in
    R.Tuple [v1; v2]
  ) xs)

and map_nestediftr (env : env) (x : CST.nestediftr) =
  map_if_ env x

and map_operatordot (env : env) ((v1, v2, v3) : CST.operatordot) =
  let v1 = map_genericname env v1 in
  let v2 = (* "." *) token env v2 in
  let v3 = map_operatorname_ env v3 in
  R.Tuple [v1; v2; v3]

and map_operatorname (env : env) (v1 : CST.operatorname) =
  (match v1 with
  | `Gene x -> R.Case ("Gene",
      map_genericname env x
    )
  | `Oper_ x -> R.Case ("Oper_",
      map_operatorname_ env x
    )
  | `Oper x -> R.Case ("Oper",
      map_operatordot env x
    )
  )

and map_ppblock (env : env) ((v1, v2, v3, v4) : CST.ppblock) =
  let v1 = (* ppif *) token env v1 in
  let v2 =
    R.List (List.map (map_anon_choice_decl_fe4bcc4 env) v2)
  in
  let v3 =
    R.List (List.map (fun (v1, v2) ->
      let v1 = (* ppelse *) token env v1 in
      let v2 =
        R.List (List.map (map_anon_choice_decl_fe4bcc4 env) v2)
      in
      R.Tuple [v1; v2]
    ) v3)
  in
  let v4 = (* ppendif *) token env v4 in
  R.Tuple [v1; v2; v3; v4]

and map_ppdeclsection (env : env) ((v1, v2, v3, v4, v5, v6) : CST.ppdeclsection) =
  let v1 = (* ppif *) token env v1 in
  let v2 =
    (match v2 with
    | Some tok -> R.Option (Some (
        (* pattern strict *) token env tok
      ))
    | None -> R.Option None)
  in
  let v3 = map_anon_choice_visi_5a3c750 env v3 in
  let v4 = (* ppendif *) token env v4 in
  let v5 =
    (match v5 with
    | Some x -> R.Option (Some (
        map_declfields env x
      ))
    | None -> R.Option None)
  in
  let v6 =
    (match v6 with
    | Some x -> R.Option (Some (
        map_classdeclarations env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2; v3; v4; v5; v6]

and map_procattribute (env : env) (x : CST.procattribute) =
  (match x with
  | `Proc__SEMI (v1, v2) -> R.Case ("Proc__SEMI",
      let v1 = map_procattribute_ env v1 in
      let v2 = (* ";" *) token env v2 in
      R.Tuple [v1; v2]
    )
  | `LBRACK_opt_opt_rep1_choice_proc__COMMA_choice_proc__RBRACK_SEMI (v1, v2, v3, v4) -> R.Case ("LBRACK_opt_opt_rep1_choice_proc__COMMA_choice_proc__RBRACK_SEMI",
      let v1 = (* "[" *) token env v1 in
      let v2 =
        (match v2 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 =
              (match v1 with
              | Some xs -> R.Option (Some (
                  R.List (List.map (fun (v1, v2) ->
                    let v1 = map_anon_choice_proc__b0bc660 env v1 in
                    let v2 = (* "," *) token env v2 in
                    R.Tuple [v1; v2]
                  ) xs)
                ))
              | None -> R.Option None)
            in
            let v2 = map_anon_choice_proc__b0bc660 env v2 in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      let v3 = (* "]" *) token env v3 in
      let v4 = (* ";" *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  )

and map_procattribute_ (env : env) (x : CST.procattribute_) =
  (match x with
  | `Ksta tok -> R.Case ("Ksta",
      (* pattern static *) token env tok
    )
  | `Kvir tok -> R.Case ("Kvir",
      (* pattern virtual *) token env tok
    )
  | `Kdyn tok -> R.Case ("Kdyn",
      (* pattern dynamic *) token env tok
    )
  | `Kabs tok -> R.Case ("Kabs",
      (* pattern abstract *) token env tok
    )
  | `Kove_98086b9 tok -> R.Case ("Kove_98086b9",
      (* pattern override *) token env tok
    )
  | `Kove_a43f97e tok -> R.Case ("Kove_a43f97e",
      (* pattern overload *) token env tok
    )
  | `Krei tok -> R.Case ("Krei",
      (* pattern reintroduce *) token env tok
    )
  | `Kinl tok -> R.Case ("Kinl",
      (* pattern inline *) token env tok
    )
  | `Kstd tok -> R.Case ("Kstd",
      (* pattern stdcall *) token env tok
    )
  | `Kcdecl tok -> R.Case ("Kcdecl",
      (* pattern cdecl *) token env tok
    )
  | `Kpas tok -> R.Case ("Kpas",
      (* pattern pascal *) token env tok
    )
  | `Kreg tok -> R.Case ("Kreg",
      (* pattern register *) token env tok
    )
  | `Ksaf tok -> R.Case ("Ksaf",
      (* pattern safecall *) token env tok
    )
  | `Kass tok -> R.Case ("Kass",
      (* pattern assembler *) token env tok
    )
  | `Knor tok -> R.Case ("Knor",
      (* pattern noreturn *) token env tok
    )
  | `Klocal tok -> R.Case ("Klocal",
      (* pattern local *) token env tok
    )
  | `Kfar tok -> R.Case ("Kfar",
      (* pattern far *) token env tok
    )
  | `Knear tok -> R.Case ("Knear",
      (* pattern near *) token env tok
    )
  | `Kdef tok -> R.Case ("Kdef",
      (* pattern default *) token env tok
    )
  | `Knod tok -> R.Case ("Knod",
      (* pattern nodefault *) token env tok
    )
  | `Kdep tok -> R.Case ("Kdep",
      (* pattern deprecated *) token env tok
    )
  | `Kexp tok -> R.Case ("Kexp",
      (* pattern experimental *) token env tok
    )
  | `Choice_kmes_opt_kname_expr (v1, v2) -> R.Case ("Choice_kmes_opt_kname_expr",
      let v1 =
        (match v1 with
        | `Kmes_opt_kname (v1, v2) -> R.Case ("Kmes_opt_kname",
            let v1 = (* pattern message *) token env v1 in
            let v2 =
              (match v2 with
              | Some tok -> R.Option (Some (
                  (* pattern name *) token env tok
                ))
              | None -> R.Option None)
            in
            R.Tuple [v1; v2]
          )
        | `Kdep tok -> R.Case ("Kdep",
            (* pattern deprecated *) token env tok
          )
        )
      in
      let v2 = map_expr env v2 in
      R.Tuple [v1; v2]
    )
  | `Kpla tok -> R.Case ("Kpla",
      (* pattern platform *) token env tok
    )
  | `Kuni tok -> R.Case ("Kuni",
      (* pattern unimplemented *) token env tok
    )
  | `Kcpp tok -> R.Case ("Kcpp",
      (* pattern cppdecl *) token env tok
    )
  | `Kcvar tok -> R.Case ("Kcvar",
      (* pattern cvar *) token env tok
    )
  | `Kmwp tok -> R.Case ("Kmwp",
      (* pattern mwpascal *) token env tok
    )
  | `Knos tok -> R.Case ("Knos",
      (* pattern nostackframe *) token env tok
    )
  | `Kint tok -> R.Case ("Kint",
      (* pattern interrupt *) token env tok
    )
  | `Kioc tok -> R.Case ("Kioc",
      (* pattern iocheck *) token env tok
    )
  | `Khar tok -> R.Case ("Khar",
      (* pattern hardfloat *) token env tok
    )
  | `Ksof tok -> R.Case ("Ksof",
      (* pattern softfloat *) token env tok
    )
  | `Kms_abi_defa tok -> R.Case ("Kms_abi_defa",
      (* pattern ms_abi_default *) token env tok
    )
  | `Kms_abi_cdecl tok -> R.Case ("Kms_abi_cdecl",
      (* pattern ms_abi_cdecl *) token env tok
    )
  | `Ksaves tok -> R.Case ("Ksaves",
      (* pattern saveregisters *) token env tok
    )
  | `Ksysv_abi_defa tok -> R.Case ("Ksysv_abi_defa",
      (* pattern sysv_abi_default *) token env tok
    )
  | `Ksysv_abi_cdecl tok -> R.Case ("Ksysv_abi_cdecl",
      (* pattern sysv_abi_cdecl *) token env tok
    )
  | `Kvec tok -> R.Case ("Kvec",
      (* pattern vectorcall *) token env tok
    )
  | `Kvaras tok -> R.Case ("Kvaras",
      (* pattern varargs *) token env tok
    )
  | `Kwin tok -> R.Case ("Kwin",
      (* pattern winapi *) token env tok
    )
  | `Kpub tok -> R.Case ("Kpub",
      (* pattern public *) token env tok
    )
  | `Choice_kexp_expr (v1, v2) -> R.Case ("Choice_kexp_expr",
      let v1 =
        (match v1 with
        | `Kexp tok -> R.Case ("Kexp",
            (* pattern export *) token env tok
          )
        | `Kalias_COLON (v1, v2) -> R.Case ("Kalias_COLON",
            let v1 = (* pattern alias *) token env v1 in
            let v2 = (* ":" *) token env v2 in
            R.Tuple [v1; v2]
          )
        | `Kpub_kname (v1, v2) -> R.Case ("Kpub_kname",
            let v1 = (* pattern public *) token env v1 in
            let v2 = (* pattern name *) token env v2 in
            R.Tuple [v1; v2]
          )
        )
      in
      let v2 = map_expr env v2 in
      R.Tuple [v1; v2]
    )
  | `Kdis_expr (v1, v2) -> R.Case ("Kdis_expr",
      let v1 = (* pattern dispid *) token env v1 in
      let v2 = map_expr env v2 in
      R.Tuple [v1; v2]
    )
  )

and map_procattributenoext (env : env) (x : CST.procattributenoext) =
  (match x with
  | `Choice_proc__SEMI (v1, v2) -> R.Case ("Choice_proc__SEMI",
      let v1 =
        (match v1 with
        | `Proc_ x -> R.Case ("Proc_",
            map_procattribute_ env x
          )
        | `Ppif_proc__rep_ppelse_proc__ppen (v1, v2, v3, v4) -> R.Case ("Ppif_proc__rep_ppelse_proc__ppen",
            let v1 = (* ppif *) token env v1 in
            let v2 = map_procattribute_ env v2 in
            let v3 =
              R.List (List.map (fun (v1, v2) ->
                let v1 = (* ppelse *) token env v1 in
                let v2 = map_procattribute_ env v2 in
                R.Tuple [v1; v2]
              ) v3)
            in
            let v4 = (* ppendif *) token env v4 in
            R.Tuple [v1; v2; v3; v4]
          )
        )
      in
      let v2 = (* ";" *) token env v2 in
      R.Tuple [v1; v2]
    )
  | `LBRACK_opt_opt_rep1_choice_proc__SEMI_choice_proc__RBRACK_SEMI (v1, v2, v3, v4) -> R.Case ("LBRACK_opt_opt_rep1_choice_proc__SEMI_choice_proc__RBRACK_SEMI",
      let v1 = (* "[" *) token env v1 in
      let v2 =
        (match v2 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 =
              (match v1 with
              | Some xs -> R.Option (Some (
                  R.List (List.map (fun (v1, v2) ->
                    let v1 =
                      (match v1 with
                      | `Proc_ x -> R.Case ("Proc_",
                          map_procattribute_ env x
                        )
                      )
                    in
                    let v2 = (* ";" *) token env v2 in
                    R.Tuple [v1; v2]
                  ) xs)
                ))
              | None -> R.Option None)
            in
            let v2 =
              (match v2 with
              | `Proc_ x -> R.Case ("Proc_",
                  map_procattribute_ env x
                )
              )
            in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      let v3 = (* "]" *) token env v3 in
      let v4 = (* ";" *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  )

and map_procexternal (env : env) ((v1, v2, v3, v4, v5) : CST.procexternal) =
  let v1 = (* pattern external *) token env v1 in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_expr env x
      ))
    | None -> R.Option None)
  in
  let v3 =
    (match v3 with
    | Some (v1, v2) -> R.Option (Some (
        let v1 = map_anon_choice_kname_ba8a152 env v1 in
        let v2 = map_expr env v2 in
        R.Tuple [v1; v2]
      ))
    | None -> R.Option None)
  in
  let v4 =
    (match v4 with
    | Some tok -> R.Option (Some (
        (* pattern delayed *) token env tok
      ))
    | None -> R.Option None)
  in
  let v5 = (* ";" *) token env v5 in
  R.Tuple [v1; v2; v3; v4; v5]

and map_range (env : env) ((v1, v2, v3) : CST.range) =
  let v1 = map_expr env v1 in
  let v2 = (* ".." *) token env v2 in
  let v3 = map_expr env v3 in
  R.Tuple [v1; v2; v3]

and map_recinitializer (env : env) ((v1, v2, v3, v4, v5) : CST.recinitializer) =
  let v1 = (* "(" *) token env v1 in
  let v2 =
    R.List (List.map (fun (v1, v2) ->
      let v1 = map_recinitializerfield env v1 in
      let v2 = (* ";" *) token env v2 in
      R.Tuple [v1; v2]
    ) v2)
  in
  let v3 = map_recinitializerfield env v3 in
  let v4 =
    (match v4 with
    | Some tok -> R.Option (Some (
        (* ";" *) token env tok
      ))
    | None -> R.Option None)
  in
  let v5 = (* ")" *) token env v5 in
  R.Tuple [v1; v2; v3; v4; v5]

and map_recinitializerfield (env : env) (x : CST.recinitializerfield) =
  (match x with
  | `Id_COLON_init (v1, v2, v3) -> R.Case ("Id_COLON_init",
      let v1 =
        (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v1
      in
      let v2 = (* ":" *) token env v2 in
      let v3 = map_initializer_ env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Init x -> R.Case ("Init",
      map_initializer_ env x
    )
  )

and map_ref (env : env) (x : CST.ref) =
  (match x with
  | `Choice_kspe_id x -> R.Case ("Choice_kspe_id",
      (match x with
      | `Kspe_id (v1, v2) -> R.Case ("Kspe_id",
          let v1 = (* pattern specialize *) token env v1 in
          let v2 =
            (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v2
          in
          R.Tuple [v1; v2]
        )
      | `Kspe v1 -> R.Case ("Kspe",
          (* pattern specialize *) token env v1
        )
      )
    )
  | `Id tok -> R.Case ("Id",
      (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env tok
    )
  | `Lit x -> R.Case ("Lit",
      map_literal env x
    )
  | `Inhe (v1, v2) -> R.Case ("Inhe",
      let v1 = (* pattern inherited *) token env v1 in
      let v2 =
        (match v2 with
        | Some tok -> R.Option (Some (
            (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env tok
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2]
    )
  | `Expr_4f305a9 (v1, v2, v3) -> R.Case ("Expr_4f305a9",
      let v1 = map_ref env v1 in
      let v2 = (* "." *) token env v2 in
      let v3 = map_ref env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Exprbs (v1, v2, v3) -> R.Case ("Exprbs",
      let v1 = (* "[" *) token env v1 in
      let v2 =
        (match v2 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 =
              map_anon_opt_rep1_choice_expr_COMMA_d776c0e env v1
            in
            let v2 = map_anon_choice_expr_0b0705b env v2 in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      let v3 = (* "]" *) token env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Exprps (v1, v2, v3) -> R.Case ("Exprps",
      let v1 = (* "(" *) token env v1 in
      let v2 = map_expr env v2 in
      let v3 = (* ")" *) token env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_2b043f4 (v1, v2, v3, v4) -> R.Case ("Expr_2b043f4",
      let v1 = map_ref env v1 in
      let v2 = (* "[" *) token env v2 in
      let v3 = map_exprargs env v3 in
      let v4 = (* "]" *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Expr_31f068a (v1, v2, v3, v4) -> R.Case ("Expr_31f068a",
      let v1 = map_ref env v1 in
      let v2 = (* "(" *) token env v2 in
      let v3 =
        (match v3 with
        | Some x -> R.Option (Some (
            map_exprargs env x
          ))
        | None -> R.Option None)
      in
      let v4 = (* ")" *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Expr_abfcfa5 (v1, v2) -> R.Case ("Expr_abfcfa5",
      let v1 = map_expr env v1 in
      let v2 = (* "^" *) token env v2 in
      R.Tuple [v1; v2]
    )
  | `Expras (v1, v2, v3) -> R.Case ("Expras",
      let v1 = map_expr env v1 in
      let v2 = (* pattern as *) token env v2 in
      let v3 = map_expr env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Expr_1293f4f (v1, v2, v3, v4, v5) -> R.Case ("Expr_1293f4f",
      let v1 = map_ref env v1 in
      let v2 = (* "<" *) token env v2 in
      let v3 = map_anon_opt_rep1_type__COMMA_1201331 env v3 in
      let v4 = map_typeref_ env v4 in
      let v5 = (* ">" *) token env v5 in
      R.Tuple [v1; v2; v3; v4; v5]
    )
  | `Lambda (v1, v2, v3, v4, v5) -> R.Case ("Lambda",
      let v1 = map_anon_choice_kpro_f69e586 env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_declargs env x
          ))
        | None -> R.Option None)
      in
      let v3 =
        (match v3 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 = (* ":" *) token env v1 in
            let v2 = map_typeref env v2 in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      let v4 =
        (match v4 with
        | Some x -> R.Option (Some (
            map_definitions env x
          ))
        | None -> R.Option None)
      in
      let v5 = map_anon_choice_bloc_1cb9769 env v5 in
      R.Tuple [v1; v2; v3; v4; v5]
    )
  | `Ppfr tok -> R.Case ("Ppfr",
      (* ppfragmentexpr *) token env tok
    )
  | `Semg_ellips tok -> R.Case ("Semg_ellips",
      (* "..." *) token env tok
    )
  | `Deep_ellips (v1, v2, v3) -> R.Case ("Deep_ellips",
      let v1 = (* "<..." *) token env v1 in
      let v2 = map_expr env v2 in
      let v3 = (* "...>" *) token env v3 in
      R.Tuple [v1; v2; v3]
    )
  )

and map_rttiattributes (env : env) (xs : CST.rttiattributes) =
  R.List (List.map (fun (v1, v2, v3, v4) ->
    let v1 = (* "[" *) token env v1 in
    let v2 =
      (match v2 with
      | Some x -> R.Option (Some (
          map_label env x
        ))
      | None -> R.Option None)
    in
    let v3 =
      (match v3 with
      | Some (v1, v2) -> R.Option (Some (
          let v1 =
            (match v1 with
            | Some xs -> R.Option (Some (
                R.List (List.map (fun (v1, v2) ->
                  let v1 = map_ref env v1 in
                  let v2 = (* "," *) token env v2 in
                  R.Tuple [v1; v2]
                ) xs)
              ))
            | None -> R.Option None)
          in
          let v2 = map_ref env v2 in
          R.Tuple [v1; v2]
        ))
      | None -> R.Option None)
    in
    let v4 = (* "]" *) token env v4 in
    R.Tuple [v1; v2; v3; v4]
  ) xs)

and map_statement (env : env) (x : CST.statement) =
  (match x with
  | `SEMI tok -> R.Case ("SEMI",
      (* ";" *) token env tok
    )
  | `Assign_SEMI (v1, v2) -> R.Case ("Assign_SEMI",
      let v1 = map_assignment env v1 in
      let v2 = (* ";" *) token env v2 in
      R.Tuple [v1; v2]
    )
  | `Vardef_SEMI (v1, v2) -> R.Case ("Vardef_SEMI",
      let v1 = map_vardef env v1 in
      let v2 = (* ";" *) token env v2 in
      R.Tuple [v1; v2]
    )
  | `Stmt_ x -> R.Case ("Stmt_",
      map_statement_ env x
    )
  | `If x -> R.Case ("If",
      map_nestediftr env x
    )
  | `Ifelse (v1, v2, v3, v4, v5, v6) -> R.Case ("Ifelse",
      let v1 = (* pattern if *) token env v1 in
      let v2 = map_expr env v2 in
      let v3 = (* pattern then *) token env v3 in
      let v4 =
        (match v4 with
        | Some x -> R.Option (Some (
            map_anon_choice_stat_2a62092 env x
          ))
        | None -> R.Option None)
      in
      let v5 = (* pattern else *) token env v5 in
      let v6 = map_statement env v6 in
      R.Tuple [v1; v2; v3; v4; v5; v6]
    )
  | `While (v1, v2, v3, v4) -> R.Case ("While",
      let v1 = (* pattern while *) token env v1 in
      let v2 = map_expr env v2 in
      let v3 = (* pattern do *) token env v3 in
      let v4 = map_statement env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Repeat (v1, v2, v3, v4, v5) -> R.Case ("Repeat",
      let v1 = (* pattern repeat *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_statementstr_ env x
          ))
        | None -> R.Option None)
      in
      let v3 = (* pattern until *) token env v3 in
      let v4 = map_expr env v4 in
      let v5 = (* ";" *) token env v5 in
      R.Tuple [v1; v2; v3; v4; v5]
    )
  | `For (v1, v2, v3, v4, v5, v6) -> R.Case ("For",
      let v1 = (* pattern for *) token env v1 in
      let v2 = map_assignment env v2 in
      let v3 = map_anon_choice_kto_86c5a40 env v3 in
      let v4 = map_expr env v4 in
      let v5 = (* pattern do *) token env v5 in
      let v6 = map_statement env v6 in
      R.Tuple [v1; v2; v3; v4; v5; v6]
    )
  | `Fore (v1, v2, v3, v4, v5, v6) -> R.Case ("Fore",
      let v1 = (* pattern for *) token env v1 in
      let v2 = map_anon_choice_expr_2fa3e6e env v2 in
      let v3 = (* pattern in *) token env v3 in
      let v4 = map_expr env v4 in
      let v5 = (* pattern do *) token env v5 in
      let v6 = map_statement env v6 in
      R.Tuple [v1; v2; v3; v4; v5; v6]
    )
  | `Try (v1, v2, v3, v4, v5) -> R.Case ("Try",
      let v1 = (* pattern try *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_statementstr_ env x
          ))
        | None -> R.Option None)
      in
      let v3 =
        map_anon_choice_kexc_opt_choice_stat__d8e7a89 env v3
      in
      let v4 = (* pattern end *) token env v4 in
      let v5 = (* ";" *) token env v5 in
      R.Tuple [v1; v2; v3; v4; v5]
    )
  | `Case (v1, v2, v3, v4, v5, v6, v7, v8) -> R.Case ("Case",
      let v1 = (* pattern case *) token env v1 in
      let v2 = map_expr env v2 in
      let v3 = (* pattern of *) token env v3 in
      let v4 = R.List (List.map (map_casecase env) v4) in
      let v5 =
        (match v5 with
        | Some x -> R.Option (Some (
            map_casecasetr env x
          ))
        | None -> R.Option None)
      in
      let v6 =
        (match v6 with
        | Some x -> R.Option (Some (
            map_anon_choice_kelse_opt_COLON_opt_stat__c22ab7e env x
          ))
        | None -> R.Option None)
      in
      let v7 = (* pattern end *) token env v7 in
      let v8 = (* ";" *) token env v8 in
      R.Tuple [v1; v2; v3; v4; v5; v6; v7; v8]
    )
  | `Blk (v1, v2, v3, v4) -> R.Case ("Blk",
      let v1 = (* pattern begin *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_statementstr_ env x
          ))
        | None -> R.Option None)
      in
      let v3 = (* pattern end *) token env v3 in
      let v4 = (* ";" *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `With (v1, v2, v3, v4, v5) -> R.Case ("With",
      let v1 = (* pattern with *) token env v1 in
      let v2 = map_anon_opt_rep1_expr_COMMA_39d8f3f env v2 in
      let v3 = map_expr env v3 in
      let v4 = (* pattern do *) token env v4 in
      let v5 = map_statement env v5 in
      R.Tuple [v1; v2; v3; v4; v5]
    )
  | `Raise (v1, v2, v3, v4) -> R.Case ("Raise",
      let v1 = (* pattern raise *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_expr env x
          ))
        | None -> R.Option None)
      in
      let v3 =
        (match v3 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 = (* kraiseat *) token env v1 in
            let v2 = map_expr env v2 in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      let v4 = (* ";" *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Goto (v1, v2, v3) -> R.Case ("Goto",
      let v1 = (* pattern goto *) token env v1 in
      let v2 =
        (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v2
      in
      let v3 = (* ";" *) token env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Asm (v1, v2, v3, v4) -> R.Case ("Asm",
      let v1 = (* pattern asm *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_asmbody env x
          ))
        | None -> R.Option None)
      in
      let v3 = (* pattern end *) token env v3 in
      let v4 = (* ";" *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Semg_ellips tok -> R.Case ("Semg_ellips",
      (* "..." *) token env tok
    )
  )

and map_statement_ (env : env) (x : CST.statement_) =
  (match x with
  | `Expr_SEMI (v1, v2) -> R.Case ("Expr_SEMI",
      let v1 = map_expr env v1 in
      let v2 = (* ";" *) token env v2 in
      R.Tuple [v1; v2]
    )
  )

and map_statementstr (env : env) ((v1, v2) : CST.statementstr) =
  let v1 =
    R.List (List.map (fun x ->
      (match x with
      | `Stmt x -> R.Case ("Stmt",
          map_statement env x
        )
      | `Label x -> R.Case ("Label",
          map_label env x
        )
      | `Ppbl x -> R.Case ("Ppbl",
          map_ppblock env x
        )
      | `Ppfr tok -> R.Case ("Ppfr",
          (* ppfragmentstmt *) token env tok
        )
      )
    ) v1)
  in
  let v2 =
    (match v2 with
    | `Stat x -> R.Case ("Stat",
        map_statementtr env x
      )
    | `Stmt x -> R.Case ("Stmt",
        map_statement env x
      )
    | `Ppbl x -> R.Case ("Ppbl",
        map_ppblock env x
      )
    | `Ppfr tok -> R.Case ("Ppfr",
        (* ppfragmentstmt *) token env tok
      )
    )
  in
  R.Tuple [v1; v2]

and map_statementstr_ (env : env) (x : CST.statementstr_) =
  map_statementstr env x

and map_statementtr (env : env) (x : CST.statementtr) =
  (match x with
  | `Assign v1 -> R.Case ("Assign",
      map_assignment env v1
    )
  | `Vardef v1 -> R.Case ("Vardef",
      map_vardef env v1
    )
  | `Stat_ x -> R.Case ("Stat_",
      map_statementtr_ env x
    )
  | `Iftr (v1, v2, v3, v4) -> R.Case ("Iftr",
      let v1 = (* pattern if *) token env v1 in
      let v2 = map_expr env v2 in
      let v3 = (* pattern then *) token env v3 in
      let v4 =
        (match v4 with
        | Some x -> R.Option (Some (
            map_statementtr env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Ifel (v1, v2, v3, v4, v5, v6) -> R.Case ("Ifel",
      let v1 = (* pattern if *) token env v1 in
      let v2 = map_expr env v2 in
      let v3 = (* pattern then *) token env v3 in
      let v4 =
        (match v4 with
        | Some x -> R.Option (Some (
            map_anon_choice_stat_2a62092 env x
          ))
        | None -> R.Option None)
      in
      let v5 = (* pattern else *) token env v5 in
      let v6 =
        (match v6 with
        | Some x -> R.Option (Some (
            map_statementtr env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3; v4; v5; v6]
    )
  | `Whil (v1, v2, v3, v4) -> R.Case ("Whil",
      let v1 = (* pattern while *) token env v1 in
      let v2 = map_expr env v2 in
      let v3 = (* pattern do *) token env v3 in
      let v4 =
        (match v4 with
        | Some x -> R.Option (Some (
            map_statementtr env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Repe (v1, v2, v3, v4) -> R.Case ("Repe",
      let v1 = (* pattern repeat *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_statementstr_ env x
          ))
        | None -> R.Option None)
      in
      let v3 = (* pattern until *) token env v3 in
      let v4 = map_expr env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Fortr (v1, v2, v3, v4, v5, v6) -> R.Case ("Fortr",
      let v1 = (* pattern for *) token env v1 in
      let v2 = map_assignment env v2 in
      let v3 = map_anon_choice_kto_86c5a40 env v3 in
      let v4 = map_expr env v4 in
      let v5 = (* pattern do *) token env v5 in
      let v6 =
        (match v6 with
        | Some x -> R.Option (Some (
            map_statementtr env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3; v4; v5; v6]
    )
  | `Fore (v1, v2, v3, v4, v5, v6) -> R.Case ("Fore",
      let v1 = (* pattern for *) token env v1 in
      let v2 = map_anon_choice_expr_2fa3e6e env v2 in
      let v3 = (* pattern in *) token env v3 in
      let v4 = map_expr env v4 in
      let v5 = (* pattern do *) token env v5 in
      let v6 =
        (match v6 with
        | Some x -> R.Option (Some (
            map_statementtr env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3; v4; v5; v6]
    )
  | `Trytr (v1, v2, v3, v4) -> R.Case ("Trytr",
      let v1 = (* pattern try *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_statementstr_ env x
          ))
        | None -> R.Option None)
      in
      let v3 =
        map_anon_choice_kexc_opt_choice_stat__d8e7a89 env v3
      in
      let v4 = (* pattern end *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Casetr (v1, v2, v3, v4, v5, v6, v7) -> R.Case ("Casetr",
      let v1 = (* pattern case *) token env v1 in
      let v2 = map_expr env v2 in
      let v3 = (* pattern of *) token env v3 in
      let v4 = R.List (List.map (map_casecase env) v4) in
      let v5 =
        (match v5 with
        | Some x -> R.Option (Some (
            map_casecasetr env x
          ))
        | None -> R.Option None)
      in
      let v6 =
        (match v6 with
        | Some x -> R.Option (Some (
            map_anon_choice_kelse_opt_COLON_opt_stat__c22ab7e env x
          ))
        | None -> R.Option None)
      in
      let v7 = (* pattern end *) token env v7 in
      R.Tuple [v1; v2; v3; v4; v5; v6; v7]
    )
  | `Bloc x -> R.Case ("Bloc",
      map_blocktr env x
    )
  | `Withtr (v1, v2, v3, v4, v5) -> R.Case ("Withtr",
      let v1 = (* pattern with *) token env v1 in
      let v2 = map_anon_opt_rep1_expr_COMMA_39d8f3f env v2 in
      let v3 = map_expr env v3 in
      let v4 = (* pattern do *) token env v4 in
      let v5 =
        (match v5 with
        | Some x -> R.Option (Some (
            map_statementtr env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3; v4; v5]
    )
  | `Rais (v1, v2, v3) -> R.Case ("Rais",
      let v1 = (* pattern raise *) token env v1 in
      let v2 =
        (match v2 with
        | Some x -> R.Option (Some (
            map_expr env x
          ))
        | None -> R.Option None)
      in
      let v3 =
        (match v3 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 = (* kraiseat *) token env v1 in
            let v2 = map_expr env v2 in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3]
    )
  | `Gototr (v1, v2) -> R.Case ("Gototr",
      let v1 = (* pattern goto *) token env v1 in
      let v2 =
        (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v2
      in
      R.Tuple [v1; v2]
    )
  | `Asmtr x -> R.Case ("Asmtr",
      map_asmtr env x
    )
  )

and map_statementtr_ (env : env) (x : CST.statementtr_) =
  (match x with
  | `Expr v1 -> R.Case ("Expr",
      map_expr env v1
    )
  )

and map_type_ (env : env) (x : CST.type_) =
  (match x with
  | `Type x -> R.Case ("Type",
      map_typeref env x
    )
  | `Decl_172a5fa (v1, v2, v3) -> R.Case ("Decl_172a5fa",
      let v1 = (* pattern class *) token env v1 in
      let v2 = (* pattern of *) token env v2 in
      let v3 = map_typeref env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Decl_b2059ac (v1, v2, v3, v4) -> R.Case ("Decl_b2059ac",
      let v1 = (* "(" *) token env v1 in
      let v2 =
        (match v2 with
        | Some xs -> R.Option (Some (
            R.List (List.map (fun (v1, v2) ->
              let v1 = map_declenumvalue env v1 in
              let v2 = (* "," *) token env v2 in
              R.Tuple [v1; v2]
            ) xs)
          ))
        | None -> R.Option None)
      in
      let v3 = map_declenumvalue env v3 in
      let v4 = (* ")" *) token env v4 in
      R.Tuple [v1; v2; v3; v4]
    )
  | `Decl_9b757b1 (v1, v2, v3) -> R.Case ("Decl_9b757b1",
      let v1 = (* pattern set *) token env v1 in
      let v2 = (* pattern of *) token env v2 in
      let v3 = map_type_ env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Decl_fb3a596 (v1, v2, v3, v4, v5) -> R.Case ("Decl_fb3a596",
      let v1 =
        (match v1 with
        | Some tok -> R.Option (Some (
            (* pattern packed *) token env tok
          ))
        | None -> R.Option None)
      in
      let v2 = (* pattern array *) token env v2 in
      let v3 =
        (match v3 with
        | Some (v1, v2, v3) -> R.Option (Some (
            let v1 = (* "[" *) token env v1 in
            let v2 =
              (match v2 with
              | Some (v1, v2) -> R.Option (Some (
                  let v1 =
                    (match v1 with
                    | Some xs -> R.Option (Some (
                        R.List (List.map (fun (v1, v2) ->
                          let v1 = map_anon_choice_range_ff5eaed env v1 in
                          let v2 = (* "," *) token env v2 in
                          R.Tuple [v1; v2]
                        ) xs)
                      ))
                    | None -> R.Option None)
                  in
                  let v2 = map_anon_choice_range_ff5eaed env v2 in
                  R.Tuple [v1; v2]
                ))
              | None -> R.Option None)
            in
            let v3 = (* "]" *) token env v3 in
            R.Tuple [v1; v2; v3]
          ))
        | None -> R.Option None)
      in
      let v4 = (* pattern of *) token env v4 in
      let v5 = map_type_ env v5 in
      R.Tuple [v1; v2; v3; v4; v5]
    )
  | `Decl_d33f432 (v1, v2) -> R.Case ("Decl_d33f432",
      let v1 = (* pattern file *) token env v1 in
      let v2 =
        (match v2 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 = (* pattern of *) token env v1 in
            let v2 = map_type_ env v2 in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2]
    )
  | `Decl_4e1d441 (v1, v2, v3) -> R.Case ("Decl_4e1d441",
      let v1 = (* pattern string *) token env v1 in
      let v2 =
        (match v2 with
        | Some (v1, v2, v3) -> R.Option (Some (
            let v1 = (* "[" *) token env v1 in
            let v2 =
              (match v2 with
              | `Expr x -> R.Case ("Expr",
                  map_expr env x
                )
              )
            in
            let v3 = (* "]" *) token env v3 in
            R.Tuple [v1; v2; v3]
          ))
        | None -> R.Option None)
      in
      let v3 = map_anon_opt_kdep_opt_expr_9e396fa env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Decl_4eec7e9 (v1, v2, v3, v4, v5, v6) -> R.Case ("Decl_4eec7e9",
      let v1 =
        (match v1 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 = (* pattern reference *) token env v1 in
            let v2 = (* pattern to *) token env v2 in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      let v2 = map_anon_choice_kpro_f69e586 env v2 in
      let v3 =
        (match v3 with
        | Some x -> R.Option (Some (
            map_declargs env x
          ))
        | None -> R.Option None)
      in
      let v4 =
        (match v4 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 = (* ":" *) token env v1 in
            let v2 = map_typeref env v2 in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      let v5 =
        (match v5 with
        | Some (v1, v2) -> R.Option (Some (
            let v1 = (* pattern of *) token env v1 in
            let v2 = (* pattern object *) token env v2 in
            R.Tuple [v1; v2]
          ))
        | None -> R.Option None)
      in
      let v6 =
        (match v6 with
        | Some x -> R.Option (Some (
            map_anon_choice_kstd_a801c0a env x
          ))
        | None -> R.Option None)
      in
      R.Tuple [v1; v2; v3; v4; v5; v6]
    )
  | `Decl_0ebbf4b (v1, v2, v3) -> R.Case ("Decl_0ebbf4b",
      let v1 = map_subrangebound env v1 in
      let v2 = (* ".." *) token env v2 in
      let v3 = map_subrangebound env v3 in
      R.Tuple [v1; v2; v3]
    )
  | `Decl_dd9f703 (v1, v2, v3) -> R.Case ("Decl_dd9f703",
      let v1 =
        (match v1 with
        | Some tok -> R.Option (Some (
            (* pattern packed *) token env tok
          ))
        | None -> R.Option None)
      in
      let v2 = (* pattern record *) token env v2 in
      let v3 = map_declclass_ env v3 in
      R.Tuple [v1; v2; v3]
    )
  )

and map_typeref (env : env) ((v1, v2, v3) : CST.typeref) =
  let v1 =
    (match v1 with
    | Some tok -> R.Option (Some (
        (* pattern specialize *) token env tok
      ))
    | None -> R.Option None)
  in
  let v2 = map_typeref_ env v2 in
  let v3 = map_anon_opt_kdep_opt_expr_9e396fa env v3 in
  R.Tuple [v1; v2; v3]

and map_vardef (env : env) ((v1, v2, v3, v4) : CST.vardef) =
  let v1 = (* pattern var *) token env v1 in
  let v2 =
    (* pattern [&]?[\p{L}_][\p{L}\p{N}_$]*|\$[A-Z_][A-Z_0-9]*|\$\.\.\.[A-Z_][A-Z_0-9]* *) token env v2
  in
  let v3 = (* ":" *) token env v3 in
  let v4 = map_typeref env v4 in
  R.Tuple [v1; v2; v3; v4]

let map_library (env : env) ((v1, v2, v3, v4, v5, v6) : CST.library) =
  let v1 = (* pattern library *) token env v1 in
  let v2 = map_modulename env v2 in
  let v3 = (* ";" *) token env v3 in
  let v4 =
    (match v4 with
    | Some x -> R.Option (Some (
        map_definitions env x
      ))
    | None -> R.Option None)
  in
  let v5 =
    (match v5 with
    | `Bloc x -> R.Case ("Bloc",
        map_blocktr env x
      )
    | `Kend tok -> R.Case ("Kend",
        (* pattern end *) token env tok
      )
    )
  in
  let v6 = (* "." *) token env v6 in
  R.Tuple [v1; v2; v3; v4; v5; v6]

let map_declarations (env : env) (xs : CST.declarations) =
  R.List (List.map (fun x ->
    (match x with
    | `Declts x -> R.Case ("Declts",
        map_decltypes env x
      )
    | `Declvs x -> R.Case ("Declvs",
        map_declvars env x
      )
    | `Declcs x -> R.Case ("Declcs",
        map_declconsts env x
      )
    | `Decl_6ec32a9 x -> R.Case ("Decl_6ec32a9",
        map_declproc env x
      )
    | `Decl_5f998b5 x -> R.Case ("Decl_5f998b5",
        map_declprop env x
      )
    | `Decl_8dd77dd x -> R.Case ("Decl_8dd77dd",
        map_declprocfwd env x
      )
    | `Declus x -> R.Case ("Declus",
        map_decluses env x
      )
    | `Declls x -> R.Case ("Declls",
        map_decllabels env x
      )
    | `Decles x -> R.Case ("Decles",
        map_declexports env x
      )
    | `Ppbl x -> R.Case ("Ppbl",
        map_ppblock env x
      )
    | `Semg_ellips tok -> R.Case ("Semg_ellips",
        (* "..." *) token env tok
      )
    )
  ) xs)

let map_implementation (env : env) ((v1, v2) : CST.implementation) =
  let v1 = (* pattern implementation *) token env v1 in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_definitions env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2]

let map_finalization (env : env) ((v1, v2) : CST.finalization) =
  let v1 = (* pattern finalization *) token env v1 in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_statementstr_ env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2]

let map_program (env : env) ((v1, v2, v3, v4, v5, v6) : CST.program) =
  let v1 = (* pattern program *) token env v1 in
  let v2 = map_modulename env v2 in
  let v3 = (* ";" *) token env v3 in
  let v4 =
    (match v4 with
    | Some x -> R.Option (Some (
        map_definitions env x
      ))
    | None -> R.Option None)
  in
  let v5 = map_blocktr env v5 in
  let v6 = (* "." *) token env v6 in
  R.Tuple [v1; v2; v3; v4; v5; v6]

let map_statements (env : env) (xs : CST.statements) =
  R.List (List.map (fun x ->
    (match x with
    | `Vardef x -> R.Case ("Vardef",
        map_vardef env x
      )
    | `Stmt x -> R.Case ("Stmt",
        map_statement env x
      )
    | `Label x -> R.Case ("Label",
        map_label env x
      )
    | `Ppbl x -> R.Case ("Ppbl",
        map_ppblock env x
      )
    | `Ppfr tok -> R.Case ("Ppfr",
        (* ppfragmentstmt *) token env tok
      )
    )
  ) xs)

let map_initialization (env : env) ((v1, v2) : CST.initialization) =
  let v1 = (* pattern initialization *) token env v1 in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_statementstr_ env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2]

let map_interface (env : env) ((v1, v2) : CST.interface) =
  let v1 = (* pattern interface *) token env v1 in
  let v2 =
    (match v2 with
    | Some x -> R.Option (Some (
        map_declarations env x
      ))
    | None -> R.Option None)
  in
  R.Tuple [v1; v2]

let map_unit_ (env : env) ((v1, v2, v3, v4, v5, v6) : CST.unit_) =
  let v1 = (* pattern unit *) token env v1 in
  let v2 = map_modulename env v2 in
  let v3 = (* ";" *) token env v3 in
  let v4 =
    R.List (List.map (fun x ->
      (match x with
      | `Inte x -> R.Case ("Inte",
          map_interface env x
        )
      | `Impl x -> R.Case ("Impl",
          map_implementation env x
        )
      | `Init x -> R.Case ("Init",
          map_initialization env x
        )
      | `Fina x -> R.Case ("Fina",
          map_finalization env x
        )
      )
    ) v4)
  in
  let v5 =
    (match v5 with
    | Some tok -> R.Option (Some (
        (* pattern end *) token env tok
      ))
    | None -> R.Option None)
  in
  let v6 = (* "." *) token env v6 in
  R.Tuple [v1; v2; v3; v4; v5; v6]

let map_root (env : env) (x : CST.root) =
  (match x with
  | `Opt_choice_prog opt -> R.Case ("Opt_choice_prog",
      (match opt with
      | Some x -> R.Option (Some (
          (match x with
          | `Prog x -> R.Case ("Prog",
              map_program env x
            )
          | `Libr x -> R.Case ("Libr",
              map_library env x
            )
          | `Unit x -> R.Case ("Unit",
              map_unit_ env x
            )
          | `Defins x -> R.Case ("Defins",
              map_definitions env x
            )
          )
        ))
      | None -> R.Option None)
    )
  | `Pack (v1, v2, v3, v4, v5, v6, v7) -> R.Case ("Pack",
      let v1 = (* pattern package *) token env v1 in
      let v2 = map_modulename env v2 in
      let v3 = (* ";" *) token env v3 in
      let v4 =
        (match v4 with
        | Some (v1, v2, v3, v4) -> R.Option (Some (
            let v1 = (* pattern requires *) token env v1 in
            let v2 =
              R.List (List.map (fun (v1, v2) ->
                let v1 = map_modulename env v1 in
                let v2 = (* "," *) token env v2 in
                R.Tuple [v1; v2]
              ) v2)
            in
            let v3 = map_modulename env v3 in
            let v4 = (* ";" *) token env v4 in
            R.Tuple [v1; v2; v3; v4]
          ))
        | None -> R.Option None)
      in
      let v5 =
        (match v5 with
        | Some (v1, v2, v3, v4) -> R.Option (Some (
            let v1 = (* pattern contains *) token env v1 in
            let v2 =
              R.List (List.map (fun (v1, v2) ->
                let v1 = map_anon_choice_modu_685a062 env v1 in
                let v2 = (* "," *) token env v2 in
                R.Tuple [v1; v2]
              ) v2)
            in
            let v3 = map_anon_choice_modu_685a062 env v3 in
            let v4 = (* ";" *) token env v4 in
            R.Tuple [v1; v2; v3; v4]
          ))
        | None -> R.Option None)
      in
      let v6 = (* pattern end *) token env v6 in
      let v7 = (* "." *) token env v7 in
      R.Tuple [v1; v2; v3; v4; v5; v6; v7]
    )
  | `Semg_exp (v1, v2) -> R.Case ("Semg_exp",
      let v1 = (* "__SEMGREP_EXPRESSION" *) token env v1 in
      let v2 = map_expr env v2 in
      R.Tuple [v1; v2]
    )
  | `Semg_stmts (v1, v2) -> R.Case ("Semg_stmts",
      let v1 = (* "__SEMGREP_STATEMENTS" *) token env v1 in
      let v2 = map_statementstr_ env v2 in
      R.Tuple [v1; v2]
    )
  | `Semg_declas (v1, v2) -> R.Case ("Semg_declas",
      let v1 = (* "__SEMGREP_DECLARATIONS" *) token env v1 in
      let v2 =
        R.List (List.map (fun x ->
          (match x with
          | `Decl_c64a659 x -> R.Case ("Decl_c64a659",
              map_decltype env x
            )
          | `Decl_a20e53a x -> R.Case ("Decl_a20e53a",
              map_declvar env x
            )
          | `Decl_d45e488 x -> R.Case ("Decl_d45e488",
              map_declconst env x
            )
          | `Decl_497d63e x -> R.Case ("Decl_497d63e",
              map_declfield env x
            )
          | `Decl_5f998b5 x -> R.Case ("Decl_5f998b5",
              map_declprop env x
            )
          | `Decl_6ec32a9 x -> R.Case ("Decl_6ec32a9",
              map_declproc env x
            )
          | `Decl_8dd77dd x -> R.Case ("Decl_8dd77dd",
              map_declprocfwd env x
            )
          | `Declts x -> R.Case ("Declts",
              map_decltypes env x
            )
          | `Declvs x -> R.Case ("Declvs",
              map_declvars env x
            )
          | `Declcs x -> R.Case ("Declcs",
              map_declconsts env x
            )
          | `Declus x -> R.Case ("Declus",
              map_decluses env x
            )
          | `Semg_ellips tok -> R.Case ("Semg_ellips",
              (* "..." *) token env tok
            )
          )
        ) v2)
      in
      R.Tuple [v1; v2]
    )
  )

let map_ppdirective (env : env) (tok : CST.ppdirective) =
  (* ppdirective *) token env tok

let map_comment (env : env) (tok : CST.comment) =
  (* comment *) token env tok

let map_space (env : env) (tok : CST.space) =
  (* pattern [\s\r\n\t﻿]+ *) token env tok

let dump_tree root =
  map_root () root
  |> Tree_sitter_run.Raw_tree.to_channel stdout

let map_extra (env : env) (x : CST.extra) =
  match x with
  | `Space (_loc, x) -> ("space", "space", map_space env x)
  | `Comment (_loc, x) -> ("comment", "comment", map_comment env x)
  | `Ppdirective (_loc, x) -> ("ppdirective", "ppdirective", map_ppdirective env x)

let dump_extras (extras : CST.extras) =
  List.iter (fun extra ->
    let ts_rule_name, ocaml_type_name, raw_tree = map_extra () extra in
    let details =
      if ocaml_type_name <> ts_rule_name then
        Printf.sprintf " (OCaml type '%s')" ocaml_type_name
      else
        ""
    in
    Printf.printf "%s%s:\n" ts_rule_name details;
    Tree_sitter_run.Raw_tree.to_channel stdout raw_tree
  ) extras
