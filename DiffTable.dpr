program DiffTable;

uses
  Forms,
  UnDiffTableDump in 'UnDiffTableDump.pas' {FmTableDiff},
  AcaoIF in 'AcaoIF.pas',
  GenerateInsert in 'GenerateInsert.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFmTableDiff, FmTableDiff);
  Application.Run;
end.
