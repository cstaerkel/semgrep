procedure Test;
begin
{$IFDEF FPC}
  Bar(1);
{$ELSE}
  // ERROR:
  Foo(2);
{$ENDIF}
end;
