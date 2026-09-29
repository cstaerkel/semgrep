procedure Test(X: Integer);
begin
  // ERROR:
  if X > 2 then
    Foo;
  // ERROR:
  if X = 1 then
    Y := 3;
end;
