program ParallelsDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainFmx in 'MainFmx.pas' {fmxMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmxMain, fmxMain);
  Application.Run;
end.
