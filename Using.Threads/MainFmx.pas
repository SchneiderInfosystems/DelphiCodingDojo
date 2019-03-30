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
    btnThreadedQueue: TButton;
    procedure btnAnonymThreadClick(Sender: TObject);
  private
    fLogStarted: cardinal;
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
