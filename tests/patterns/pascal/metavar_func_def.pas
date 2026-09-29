unit Funcs;

interface

implementation

// ERROR:
function Double(A: Integer): Integer;
begin
  Result := A * 2;
end;

function Name(A: string): string;
begin
  Result := A;
end;

end.
