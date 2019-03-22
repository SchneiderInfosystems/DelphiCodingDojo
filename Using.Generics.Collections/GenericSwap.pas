unit GenericSwap;

interface

uses
  System.SysUtils;

procedure TestGenericSwap;

implementation

type
  THelper = class
    class procedure Swap<T>(var A, B: T);
  end;

class procedure THelper.Swap<T>(var A, B: T);
var X: T;
begin
  X := A; A := B; B := X;
end;

procedure TestGenericSwap;

  procedure Log(const Msg, AStr, BStr: string);
  begin
    writeln(Msg + ': ' + AStr + ' - ' + BStr);
  end;

var
  FirstName, LastName: String;
  Val1, Val2: integer;
begin
  Writeln('- Test Generic Swap ----------------------------------------------');
  Writeln('- Swap<string> ----');
  FirstName := 'Christoph'; LastName := 'Schneider';
  Log('Before Swap', FirstName, LastName);
  THelper.Swap<string>(FirstName, LastName);
  Log('After Swap', FirstName, LastName);
  Writeln;

  Writeln('- Swap<integer> ---');
  Val1 := 1; Val2 := 3;
  Log('Before Swap', Val1.ToString, Val2.ToString);
  THelper.Swap<integer>(Val1, Val2);
  Log('After Swap', Val1.ToString, Val2.ToString);
end;

end.
