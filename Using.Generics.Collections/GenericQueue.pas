unit GenericQueue;

interface

uses
  System.SysUtils, System.Generics.Collections;

procedure TestGenericQueue;

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

procedure TestGenericQueue;
var
  MyQue: TQueue<TMyRec>;
begin
  Writeln('- Test Generic Queue ----------------------------------------------');
  MyQue := TQueue<TMyRec>.Create;
  try
    MyQue.Enqueue(TMyRec.Create(3, 'Meier'));
    MyQue.Enqueue(TMyRec.Create(11, 'Müller'));
    MyQue.Enqueue(TMyRec.Create(17, 'Hugentobler'));

    while MyQue.Count > 0 do
      writeln(MyQue.Dequeue.ToString); // 3,11,17
  finally
    MyQue.Free;
  end;
end;

end.
