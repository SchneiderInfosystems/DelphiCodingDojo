program ThreadDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFmx in 'MainFmx.pas' {FmxThreadDemo};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TFmxThreadDemo, FmxThreadDemo);
  Application.Run;
end.
