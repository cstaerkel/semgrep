procedure Test;
begin
  // ERROR:
  FreeAndNil(Obj);
  // ERROR:
  freeandnil(Obj);
  // ERROR:
  FREEANDNIL(Obj);
  FreeAndNull(Obj);
end;
