procedure Test;
begin
  // ERROR:
  Obj.Free;
  // ERROR:
  Obj.Free();
  Obj.Destroy;
end;
