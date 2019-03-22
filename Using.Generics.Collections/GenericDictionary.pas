unit GenericDictionary;

interface

uses
  System.SysUtils, System.Generics.Collections;

procedure TestGenericDictionary;

implementation

type
  TMyRec = record
    PreName, LastName: string;
    constructor Create(const aPreName, aLastName: string);
    function ToString: string;
  end;

constructor TMyRec.Create;
begin
  PreName := aPreName; LastName := aLastName;
end;

function TMyRec.ToString: string;
begin
  result := Format('%s %s', [PreName, LastName])
end;

procedure TestGenericDictionary;
var
  MyDict: TDictionary<string, TMyRec>; {Key=CustomerID}
  res: TMyRec;
begin
  Writeln('- Test Generic List ----------------------------------------------');
  MyDict := TDictionary<string, TMyRec>.Create;
  try
    MyDict.Add('CustomerID.123-456', TMyRec.Create('Hans', 'Meier'));
    MyDict.Add('CustomerID.000-100', TMyRec.Create('Sabine', 'Müller'));

    if MyDict.TryGetValue('CustomerID.000-100', res) then
      writeln('CustomerID.000-100 :' + res.ToString);
    if MyDict.TryGetValue('CustomerID.123-456', res) then
      writeln('CustomerID.123-456 :' + res.ToString);
  finally
    MyDict.Free;
  end;
end;

end.
