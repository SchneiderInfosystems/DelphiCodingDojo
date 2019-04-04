unit uPerson;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TPerson = class
  private
    FName: String;
    FVorname: String;
    FGeburtstag: TDateTime;
    FId: Integer;
    FEhepartner: Integer;
  public
    constructor Create(AId: Integer);

    procedure GeneriereZufallswerte;

    property Name: String read FName;
    property Vorname: String read FVorname;
    property Geburtstag: TDateTime read FGeburtstag;
    property Id: Integer read FId;
    property Ehepartner: Integer read FEhepartner;
  end;

implementation

{ TPerson }

constructor TPerson.Create(AId: Integer);
begin
  inherited Create;
  FId := AId;
  FEhepartner := 0;

  GeneriereZufallswerte;
end;

procedure TPerson.GeneriereZufallswerte;
const
  CNames: Array [0 .. 39] of String = ('Lothar Hergenröder',
    'Merle Hohn',
    'Nele Konow',
    'Manuel Pütz',
    'Liselotte Day',
    'Saskia Bandlow',
    'Eleonore Zerbe',
    'Leon Vollenbruch',
    'Juliane Fiess',
    'Tabea Kretz',
    'Heidi Schütte',
    'Philipp Riedel',
    'Fabienne Hehl',
    'Jens Jacobi',
    'Rosemarie Kuhl',
    'Wolfgang Wulke',
    'Marina Holzhauer',
    'Mathilde Klemm',
    'Barbara Wiechers',
    'Nele Hupe',
    'Tabea Keck',
    'Max Purschke',
    'Lilly Brünjes',
    'Samantha Dittmer',
    'Boris Kopischke',
    'Laurin Ebbing',
    'Richard Brandner',
    'Heino Wisniewski',
    'Ben Koc',
    'Theresa Naumann',
    'Alena Creutzmann',
    'Carlotta Gerhardt',
    'Alex Grätz',
    'Eileen Bach',
    'Christiane Tenambergen',
    'Janna Rabenhorst',
    'Hanna Streitz',
    'Ewald Fochler',
    'Roland Arenz',
    'Carina Michael');
begin
  // Name aus Index zusammenbasteln
  FVorname := CNames[Random(High(CNames))].Split([' '])[0];
  FName := CNames[Random(High(CNames))].Split([' '])[1];

  // Zufallsgeburtsdatum
  FGeburtstag := EncodeDate(1970, 1, 1) + Random(365 * 20);

  if Random(3) = 0 then // 25%
    FEhepartner := Random(1000);
end;

initialization

randomize;

end.
