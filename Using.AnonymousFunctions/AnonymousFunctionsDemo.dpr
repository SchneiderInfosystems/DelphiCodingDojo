program AnonymousFunctionsDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinApi.Windows,
  SimpleAnonymousFunc in 'SimpleAnonymousFunc.pas',
//  ClosureDemo in 'ClosureDemo.pas',
  ParallelForEach in 'ParallelForEach.pas',
  GenericListSort in 'GenericListSort.pas';

procedure ClearScreen;
  var
    stdout: THandle;
    csbi: TConsoleScreenBufferInfo;
    ConsoleSize: DWORD;
    NumWritten: DWORD;
    Origin: TCoord;
  begin
    stdout := GetStdHandle(STD_OUTPUT_HANDLE);
    Win32Check(stdout<>INVALID_HANDLE_VALUE);
    Win32Check(GetConsoleScreenBufferInfo(stdout, csbi));
    ConsoleSize := csbi.dwSize.X * csbi.dwSize.Y;
    Origin.X := 0; Origin.Y := 0;
    Win32Check(FillConsoleOutputCharacter(stdout, ' ', ConsoleSize, Origin, NumWritten));
    Win32Check(FillConsoleOutputAttribute(stdout, csbi.wAttributes, ConsoleSize, Origin, NumWritten));
    Win32Check(SetConsoleCursorPosition(stdout, Origin));
  end;
var
  Enter: string;
begin
  ReportMemoryLeaksOnShutdown := true;
  try
    repeat
      ClearScreen;
      Writeln('Enter number to start test');
      Writeln('1: Simple Anonymous Function');
      Writeln('2: Inline Declaration');
      Writeln('3: Closure Demo');
      Writeln('4: List Sort');
      Writeln('6: Test ParallelForEach');
      Writeln('E: exit');
      readln(Enter);
      ClearScreen;
      case StrToIntDef(Enter, 0) of
        0: break;
        1: TestSimpleAnonymousFunc;
        2: TestInlineDeclaration;
//        3: TestClosures;
        4: TestGenericListSort;
        6: TestParallelForEach;
      end;
      readln;
    until false;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
