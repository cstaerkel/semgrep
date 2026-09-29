procedure Test(X: Integer);
begin
  // ERROR:
  if X > 2 then
    Foo(1)
  else
    Foo(1);
  if X > 2 then
    Foo(1)
  else
    Foo(2);
end;
