unit GenericStack;

interface

uses
  System.SysUtils, System.Generics.Collections;

procedure TestGenericStack;

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

procedure TestGenericStack;
var
  MyStack: TStack<TMyRec>;
begin
  Writeln('- Test Generic Queue ----------------------------------------------');
  MyStack := TStack<TMyRec>.Create;
  try
    MyStack.Push(TMyRec.Create(3, 'Meier'));
    MyStack.Push(TMyRec.Create(11, 'Müller'));
    MyStack.Push(TMyRec.Create(17, 'Hugentobler'));

    while MyStack.Count > 0 do
      writeln(MyStack.Pop.ToString); // 17,11,3
  finally
    MyStack.Free;
  end;
end;

end.
