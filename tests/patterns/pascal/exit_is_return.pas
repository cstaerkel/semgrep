function Test(A: Integer): Integer;
begin
  if A < 0 then
    // ERROR:
    Exit(0);
  Result := A;
end;
