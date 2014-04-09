unit GenerateInsert;

interface

uses AcaoIF, ADODB, DB, Classes, ComObj;

const
 INSERT = 'INSERT INTO %s (%s) VALUES (%s)';

type
  TFieldGenerate = class
  private
    FIsIdentity: Boolean;
    FFieldName: String;
    FFieldType: String;

  public
    property fieldName:String read FFieldName write FFieldName;
    property fieldType:String read FFieldType write FFieldType;
    property isIdentity:Boolean read FIsIdentity write FIsIdentity;

end;
// (dataset.FieldByName('column_name').AsString);
type
  TGenerateInsert = class (TInterfacedObject,TAcaoIF)

  private
    FTableName: String;
    FDataSet: TADOQuery;

    function getFields(nameTable:String):TList;


  public
    property tableName:String read FTableName write FTableName;
    property dataset:TADOQuery read FDataSet write FDataSet;

    procedure doExecute;

end;

implementation

{ TGenerateInsert }


procedure TGenerateInsert.doExecute;
var
  LFieldList:TList;
  i:Integer;
  LScript:TStringList;
begin
  LScript:=TStringList.Create;

  LFieldList:= getFields(tableName);
  for i := 0 to LFieldList.Count - 1 do
  begin
//    LScript.Add(Format(INSERT, [tableName, TFieldGenerate(LFieldList[i]).fieldName, formatFieldType(valorCampo, TFieldGenerate(LFieldList[i]).FFieldType) ] ));

  end;
end;

function TGenerateInsert.getFields(nameTable:String):TList;
var
  LField:TFieldGenerate;
  LFieldList:TList;
begin
  LField:=TFieldGenerate.Create;
  LFieldList:=TList.Create;

  dataset.Close;
  dataset.SQL.Clear;
  dataset.sql.Add('sp_help '+ nameTable);
  dataset.Open;

  dataset.First;
  while not dataset.Eof do
  begin
    LField.FFieldName := dataset.FieldByName('column_name').AsString;
    LField.fieldType  := dataset.FieldByName('Type').AsString;
    LField.isIdentity := False;
    LFieldList.Add(LField);
    dataset.Next;
  end;

  result:= LFieldList;
end;

end.
