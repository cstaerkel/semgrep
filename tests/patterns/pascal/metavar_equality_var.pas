procedure Test;
begin
  // ERROR:
  MyFile := Open();
  Close(MyFile);
  // ERROR:
  MyFile := Open();
  Close(myfile);
  MyFile := Open();
  Close(Other);
end;
