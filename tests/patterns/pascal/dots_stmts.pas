procedure Test;
var
  UserData: string;
begin
  // ERROR:
  UserData := Get();
  WriteLn('do stuff');
  FooBar;
  Eval(UserData);
end;
