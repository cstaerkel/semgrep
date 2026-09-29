procedure Test;
begin
  // ERROR:
  Foo('whatever sequence of chars');
  // ERROR:
  Foo('it''s quoted');
  Foo(42);
end;
