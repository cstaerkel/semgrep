procedure Test;
begin
  // ERROR:
  Foo(1, 2);
  // ERROR:
  Foo(AVeryLongConstantName,
      2);
  // ERROR:
  Foo(Unsafe(), // indeed
      2);
  // ERROR:
  Foo(Bar(1, 3), 2);
  Foo(2, 1);
end;
