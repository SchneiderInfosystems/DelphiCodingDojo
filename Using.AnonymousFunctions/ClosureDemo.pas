unit ClosureDemo;

interface

procedure TestSimpleClosures;
procedure TestClosuresWithGlobal;
procedure TestClosuresForPrefix;

implementation

uses
  System.SysUtils;

procedure TestSimpleClosures;
type
  TIntFunc = reference to function(i: integer): integer;

function HigherOrderFunc(a: integer; const FuncName: string): TIntFunc;
begin
  result := function(b: integer): integer
            begin
              result := a + b;
              Writeln(FuncName, ': ', a, '+', b, '=', result);
            end;
end;

var
  f1, f2: TIntFunc;
begin
  f1 := HigherOrderFunc(1, 'f1');
  f2 := HigherOrderFunc(2, 'f2');
  f1(10);
  f2(20);
  f1(30);
end;

procedure TestClosuresWithGlobal;
type
  TIntFunc = reference to function(i: integer): integer;
var
  c: integer;

  function HigherOrderFunc(a: integer; const FuncName: string): TIntFunc;
  begin
    result := function(b: integer): integer
              begin
                result := a + b + c;
                Writeln(FuncName, ': ', a, '+', b, '+', c, '=', result);
              end;
  end;

var
  f1, f2: TIntFunc;
begin
  c := 100;
  f1 := HigherOrderFunc(1, 'f1');
  c := 200;
  f2 := HigherOrderFunc(2, 'f2');
  f1(10);
  f2(20);
  c := 300;
  f1(30);
end;

procedure TestClosuresForPrefix;
type
  TActionOfString = reference to procedure(const s: string);

  function CreatePrefixer(const prefix: string): TActionOfString;
  begin
    result := procedure(const value: string)
              begin
                Writeln(prefix, '.', value);
              end;
  end;

var
  Prefixer1, Prefixer2: TActionOfString;
begin
  Prefixer1 := CreatePrefixer('Class1');
  Prefixer2 := CreatePrefixer('Class2');
  Prefixer1('MethodA');
  Prefixer1('MethodB');
  Prefixer2('MethodA');
end;

procedure TestClosures3;
type
  TCalcFunc = reference to function: integer;
  TCalcLevelFunc = reference to function(Level: integer): integer;
var
  CalcWithOffset: TCalcLevelFunc;
  Calc1, Calc2: TCalcFunc;
  Offset: integer;
begin
  CalcWithOffset :=
    function(Level: integer): integer
    begin
      result := level + Offset;
      writeln(Format('Calculate Level=%d  Offset=%d', [level, Offset]));
    end;
  Calc1 := function: integer begin result := CalcWithOffset(5) end;
  Calc2 := function: integer begin result := CalcWithOffset(2) end;
  Offset := 3;
  Writeln(Calc1.ToString);
  Offset := 7;
  Writeln(Calc2.ToString);
end;

end.
