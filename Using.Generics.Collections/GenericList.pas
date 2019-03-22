unit GenericList;

interface

uses
  System.SysUtils, System.Generics.Collections;

procedure TestGenericList;

implementation

type
  TMyRec = record
    Id: integer;
    Val: string;
    constructor Create(aID: integer; aVal: string);
    function ToString: string;
  end;

constructor TMyRec.Create;
begin
  Id := aID; Val := aVal;
end;

function TMyRec.ToString: string;
begin
  result := Format('%d %s', [Id, Val])
end;

procedure TestGenericList;
var
  MyLst: TList<TMyRec>;
  c: integer;

  MyRec: TMyRec;
begin
  Writeln('- Test Generic List ----------------------------------------------');
  MyLst := TList<TMyRec>.Create;
  try
    MyLst.Add(TMyRec.Create(3, 'Meier'));
    MyLst.Add(TMyRec.Create(11, 'Müller'));
    MyLst.Insert(0, TMyRec.Create(17, 'Hugentobler'));

    for c := 0 to MyLst.Count - 1 do
      writeln('[' + IntToStr(c) + '] = ' + MyLst.Items[c].ToString);

    writeln('With For-In without getting the index');
    for MyRec in MyLst do
      writeln(MyRec.ToString);

  finally
    MyLst.Free;
  end;
end;

end.
