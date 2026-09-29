procedure Test;
begin
  // ERROR: match
  Foo;
  Bar;
  // ERROR: match
  Foo();
  X := Bar();
  // ERROR: match
  Foo;
  WriteLn(Bar());
  // ERROR: match
  Foo;
  Exit(Bar());
end;
