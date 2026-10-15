unit ifdef_missing_include;
{$I does_not_exist.inc}
interface
implementation
procedure Test;
begin
  // ERROR:
  WinExec(nil, 0);
end;
end.
