unit MainFmx;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TFmxThreadDemo = class(TForm)
    lstLog: TListBox;
    btnAnonymThread: TButton;
    btnAnonymThreadChecksApplicationEnd: TButton;
    btnAnonymThreadChecksAppEnd2ndApproach: TButton;
    procedure btnAnonymThreadClick(Sender: TObject);
    procedure btnAnonymThreadChecksApplicationEndClick(Sender: TObject);
    procedure btnAnonymThreadChecksAppEnd2ndApproachClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    fLogStarted: cardinal;
    fAbort, fRunning: boolean;
    procedure StartLog;
    procedure Log(const Msg: string);
    function IsPrime(const n: int64): boolean;
  end;

var
  FmxThreadDemo: TFmxThreadDemo;

implementation

uses
  System.Diagnostics, System.TimeSpan;

{$R *.fmx}

procedure TFmxThreadDemo.btnAnonymThreadClick(Sender: TObject);
const
  cStartInterval = 10000000001000;
  cEndInterval =   10000000002000;
begin
  StartLog;
  TThread.CreateAnonymousThread(
    procedure
    var
      c, i: Int64;
    begin
      i := 0; // Ermittelt rechenintensive Primzahlen
      c := cStartInterval;
      while c <= cEndInterval do
      begin
        if IsPrime(c) then
        begin
          TThread.Queue(nil, // Update GUI
            procedure
            begin
              Log(Format('%3d : %d', [i, c]));
            end);
          inc(i);
        end;
        inc(c);
      end;
    end).Start;
end;

procedure TFmxThreadDemo.btnAnonymThreadChecksApplicationEndClick(
  Sender: TObject);
const
  cStartInterval = 10000000001000;
  cEndInterval =   10000000002000;
begin
  StartLog;
  TThread.CreateAnonymousThread(
    procedure
    var
      c, i: Int64;
    begin
      i := 0; // Ermittelt rechenintensive Primzahlen
      c := cStartInterval;
      while (c <= cEndInterval) and not Application.Terminated do  // Additional Check
      begin
        if IsPrime(c) then
        begin
          TThread.Queue(nil, // Update GUI
            procedure
            begin
              Log(Format('%3d : %d', [i, c]));
            end);
          inc(i);
        end;
        inc(c);
      end;
    end).Start;
end;

procedure TFmxThreadDemo.btnAnonymThreadChecksAppEnd2ndApproachClick(
  Sender: TObject);
const
  cStartInterval = 100000000010000; // 10 times greater than in other examples
  cEndInterval =   100000000020000;
begin
  fRunning := true;
  fAbort := false;
  btnAnonymThreadChecksAppEnd2ndApproach.Enabled := false;
  StartLog;
  TThread.CreateAnonymousThread(
    procedure
    var
      c, i: Int64;
    begin
      i := 0; // Ermittelt rechenintensive Primzahlen
      c := cStartInterval;
      while (c <= cEndInterval) and not fAbort do
      begin
        if IsPrime(c) then
        begin
          TThread.Queue(nil, // Update GUI
            procedure
            begin
              Log(Format('%3d : %d', [i, c]));
            end);
          inc(i);
        end;
        inc(c);
      end;
      // Thread-End reached
      TThread.Queue(nil,
        procedure
        begin
          btnAnonymThreadChecksAppEnd2ndApproach.Enabled := true;
        end);
      fRunning := false;
    end).Start;
end;

procedure TFmxThreadDemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fAbort := true;
  while fRunning do
  begin
    Application.ProcessMessages;
    Sleep(50);
  end;
end;

function TFmxThreadDemo.IsPrime(const n: int64): boolean;
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
  result := n > 0;
end;

procedure TFmxThreadDemo.StartLog;
begin
  lstLog.Clear;
  fLogStarted := TStopWatch.GetTimeStamp div TTimeSpan.TicksPerMillisecond;
end;

procedure TFmxThreadDemo.Log(const Msg: string);
var
  CurrentTimeInMs: cardinal;
begin
  CurrentTimeInMs := TStopWatch.GetTimeStamp div TTimeSpan.TicksPerMillisecond -
    fLogStarted;
  lstLog.ItemIndex := lstLog.Items.Add(
    Format('%6.3f sec: %s', [CurrentTimeInMs / 1000, Msg]));
end;

end.
