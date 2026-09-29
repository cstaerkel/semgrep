procedure Test;
var
  L: TStringList;
begin
  // ERROR:
  L := TStringList.Create;
  try
    L.Add('a');
  finally
    L.Free;
  end;
end;
