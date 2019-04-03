unit MainFmx;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfmxMain = class(TForm)
    btnParallelFor: TButton;
    lstLog: TListBox;
    procedure btnParallelForClick(Sender: TObject);
  public
    fLogStarted: cardinal;
    procedure StartLog;
    procedure Log(const Msg: string);
    function IsPrime(const n: int64): boolean;
  end;

var
  fmxMain: TfmxMain;

implementation

uses
  System.Threading,
  System.Diagnostics, System.TimeSpan;

{$R *.fmx}

{ TfmxMain }

procedure TfmxMain.btnParallelForClick(Sender: TObject);
const
  cStartInterval = 10000000001000;
  cEndInterval =   10000000002000;
//var
//  res: TParallel.TLoopResult;
begin
  StartLog;
  TParallel.For(cStartInterval, cEndInterval,
    procedure(c: Int64)
    begin
      if IsPrime(c) then
        TThread.Queue(nil,
          procedure
          begin
            Log(c.ToString);
          end);
    end);
end;

function TfmxMain.IsPrime(const n: int64): boolean;
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

procedure TfmxMain.StartLog;
begin
  lstLog.Clear;
  fLogStarted := TStopWatch.GetTimeStamp div TTimeSpan.TicksPerMillisecond;
end;

procedure TfmxMain.Log(const Msg: string);
var
  CurrentTimeInMs: cardinal;
begin
  CurrentTimeInMs := TStopWatch.GetTimeStamp div TTimeSpan.TicksPerMillisecond -
    fLogStarted;
  lstLog.ItemIndex := lstLog.Items.Add(
    Format('%6.3f sec: %s', [CurrentTimeInMs / 1000, Msg]));
end;

end.
