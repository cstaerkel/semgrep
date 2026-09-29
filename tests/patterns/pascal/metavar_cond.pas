procedure Test(X: Integer);
begin
  // ERROR:
  if X > 2 then
    Foo;
  // ERROR:
  if not Assigned(Obj) and (X = 1) then
    Foo;
  if X > 2 then
    Bar;
end;
