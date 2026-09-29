function Test(A, B: Integer): Boolean;
begin
  // ERROR:
  Result := A + A = 2;
  Result := A + B = 2;
  // ERROR:
  Result := (Obj.Count + Obj.Count) = 2;
end;
