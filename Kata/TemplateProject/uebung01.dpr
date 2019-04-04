program uebung01;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {FrmMain},
  uPerson in '..\core\uPerson.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
