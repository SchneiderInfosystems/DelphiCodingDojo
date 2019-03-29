unit GenericListSort;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Generics.Defaults;

procedure TestGenericListSort;

implementation

type
  TMyRec = record
    Id: integer;
    FirstName, LastName: string;
    constructor Create(aID: integer; aFirstName, aLastName: string);
    function ToString: string;
  end;

constructor TMyRec.Create;
begin
  Id := aID; FirstName := aFirstName; LastName := aLastName;
end;

function TMyRec.ToString: string;
begin
  result := Format('%d %s %s', [Id, FirstName, LastName])
end;

procedure TestGenericListSort;
var
  MyLst: TList<TMyRec>;
  MyRec: TMyRec;
begin
  Writeln('- Test Generic List Sort -------------------------------------------');
  MyLst := TList<TMyRec>.Create;
  try
    MyLst.Add(TMyRec.Create(3, 'Hans', 'Meier'));
    MyLst.Add(TMyRec.Create(5, 'Hugo', 'Müller'));
    MyLst.Add(TMyRec.Create(17, 'Rolf', 'Müller'));
    MyLst.Add(TMyRec.Create(14, 'Rolf', 'Meier'));
    MyLst.Add(TMyRec.Create(2, 'Hugo', 'Meier'));

    Writeln('Unsorted -------------------------------------------------------');
    for MyRec in MyLst do
      writeln(MyRec.ToString);

    MyLst.Sort(TComparer<TMyRec>.Construct(
      function (const Left, Right: TMyRec): Integer
      begin
        if Left.ID > Right.ID then
          result := 1
        else if Left.ID < Right.ID then
          result := -1
        else
          result := 0;
    end));
    Writeln('Sorted ID ------------------------------------------------------');
    for MyRec in MyLst do
      writeln(MyRec.ToString);

    MyLst.Sort(TComparer<TMyRec>.Construct(
      function (const Left, Right: TMyRec): Integer
      begin
        if Left.LastName > Right.LastName then
          result := 1
        else if Left.LastName < Right.LastName then
          result := -1
        else if Left.FirstName > Right.FirstName then
          result := 1
        else if Left.FirstName < Right.FirstName then
          result := -1
        else
          result := 0;
    end));

    Writeln('Sorted LastName, FirstName -------------------------------------');
    for MyRec in MyLst do
      writeln(MyRec.ToString);
  finally
    MyLst.Free;
  end;
end;

end.
