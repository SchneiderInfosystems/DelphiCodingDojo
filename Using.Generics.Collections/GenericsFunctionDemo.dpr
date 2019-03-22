program GenericsFunctionDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  WinApi.Windows,
  GenericSwap in 'GenericSwap.pas',
  GenericList in 'GenericList.pas',
  GenericObjectList in 'GenericObjectList.pas',
  GenericDictionary in 'GenericDictionary.pas',
  GenericQueue in 'GenericQueue.pas',
  GenericStack in 'GenericStack.pas';

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
      Writeln('1: Generic Swap');
      Writeln('2: Generic List');
      Writeln('3: Generic Object List');
      Writeln('4: Generic Dictionary');
      Writeln('5: Generic Queue');
      Writeln('6: Generic Stack');
      Writeln('E: exit');
      readln(Enter);
      ClearScreen;
      case StrToIntDef(Enter, 0) of
        0: break;
        1: TestGenericSwap;
        2: TestGenericList;
        3: TestGenericObjectList;
        4: TestGenericDictionary;
        5: TestGenericQueue;
        6: TestGenericStack;
      end;
      readln;
    until false;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
