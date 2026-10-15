unit modern_syntax;

interface

type
  TE = (eA, eB, eC);
  TR = Low(TE)..High(TE);

  TFactory = class
  public
    function Get<T: class, constructor>: T;
    function GetRec<T: record>: T;
    procedure Q([ref] const R: TRect);
    procedure Q2(const [ref] R: TRect);
  end;

implementation

function TFactory.Get<T>: T;
begin
  Result := T.Create;
end;

function TFactory.GetRec<T>: T;
begin
  Result := Default(T);
end;

procedure TFactory.Q([ref] const R: TRect);
begin
end;

procedure TFactory.Q2(const [ref] R: TRect);
begin
end;

procedure InlineDeclarations;
begin
  var A, B: Integer;
  var S: array[Boolean] of Integer;
  const C = 'x';
  const D: Integer = 1;
  var X := 42;
  A := D;
  B := A + X;
  S[True] := B;
end;

function CompareLetterSets(Set1, Set2: LongInt): Cardinal;
asm
  push   ebx
  and    eax, edx
  mov    ecx, ('Z'-'A')            { Set up counter }
  mov    eax, 2000000h
  jmp    @@Start
@@Start:
  pop    ebx
end;

end.
