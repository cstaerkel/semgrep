function Test(X: Integer): Integer;
begin
  // ERROR: match
  if X = 1 then
  begin
    Result := 2;
  end;
end;
