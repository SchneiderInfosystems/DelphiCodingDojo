unit uMain;

interface

uses
  uPerson,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections, System.Generics.Defaults,
  Vcl.StdCtrls, System.Diagnostics;

type
  TFrmMain = class(TForm)
    Memo1: TMemo;
    BtnListeErstellen: TButton;
    procedure BtnListeErstellenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FStopwatch: TStopwatch;
    FStopwatchTitle: String;

    /// <summary>
    /// Startet die Stoppuhr.
    /// </summary>
    /// <param name="ABezeichnung"> (String) wird angezeigt.</param>
    procedure Start(ABezeichnung: String);

    /// <summary>Stoppt die Stoppuhr.
    /// </summary>
    procedure Stop;

    /// <summary>BeginUpdate auf dem Memo und Header anzeigen
    /// </summary>
    procedure BeginUpdateMemo;

    /// <summary>Schreibt die mitgegebene Person ins Memo.
    /// </summary>
    /// <param name="APerson"> (TPerson) </param>
    procedure AddToMemo(APerson: TPerson);

    /// <summary>Endupdate auf dem Memo
    /// </summary>
    procedure EndUpdateMemo;

    /// <summary>Füllt alle Personen in der Liste ins Memo
    /// </summary>
    procedure UpdateMemo;

    /// <summary>Erstellt eine Liste mit der angegebenen Anzahl Personen.
    /// </summary>
    /// <param name="AAnzahl"> (Integer) </param>
    procedure ErstelleListe(AAnzahl: Integer);
  public
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}


procedure TFrmMain.AddToMemo(APerson: TPerson);
begin
  Memo1.Lines.Add(
    APerson.Id.ToString.PadRight(20) +
    APerson.Name.PadRight(20) +
    APerson.Vorname.PadRight(20) +
    FormatDateTime('ddddd', APerson.Geburtstag).PadRight(20) +
    APerson.Ehepartner.ToString.PadRight(20)
    );
end;

procedure TFrmMain.BeginUpdateMemo;
var
  LHeader: String;
begin
  Memo1.Lines.BeginUpdate;
  Memo1.Lines.Clear;
  Memo1.Lines.Add(FStopwatchTitle + ' in ' + FStopwatch.ElapsedMilliseconds.ToString + ' ms');
  Memo1.Lines.Add('');
  LHeader := 'Id'.PadRight(20) + 'Name'.PadRight(20) + 'Vorname'.PadRight(20) + 'Geburtstag'.PadRight(20) + 'Ehepartner'.PadRight(20);
  Memo1.Lines.Add(LHeader);
  Memo1.Lines.Add(''.PadRight(LHeader.Length, '-'));
end;

procedure TFrmMain.BtnListeErstellenClick(Sender: TObject);
begin
  ErstelleListe(5000);
  UpdateMemo;
end;

procedure TFrmMain.Start(ABezeichnung: String);
begin
  FStopwatchTitle := ABezeichnung;
  FStopwatch := TStopwatch.StartNew;
end;

procedure TFrmMain.Stop;
begin
  FStopwatch.Stop;
end;

procedure TFrmMain.UpdateMemo;
begin
  try
    BeginUpdateMemo;

    { TODO : Hier sollen die Personen mit AddToMemo( APerson: TPerson ) ins Memo gefüllt werden }

  finally
    EndUpdateMemo;
  end;
end;

procedure TFrmMain.EndUpdateMemo;
begin
  Memo1.Lines.EndUpdate;
end;

procedure TFrmMain.ErstelleListe(AAnzahl: Integer);
begin
  Start('Erstelle Liste');
  try

    { TODO : Liste wird hier mit der Anzahl Personen gefüllt. Die TPerson Klasse generiert eigene Zufallswerte. }

  finally
    Stop;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  BtnListeErstellen.Click;
end;

end.
