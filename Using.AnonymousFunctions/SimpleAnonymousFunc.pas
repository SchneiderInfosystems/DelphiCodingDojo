unit SimpleAnonymousFunc;

interface

procedure TestSimpleAnonymousFunc;
procedure TestInlineDeclaration;

implementation

uses
  System.StrUtils;

type
  TObfuscationFunc = reference to function(const Txt: string): string;

procedure TestSimpleAnonymousFunc;
var
  Obfuscate: TObfuscationFunc;
const
  ClearTxt: string = 'Hello Delphi World';
begin
  Obfuscate := function(const Txt: string): string
               begin
                 result := ReverseString(Txt);
               end;
  Writeln(Obfuscate(ClearTxt));
  Writeln(Obfuscate(Obfuscate(ClearTxt)));
end;

procedure TestInlineDeclaration;

  procedure TestObfuscation(Obfuscate: TObfuscationFunc);
  const
    ClearTxt: string = 'Lambda @ Delphi';
  begin
    writeln('Start :' + ClearTxt);
    writeln('First run: ' + Obfuscate(ClearTxt));
    writeln('Second run: ' + Obfuscate(Obfuscate(ClearTxt)));
  end;

begin
  TestObfuscation(function(const Txt: string): string
                  begin
                    result := ReverseString(Txt);
                  end);
end;

end.
