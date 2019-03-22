unit GenericObjectList;

interface

uses
  System.SysUtils, System.Generics.Collections;

procedure TestGenericObjectList;

implementation

type
  TMyClass = class
    Id: integer;
    Val: string;
    constructor Create(aID: integer; aVal: string);
    function ToString: string;
  end;

constructor TMyClass.Create;
begin
  Id := aID; Val := aVal;
end;

function TMyClass.ToString: string;
begin
  result := Format('%d %s', [Id, Val])
end;

procedure TestGenericObjectList;
var
  MyLst: TObjectList<TMyClass>;
begin
  Writeln('- Test Generic List ----------------------------------------------');
  MyLst := TObjectList<TMyClass>.Create;
  try
    writeln('MyLst.OwnsObjects = ' + BoolToStr(MyLst.OwnsObjects, true));

    MyLst.Add(TMyClass.Create(3, 'Meier'));
    MyLst.Add(TMyClass.Create(11, 'Müller'));
    MyLst.Add(TMyClass.Create(17, 'Hugentobler'));

    for var c := 0 to MyLst.Count - 1 do     // Neu in Delphi 10.3
      writeln('[' + IntToStr(c) + '] = ' + MyLst.Items[c].ToString);
  finally
    MyLst.Free;
  end;
end;

end.
