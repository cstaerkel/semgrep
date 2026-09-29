procedure Test;
begin
  // ERROR:
  Foo(1,2);

  // ERROR:
  foo(1,
      2);

  // ERROR:
  FOO (1, // comment
       2);

  Foo(2, 1);
end;
