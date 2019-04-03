unit ParallelForEach;

interface

uses
  WinApi.Windows,
  System.Classes, System.Threading, System.SysUtils;

procedure TestParallelForEach;

implementation

function IsPrime(const n: int64): boolean;
var
  i: cardinal;
  en: extended;
begin
  if n <> 2 then
  begin
    en := n;
    for i := 2 to round(sqrt(en)) do
      if n mod i = 0 then
        exit(false);
  end;
  result := n > 1;
end;

procedure TestParallelForEach;
const
  cStartInterval = 10000000001000;
  cEndInterval =   10000000002000;
var
  c, i: Int64;
  start: cardinal;
  res: TParallel.TLoopResult;
begin
  Writeln('Serial');
  start := GetTickCount;
  i := 0;
  for c := cStartInterval to cEndInterval do
    if IsPrime(c) then
    begin
      Writeln(Format('%3d : %d', [i, c]));
      inc(i);
    end;
  Writeln(Format('Total time serial: %5.1f s', [(GetTickCount - start)/1000]));
  Writeln('Parallel');
  start := GetTickCount;
  i := 0;
  res := TParallel.For(cStartInterval, cEndInterval,
    procedure(c: Int64)
    begin
      if IsPrime(c) then
        TThread.Queue(nil,
          procedure
          begin
            Writeln(Format('%3d : %d', [i, c]));
            inc(i);
          end);
    end);
  // Because of missing message loop in console application TThread.Queue is not handled
  repeat
    CheckSynchronize;
  until res.Completed;
  Writeln(Format('Total time parallel: %5.1f s', [(GetTickCount - start)/1000]));
end;

end.
