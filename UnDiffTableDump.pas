unit UnDiffTableDump;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, DB, ADODB, IniFiles,
  Mask, ToolEdit, Grids, DBGrids, DBCtrls, DosCommand, FileCtrl, Outline,
  DirOutln, ShellCtrls, Menus, ImgList, ToolWin;

type LeituraArquivoIni = (LerString, EscString, LerInteger, EscInteger);

type
  TFmTableDiff = class(TForm)
    pcControle: TPageControl;
    TsDiffDados: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EdPath: TEdit;
    SpeedButton1: TSpeedButton;
    Conexao1: TADOConnection;
    Query: TADOQuery;
    Conexao2: TADOConnection;
    gbSalvarComo: TGroupBox;
    Label12: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    EdPathOut: TEdit;
    BtnPathOut: TSpeedButton;
    BtnExecutar: TBitBtn;
    EdOut: TMemo;
    GroupBox4: TGroupBox;
    ckRapidaCompracao: TCheckBox;
    Panel1: TPanel;
    gbServidor1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdServidor1: TEdit;
    EdUsuario1: TEdit;
    EdSenha1: TEdit;
    btnConectar1: TBitBtn;
    gbServidor2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EdServidor2: TEdit;
    EdUsuario2: TEdit;
    EdSenha2: TEdit;
    btnConectar2: TBitBtn;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Bevel1: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    btnTabela1: TSpeedButton;
    btnTabela2: TSpeedButton;
    EdTabela1: TComboBox;
    EdTabela2: TComboBox;
    EdBanco1: TComboBox;
    EdBanco2: TComboBox;
    TsDiffSchema: TTabSheet;
    GridSchema: TDBGrid;
    BitBtn1: TBitBtn;
    dsQuerySchema: TDataSource;
    QuerySchema: TADOQuery;
    DBText1: TDBText;
    DBText2: TDBText;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    btnGerarScripts: TBitBtn;
    tsGerarScripts: TTabSheet;
    tsMigration: TTabSheet;
    pcFlyway: TPageControl;
    tsProjeto: TTabSheet;
    tsComandos: TTabSheet;
    GroupBox3: TGroupBox;
    lbPathProjeto: TLabel;
    rgProjeto: TRadioGroup;
    EdDirProjetoMigration: TDirectoryEdit;
    OpenDialog2: TOpenDialog;
    ToolBar1: TToolBar;
    tbTest: TToolButton;
    tbInfo: TToolButton;
    tbDrop: TToolButton;
    tbCompile: TToolButton;
    ilBarraBotoes: TImageList;
    tbMigrate: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    tsSelecao: TTabSheet;
    ShellListView1: TShellListView;
    ShellComboBox1: TShellComboBox;
    btnSelectFileSql: TBitBtn;
    PlNavegacao: TPanel;
    btnVoltar: TBitBtn;
    btnAvancar: TBitBtn;
    tbSalvarProjeto: TToolButton;
    EdOutFlyway: TMemo;
    procedure btnConectar1Click(Sender: TObject);
    procedure btnConectar2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnTabela1Click(Sender: TObject);
    procedure btnTabela2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BtnPathOutClick(Sender: TObject);
    procedure BtnExecutarClick(Sender: TObject);
    procedure ckRapidaCompracaoClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure GridSchemaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnGerarScriptsClick(Sender: TObject);
    procedure rgProjetoClick(Sender: TObject);
    procedure tsMigrationShow(Sender: TObject);
    procedure btnSelectFileSqlClick(Sender: TObject);
    procedure tsProjetoShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnAvancarClick(Sender: TObject);
    procedure tsSelecaoShow(Sender: TObject);
    procedure tbSalvarProjetoClick(Sender: TObject);
    procedure tbInfoClick(Sender: TObject);
    procedure tbTestClick(Sender: TObject);
    procedure tbCompileClick(Sender: TObject);
    procedure tbMigrateClick(Sender: TObject);
    procedure tbDropClick(Sender: TObject);

  private
    FNumVersaoScript: Integer;
    { Private declarations }
    procedure montaConexao(Servidor, senha, Banco: String; componenteConexao:TAdoConnection);
    procedure listaBancos(componente:TComboBox; conexao:TADOConnection);
    function iif(Valor             : boolean;
             RetornoVerdadeiro : variant;
             RetornoFalso      : variant) : variant;
    function LerConfiguracoes(Modo    : LeituraArquivoIni ;
                          Arquivo : string ;
                          Chave   : string ;
                          Campo   : string ;
                          Padrao  : variant;
                          PastaConfig : string ='') : variant;
    procedure listaTabelasBanco(Servidor, senha, Banco: String; componenteConexao:TAdoConnection; componente: TComboBox);
    procedure AlteraCursor(Cursor:TCursor = crDefault);
    procedure GetDosOutput(CommandLine: string; memo:TMemo; Work: string = 'C:\');
    procedure habilitarBotoesNavegacao;

   function criaFormularioDinamico(nomeFormulario:String;descricaoDosCampos:Array of string; NumeroComponente:Integer; larguraForm:Integer =200; AlturaForm:Integer= 150):TStringList; overload;
   function criaFormularioDinamico(nomeFormulario:String;descricaoDosCampos,valoresDosCampos:Array of string; NumeroComponente:Integer; larguraForm:Integer =200; AlturaForm:Integer= 150):TStringList; overload;
   function CriaSubDir(Dir: string; NomeSubDir: string): boolean;

  public
    { Public declarations }
    property NumVersaoScript:Integer read FNumVersaoScript write FNumVersaoScript;
  end;

var
  FmTableDiff: TFmTableDiff;

const
  CREATE_PROJECT_MAVEN = 'cmd /k mvn archetype:create -DarchetypeGroupId=org.apache.maven.archetypes -DgroupId=%s -DartifactId=%s';
  TEST_PROJECT = 'cmd /k mvn test';
  INFO_PROJECT = 'cmd /k mvn flyway:info ';
  COMPILE_PROJECT =  'cmd /k mvn compile';
  START_MIGRATE   =  'cmd /k mvn compile flyway:migrate';
  DROP_ALL        =  'cmd /k mvn flyway:clean';

  //cd "Meus Projetos\Desenvolvimento"
  //param 1 - com.mycompany.app
  //param 2 - my-app


implementation

{$R *.dfm}

//function PegarSaidaDOS(Comando, DiretorioTrabalho: string): string;
//var
//saSegunranca: TSecurityAttributes;
//siInformacoesInicializacao: TStartupInfo;
//piInformacaoDoProcesso: TProcessInformation;
//hLeitura, hEscrita: THandle;
//bOk, bHandle: Boolean;
//Buffer: array[0..255] of AnsiChar;
//BytesLidos: Cardinal;
//Diretorio: string;
//begin
//Result := '';
//with saSegunranca do
//begin
//nLength := SizeOf(saSegunranca);
//bInheritHandle := True;
//lpSecurityDescriptor := nil;
//end;
//CreatePipe(hLeitura, hEscrita, @saSegunranca, 0);
//try
//with siInformacoesInicializacao do
//begin
//FillChar(siInformacoesInicializacao, SizeOf(siInformacoesInicializacao), 0);
//cb := SizeOf(siInformacoesInicializacao);
//dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
//wShowWindow := SW_Hide;
//hStdInput := GetStdHandle(STD_INPUT_HANDLE);
//hStdOutput := hEscrita;
//hStdError := hEscrita;
//end;
//Diretorio := DiretorioTrabalho;
//bHandle := CreateProcess(nil, PChar('cmd.exe /c ' + Comando), nil, nil, True, 0, nil,
//PChar(Diretorio), siInformacoesInicializacao, piInformacaoDoProcesso);
//CloseHandle(hEscrita);
//if bHandle then
//begin
//try
//repeat
//application.ProcessMessages;
//bOk := ReadFile(hLeitura, Buffer, 255, BytesLidos, nil);
//if BytesLidos > 0 then
//begin
//Buffer[BytesLidos] := #0;
//Result := Result + Buffer;
//end;
//until not bOk or (BytesLidos = 0);
//WaitForSingleObject(piInformacaoDoProcesso.hProcess, INFINITE);
//finally
//CloseHandle(piInformacaoDoProcesso.hThread);
//CloseHandle(piInformacaoDoProcesso.hProcess);
//end;
//end;
//finally
//CloseHandle(hLeitura);
//end;
//end;

procedure TFmTableDiff.listaTabelasBanco(Servidor, senha, Banco: String; componenteConexao:TAdoConnection; componente: TComboBox);
begin
    montaConexao(Servidor, Senha, Banco,componenteConexao);
    with query do begin
         close;
         Connection := componenteConexao;
         sql.clear;
         sql.add('select * from INFORMATION_SCHEMA.tables where table_type = ''base table''');
         open;
    end;
    componente.Clear;
    while not query.Eof do begin
          componente.Items.Add(query.fieldbyName('table_name').asString);
      query.Next;
    end;

end;


procedure TFmTableDiff.btnConectar1Click(Sender: TObject);
begin
     montaConexao(EdServidor1.Text, EdSenha1.Text, '',Conexao1);

     listaBancos(edBanco1,Conexao1);

     EdBanco1.Enabled   := True;
     EdTabela1.Enabled  := True;
     btnTabela1.Enabled := True;

     MessageDlg('Você está Conectado!',mtInformation,[mbOK],0);

end;

procedure TFmTableDiff.btnConectar2Click(Sender: TObject);
begin
     montaConexao(EdServidor2.Text, EdSenha2.Text, '',Conexao2);

     listaBancos(edBanco2,Conexao2);

     EdBanco2.Enabled   := True;
     EdTabela2.Enabled  := True;
     btnTabela2.Enabled := True;

     MessageDlg('Você está Conectado!',mtInformation,[mbOK],0);

end;

procedure TFmTableDiff.listaBancos(componente: TComboBox; conexao:TADOConnection);
begin
  with query do
  begin
    Connection := Conexao;
    close;
    sql.clear;
    sql.add('sp_helpdb');
    open;
  end;
  componente.Clear;
  while not query.Eof do
  begin
    componente.Items.Add(query.fieldbyName('name').asString);
    query.Next;
  end;

end;

procedure TFmTableDiff.montaConexao(Servidor, senha, Banco: String; componenteConexao:TAdoConnection);
begin
     if banco = '' then
        banco:='master';
     componenteConexao.Connected:=false;
     componenteConexao.ConnectionString := '';
     componenteConexao.ConnectionString := 'Provider=SQLOLEDB.1;Password='+Senha+';Persist Security Info=True;User ID=sa;Initial Catalog='+banco+';Data Source='+servidor;
     componenteConexao.Connected:=true;
end;

procedure TFmTableDiff.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LerConfiguracoes(EscString,'Config','Path','TableDiff',EdPath.Text);
  LerConfiguracoes(EscString,'Config','Path','Output',EdPathOut.Text);
  //salvando dados server 1
  LerConfiguracoes(EscString,'Config','Server1','Servidor',EdServidor1.Text);
  LerConfiguracoes(EscString,'Config','Server1','Usuario',EdUsuario1.Text);
  LerConfiguracoes(EscString,'Config','Server1','Senha',EdSenha1.Text);
  //salvando dados server 2
  LerConfiguracoes(EscString,'Config','Server2','Servidor',EdServidor2.Text);
  LerConfiguracoes(EscString,'Config','Server2','Usuario',EdUsuario2.Text);
  LerConfiguracoes(EscString,'Config','Server2','Senha',EdSenha2.Text);

end;

function TFmTableDiff.LerConfiguracoes(Modo    : LeituraArquivoIni ;
                          Arquivo : string ;
                          Chave   : string ;
                          Campo   : string ;
                          Padrao  : variant;
                          PastaConfig : string ='') : variant;
var stgArquivo : string;
begin
result:=Padrao;

stgArquivo:=iif(PastaConfig='',ExtractFilePath(ParamStr(0))+'',PastaConfig);
stgArquivo:=stgArquivo+'\'+Arquivo+'.ini';

if not fileexists(stgArquivo) then
   with TStringList.Create do
      try
         SaveToFile(stgArquivo);
      finally
         free;
      end;

with TIniFile.create(stgArquivo) do
   try
      if not ValueExists(Chave,Campo) then
         begin
         if (Modo=LerString) or (Modo=EscString) then
            WriteString(Chave,Campo,Padrao)
         else if (Modo=LerInteger) or (Modo=EscInteger) then
            ReadInteger(Chave,Campo,Padrao);
      end;

      if Modo=LerString then
         result:=ReadString(Chave,Campo,Padrao)
      else if Modo=EscString then
         WriteString(Chave,Campo,Padrao)
      else if Modo=LerInteger then
         result:=ReadInteger(Chave,Campo,Padrao)
      else if Modo=EscInteger then
         WriteInteger(Chave,Campo,Padrao);
   finally
      free;
   end;
end;


function TFmTableDiff.iif(Valor             : boolean;
             RetornoVerdadeiro : variant;
             RetornoFalso      : variant) : variant;
begin
if Valor then
   result:=RetornoVerdadeiro
else
   result:=RetornoFalso;
end;


procedure TFmTableDiff.FormCreate(Sender: TObject);
begin
  EdPath.Text    := LerConfiguracoes(LerString,'Config','Path','TableDiff','');
  EdPathOut.Text := LerConfiguracoes(LerString,'Config','Path','Output','');
  //salvando dados server 1
  EdServidor1.Text := LerConfiguracoes(LerString,'Config','Server1','Servidor','');
  EdUsuario1.Text  := LerConfiguracoes(LerString,'Config','Server1','Usuario','');
  EdSenha1.Text    := LerConfiguracoes(LerString,'Config','Server1','Senha','');
  //salvando dados server 2
  EdServidor2.Text := LerConfiguracoes(LerString,'Config','Server2','Servidor','');
  EdUsuario2.Text  := LerConfiguracoes(LerString,'Config','Server2','Usuario','');
  EdSenha2.Text    := LerConfiguracoes(LerString,'Config','Server2','Senha','');

  pcControle.ActivePageIndex := 0;
end;

procedure TFmTableDiff.btnTabela1Click(Sender: TObject);
begin
  listaTabelasBanco(EdServidor1.Text, EdSenha1.Text, EdBanco1.Text, Conexao1, EdTabela1);
end;

procedure TFmTableDiff.btnTabela2Click(Sender: TObject);
begin
  listaTabelasBanco(EdServidor2.Text, EdSenha2.Text, EdBanco2.Text, Conexao2, EdTabela2);
end;

procedure TFmTableDiff.SpeedButton2Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  EdPathOut.Text := OpenDialog1.InitialDir;

end;

procedure TFmTableDiff.SpeedButton1Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  EdPath.Text := OpenDialog1.FileName;

end;

procedure TFmTableDiff.BtnPathOutClick(Sender: TObject);
begin
  SaveDialog1.Execute;
  EdPathOut.Text:= SaveDialog1.FileName;
end;

procedure TFmTableDiff.BtnExecutarClick(Sender: TObject);
const
  LCmd = ' -sourceserver %s -sourcedatabase %s -sourcetable '+
         '%s -destinationserver %s -destinationdatabase %s -destinationtable %s  %s %s '; //>> c:\out.txt
 //param 1 - [nomeServidorOrigem]
 //param 2 - DataBase Origem
 //param 3 - Tabela A
 //param 4 - [nomeServidorDestino]
 //param 5 - DataBase Destino
 //param 6 - Tabela B
 //param 7 - Parametros do aplicativo
 //param 8 - path output
var
  LComando:string;
  LOpcoes:String;
begin
  EdOut.Lines.Clear;

  AlteraCursor(crHourGlass);
  try
    //opção default.
    LOpcoes:='-f';

    if ckRapidaCompracao.Checked then
      LOpcoes:='-q';

    LComando := '"'+EdPath.Text+'"'+
                Format(LCmd,[EdServidor1.Text,EdBanco1.Text,EdTabela1.Text,
                             EdServidor2.Text,EdBanco2.Text,EdTabela2.Text,
                             LOpcoes,
                             '"'+EdPathOut.Text+'"']);
    if FileExists(EdPathOut.Text+'.sql') then
      DeleteFile(EdPathOut.Text+'.sql');

    GetDosOutput(LComando,EdOut);
  finally
    AlteraCursor(crDefault);
  end;


end;

procedure TFmTableDiff.AlteraCursor(Cursor: TCursor);
begin
   Screen.Cursor := Cursor;
   Application.ProcessMessages;
end;


procedure TFmTableDiff.GetDosOutput(CommandLine: string; memo:TMemo; Work: string = 'C:\');
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  memo.Text := '';
  with SA do begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    Handle := CreateProcess(nil, PChar(CommandLine),
                            nil, nil, True, 0, nil,
                            PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin

            Buffer[BytesRead] := #0;

            EdOutFlyway.Lines.Add(String(Buffer));
            //BytesRead := 0;
            Application.ProcessMessages;
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;


procedure TFmTableDiff.ckRapidaCompracaoClick(Sender: TObject);
begin
  gbSalvarComo.Enabled := not ckRapidaCompracao.Checked;
  if ckRapidaCompracao.Checked then
    EdPathOut.Color := clBlack
  else
    EdPathOut.Color := clWhite;

end;

procedure TFmTableDiff.BitBtn1Click(Sender: TObject);
// param 1 -  Tablename --  '%' for all tables
// param 2 -  Sourcedb.INFORMATION_SCHEMA.COLUMNS
// param 3 -  Destdb.INFORMATION_SCHEMA.COLUMNS

const

  LCmd =
'DECLARE @Tablename varchar(100)                                                                                                                              '+
'                                                                                                                                                             '+
'                                                                                                                                                             '+
'SELECT @Tablename = %s                                                                                                                                       '+
'                                                                                                                                                             '+
' SELECT Tablename  = ISNULL(Source.table_name,Destination.table_name)                                                                                        '+
'                      ,ColumnName = ISNULL(Source.Column_name,Destination.Column_name)                                                                       '+
'                      ,Source.Data_Type                                                                                                                      '+
'                      ,Source.character_maximum_length                                                                                                       '+
'                      ,Source.numeric_precision                                                                                                              '+
'                      ,Source.is_nullable                                                                                                                    '+
'                      ,Destination.Data_Type                                                                                                                 '+
'                      ,Destination.character_maximum_length                                                                                                  '+
'                      ,Destination.numeric_precision                                                                                                         '+
'		                   ,Source.is_nullable                                                                                                                    '+
'                      ,[AnaliseColumn]  =                                                                                                                    '+
'                       Case                                                                                                                                  '+
'                       When Source.Column_name IS NULL then ''a coluna não existe na tabela de origem''                                                      '+
'                       When Destination.Column_name IS NULL then ''A coluna não existe na tabela de destino''                                                '+
'                       ELSE ''''                                                                                                                               '+
'                       end                                                                                                                                   '+
'                      ,AnaliseDataType = CASE WHEN Source.Column_name IS NOT NULL                                                                            '+
'                                        AND Destination.Column_name IS NOT NULL                                                                              '+
'                                        AND Source.Data_Type <> Destination.Data_Type THEN ''o tipo de dados esta diferente''                                '+
'                                  END                                                                                                                        '+
'                      ,AnaliseLength   = CASE WHEN Source.Column_name IS NOT NULL                                                                            '+
'                                        AND Destination.Column_name IS NOT NULL                                                                              '+
'                                        AND Source.character_maximum_length <> Destination.character_maximum_length THEN ''tamanho diferente''               '+
'                                  END                                                                                                                        '+
'                      ,AnalisePrecisao = CASE WHEN Source.Column_name IS NOT NULL                                                                            '+
'                                        AND Destination.Column_name IS NOT NULL                                                                              '+
'                                        AND Source.numeric_precision <> Destination.numeric_precision THEN ''precisão diferente''                            '+
'                                    END                                                                                                                      '+
'                      ,AnaliseCollation = CASE WHEN Source.Column_name IS NOT NULL                                                                           '+
'                                        AND Destination.Column_name IS NOT NULL                                                                              '+
'                                        AND ISNULL(Source.collation_name,'''') <> ISNULL(Destination.collation_name,'''') THEN ''Collation diferente''       '+
'                                        END                                                                                                                  '+
'                      ,AnaliseIs_Nullable = CASE WHEN Source.Column_name IS NOT NULL                                                                         '+
'                                        AND Destination.Column_name IS NOT NULL                                                                              '+
'                                        AND Source.is_nullable <> Destination.is_nullable THEN ''permissão valor nullo diferente''                           '+
'                                  END                                                                                                                        '+
'                                                                                                                                                             '+
'   FROM                                                                                                                                                      '+
' (                                                                                                                                                           '+
' SELECT Table_name  = sc.Table_name                                                                                                                          '+
'      , Column_name = sc.Column_name                                                                                                                         '+
'      , Data_Type   = Sc.Data_type                                                                                                                           '+
'      , character_maximum_length     = Sc.character_maximum_length                                                                                           '+
'      , numeric_precision  = Sc.numeric_precision                                                                                                            '+
'      , collation_name = Sc.collation_name                                                                                                                   '+
'      , is_nullable = Sc.is_nullable                                                                                                                         '+
'                                                                                                                                                             '+
'  FROM %s Sc                                                                                                                                                 '+
'WHERE                                                                                                                                                        '+
'  Sc.table_Name like @Tablename                                                                                                                                      '+
'  ) Source                                                                                                                                                   '+
' FULL OUTER JOIN                                                                                                                                             '+
' (                                                                                                                                                           '+
'  SELECT Table_name = sc.Table_name                                                                                                                          '+
'      , Column_name = sc.Column_name                                                                                                                         '+
'      , Data_Type   = Sc.Data_Type                                                                                                                           '+
'      , character_maximum_length     = Sc.character_maximum_length                                                                                           '+
'      , numeric_precision  = Sc.numeric_precision                                                                                                            '+
'      , collation_name = Sc.collation_name                                                                                                                   '+
'      , is_nullable = Sc.is_nullable                                                                                                                         '+
'  FROM %s Sc                                                                                                                                                 '+
'WHERE                                                                                                                                                        '+
'  Sc.table_Name like @Tablename                                                                                                                                      '+
' ) Destination                                                                                                                                               '+
' ON Source.table_name = Destination.table_name                                                                                                               '+
' AND Source.Column_name = Destination.Column_name                                                                                                            ';

var
  LSource:String;
  LDest:String;
  LTableName:string;
begin
  LSource      := EdBanco1.text + '.INFORMATION_SCHEMA.COLUMNS';
  LDest        := EdBanco2.text + '.INFORMATION_SCHEMA.COLUMNS';


  if (EdTabela1.Text = EdTabela2.Text) then
     LTableName := EdTabela1.Text
  else
  begin
    MessageDlg('O nome da tabela te que ser o mesmo!', mtError,[mbOK],0);
    Exit;
  end;

// param 1 -  Tablename --  '%' for all tables                                                                                                                              NN NN
// param 2 -  Sourcedb.INFORMATION_SCHEMA.COLUMNS
// param 3 -  Destdb.INFORMATION_SCHEMA.COLUMNS
  With QuerySchema do
  begin

    Close;
    Connection := Conexao1;
    Sql.Clear;
    Sql.add(format(LCmd,[QuotedStr(LTableName),LSource,LDest]));
    Sql.SaveToFile('teste.sql');
    Open;
  end;
  
end;

procedure TFmTableDiff.GridSchemaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
    if (QuerySchema.FieldByName ('AnaliseColumn').AsString     <> '')    or
       (QuerySchema.FieldByName ('AnaliseDataType').AsString   <> '')    or
       (QuerySchema.FieldByName ('AnaliseLength').AsString     <> '')    or
       (QuerySchema.FieldByName ('AnalisePrecisao').AsString   <> '')    or
       (QuerySchema.FieldByName ('AnaliseCollation').AsString  <> '')    or
       (QuerySchema.FieldByName ('AnaliseIs_Nullable').AsString<> '')
    then
    begin
      GridSchema.Canvas.Font.Color := clRed;
      //GridSchema.Canvas.Font.Style := [fsBold];
    end;
    //GridSchema.Canvas.FillRect(Rect);
    //GridSchema.DefaultDrawDataCell(Rect, Field, State);
    GridSchema.DefaultDrawDataCell(Rect, GridSchema.columns[datacol].field, State);






end;

procedure TFmTableDiff.btnGerarScriptsClick(Sender: TObject);
const

ADD_CAMPO   = 'ALTER TABLE %s ADD %s ';
ALTER_CAMPO = 'ALTER TABLE %s ALTER COLUMN %s %s %s';
//ALTER TABLE objetos ALTER COLUMN campo1 varchar(10) not null
// param 1 - nome tabela
// param 2 - nome coluna

// param 3 - tipo coluna
// param 3 - tamanho
// param 4 - not null/ null
var
  LScript:TStringList;
  LNullable:string;
  LDataType:string;
  LLength:string;
  LPrecisao:string;
  LCollation:string;
  LColuna:string;
  LAlter:Integer;
begin
  LAlter := 0;
  LScript := TStringList.Create;


  QuerySchema.First;
  while not QuerySchema.Eof do
  begin
    LNullable  := 'NULL';
    LDataType  := QuerySchema.FieldByName('Data_Type').AsString;
    LLength    := QuerySchema.FieldByName('character_maximum_length').AsString;
    LPrecisao  := QuerySchema.FieldByName('numeric_precision').AsString;
    LCollation := QuerySchema.FieldByName('numeric_precision').AsString;
    LColuna    := QuerySchema.FieldByName('ColumnName').AsString;
    if (QuerySchema.FieldByName ('AnaliseIs_Nullable').AsString <> '') then
    begin
      LNullable := 'NOT NULL';
      LAlter    := 1;
    end;

    IF (QuerySchema.FieldByName ('AnalisePrecisao').AsString <> '') then
    begin
      LPrecisao := '[DIGITE O TAMANHO CORRETO]';
      LAlter    := 1;
    end;

    if (QuerySchema.FieldByName ('AnaliseLength').AsString <> '') then
    begin
      LLength := '([DIGITE O TAMANHO CORRETO])';
      LAlter  := 1;
    end;

    if (QuerySchema.FieldByName ('AnaliseDataType').AsString   <> '') then
    begin
      
//      if LPrecisao <> '' then
//        LPrecisao := ','+LPrecisao;
//
//      if LLength <> '' then
//        LDataType := LDataType + '(' + LLength + LPrecisao + ')';
      LDataType := '[DIGITE O DATA_TYPE CORRETO]';
      LAlter:=1;
    end;


    if (QuerySchema.FieldByName ('AnaliseCollation').AsString  <> '') then
    begin
      LCollation := '([DIGITE O COLLATION CORRETO])';
      LAlter:=1;
    end;

    if (QuerySchema.FieldByName ('AnaliseColumn').AsString     <> '') then
    begin
      LColuna:= QuerySchema.FieldByName('ColumnName').AsString + ' ' +
                QuerySchema.FieldByName('Data_Type').AsString;
      if QuerySchema.FieldByName('character_maximum_length').AsString <> '' then
        LColuna := LColuna + '(' + QuerySchema.FieldByName('character_maximum_length').AsString + ')';
        
      LAlter := 2;
    end;

    if LAlter = 1 then
    begin
      LScript.Add(Format(ALTER_CAMPO,[QuerySchema.FieldByName('TableName').AsString,
                                      LColuna,
                                      LDataType,
                                      LNullable]));
      LAlter := 0;
    end
    else if LAlter = 2 then
    begin
      LScript.Add(Format(ADD_CAMPO,[QuerySchema.FieldByName('TableName').AsString,
                                      LColuna
                                      ]));
      LAlter := 0;
    end;

    QuerySchema.Next;
  end;
  LScript.SaveToFile('Scripts.sql');
  FreeAndNil(LScript);
end;

procedure TFmTableDiff.rgProjetoClick(Sender: TObject);
begin
   case rgProjeto.ItemIndex of
     0: lbPathProjeto.Caption := 'Salvar Projeto em:';
     1: lbPathProjeto.Caption := 'Abrir Projeto em:'
   end;
end;

procedure TFmTableDiff.tsMigrationShow(Sender: TObject);
begin
  pcFlyway.ActivePageIndex := 0;
end;

procedure TFmTableDiff.btnSelectFileSqlClick(Sender: TObject);
var
  LFile:string;
  LFileDestino:string;
  i:Integer;
  isCopy:Boolean;
begin
  OpenDialog2.Execute;

  for i:= 0 to OpenDialog2.Files.Count - 1 do
  begin
    Inc(FNumVersaoScript);
    LFile        := OpenDialog2.Files[i];
    LFileDestino := ShellComboBox1.Root + '\' + 'V' + IntToStr(FNumVersaoScript) +'__'+ExtractFileName(LFile);
   isCopy:= CopyFile(PAnsiChar(LFile), PAnsiChar(LFileDestino) ,False);
   if isCopy then
     ShellListView1.Refresh
   else
     ShowMessage('Não foi possivel copiar o arquivo para ' + LFileDestino);
  end;

end;

procedure TFmTableDiff.tsProjetoShow(Sender: TObject);
begin
  btnVoltar.Enabled := False;
  
end;

procedure TFmTableDiff.btnVoltarClick(Sender: TObject);
begin
 pcFlyway.ActivePageIndex := pcFlyway.ActivePageIndex - 1;
 habilitarBotoesNavegacao;

end;

procedure TFmTableDiff.btnAvancarClick(Sender: TObject);
begin
  if rgProjeto.ItemIndex = 0 then
  begin
    pcFlyway.ActivePageIndex := 2;
  end
  else
  begin
    if pcFlyway.ActivePageIndex < pcFlyway.PageCount - 1 then
      pcFlyway.ActivePageIndex := pcFlyway.ActivePageIndex + 1;
  end;

  habilitarBotoesNavegacao;
end;

procedure TFmTableDiff.habilitarBotoesNavegacao;
begin
 btnAvancar.Enabled :=  pcFlyway.ActivePageIndex < pcFlyway.PageCount - 1;
 btnVoltar.Enabled :=  pcFlyway.ActivePageIndex > 0

end;

procedure TFmTableDiff.tsSelecaoShow(Sender: TObject);
begin
 if EdDirProjetoMigration.EditText <> '' then
 begin
   ShellListView1.Root := EdDirProjetoMigration.EditText;
   ShellListView1.Refresh;
 end;

end;

procedure TFmTableDiff.tbSalvarProjetoClick(Sender: TObject);
var
  LDados:TStringList;
  LParamName:Array [0..1] of string;
  LCommand:string;
begin
  try
    AlteraCursor(crHourGlass);
    LParamName[0]:= 'com.meudominio.com';
    LParamName[1]:= 'Nome Projeto';
    LDados := criaFormularioDinamico('Entrada de Parametros',LParamName,2);

    if LDados.count = 0 then
    begin //clicou em cancelar aborte a operacao.
      FreeAndNil(LDados);
      abort;

    end;
    SetCurrentDir(EdDirProjetoMigration.Text);
    LCommand := Format(CREATE_PROJECT_MAVEN,[LDados[0],
                                             LDados[1]]);

    GetDosOutput(LCommand,EdoutFlyway,GetCurrentDir);

    if Pos('SUCCESS',EdoutFlyway.Text) > 0 then
    begin
      CriaSubDir(EdDirProjetoMigration.Text + '\' + LDados[1] + '\src\main','resources',);
      Sleep(2000);
      CriaSubDir(EdDirProjetoMigration.Text + '\' + LDados[1] + '\src\main\resources', 'db');
      Sleep(2000);
      CriaSubDir(EdDirProjetoMigration.Text + '\' + LDados[1] + '\src\main\resources\db', 'migration');
      ShowMessage('Projeto Criado com Sucesso. Favor Adicione os Arquivos de Scripts');
      pcFlyway.ActivePageIndex := 1;
      ShellListView1.Root := EdDirProjetoMigration.Text + '\' + LDados[1] + '\src\main\resources\db\migration';
    end;
  finally
    AlteraCursor(crDefault);
  end;


end;

function TFmTableDiff.criaFormularioDinamico(nomeFormulario: String;
  descricaoDosCampos: array of string; NumeroComponente, larguraForm,
  AlturaForm: Integer): TStringList;
var
  Form: TForm; { Variável para o Form }
  Edt: TEdit;  { Variável para o Edit }
  i:Integer;
  distanciaLabel,
  distanciaEdit,
  distanciaBotao:Integer;
  dados:TStringList;
begin
  distanciaLabel :=0;
  distanciaEdit  :=0;
  distanciaBotao :=0;

  { Cria o form }
  Form := TForm.Create(Application);
  try
  { Altera algumas propriedades do Form }
  Form.BorderStyle := bsDialog;
  Form.Caption := nomeFormulario;
  Form.Position := poScreenCenter;
  Form.Width := larguraForm;
  Form.Height := AlturaForm;
  for i:=1 to NumeroComponente do begin
        { Coloca um Label }
        with TLabel.Create(Form) do begin
        Parent := Form;
        Caption := descricaoDosCampos[i-1];
        Left := 10;
        Top := 10+distanciaLabel+distanciaEdit;
        end;
        { Coloca o Edit }
        Edt := TEdit.Create(Form);
        with Edt do begin
        Parent := Form;
        Left := 10;
        Top := 25+distanciaEdit+distanciaLabel;
        { Ajusta o comprimento do Edit de acordo com a largura do form }
        Width := Form.ClientWidth - 20;
        end;
        distanciaEdit  := distanciaEdit +20;
        distanciaLabel := distanciaLabel+20;

        distanciaBotao := distanciaBotao+20;
  end;
  { Coloca o botão OK }
  with TBitBtn.Create(Form) do begin
  Parent := Form;
  { Posiciona de acordo com a largura do form }
  Left := Form.ClientWidth - (Width * 2) - 20;
  Top := 80+distanciaBotao;
  Kind := bkOK; { Botão Ok }
  Align:=alBottom;
  end;
  { Coloca o botão Cancel }
  with TBitBtn.Create(Form) do begin
  Parent := Form;
  Left := Form.ClientWidth - Width - 10;
  Top := 80+distanciaBotao;
  Kind := bkCancel; { Botão Cancel }
  Align:=alBottom;
  end;
  Form.Width := larguraForm;
  Form.Height := alturaForm+(30*numeroComponente);

  { Exibe o form e aguarda a ação do usuário. Se for OK... }
  dados := TStringList.Create;
  if Form.ShowModal = mrOK then begin
     With dados do begin
          for i:=0 to (form.ComponentCount -1) do begin
              if (form.components[I] is TEdit) then
                  add((form.components[I] as TEdit).Text);
          end;

     end;
     result:=dados;
  end
  else begin
     Result := dados;
  end;
  finally
  FreeAndNil(Form);


  end;

end;

function TFmTableDiff.criaFormularioDinamico(nomeFormulario: String;
  descricaoDosCampos, valoresDosCampos: array of string; NumeroComponente,
  larguraForm, AlturaForm: Integer): TStringList;
var
  Form: TForm; { Variável para o Form }
  Edt: TEdit;  { Variável para o Edit }
  i:Integer;
  distanciaLabel,
  distanciaEdit,
  distanciaBotao:Integer;
  dados:TStringList;
begin
  distanciaLabel :=0;
  distanciaEdit  :=0;
  distanciaBotao :=0;

  { Cria o form }
  Form := TForm.Create(Application);
  try
  { Altera algumas propriedades do Form }
  Form.BorderStyle := bsDialog;
  Form.Caption := nomeFormulario;
  Form.Position := poScreenCenter;
  Form.Width := larguraForm;
  Form.Height := AlturaForm;
  for i:=1 to NumeroComponente do begin
        { Coloca um Label }
        with TLabel.Create(Form) do begin
        Parent := Form;
        Caption := descricaoDosCampos[i-1];
        Left := 10;
        Top := 10+distanciaLabel+distanciaEdit;
        end;
        { Coloca o Edit }
        Edt := TEdit.Create(Form);
        with Edt do begin
            Parent := Form;
            Left := 10;
            Top := 25+distanciaEdit+distanciaLabel;
            { Ajusta o comprimento do Edit de acordo com a largura do form }
            Width := Form.ClientWidth - 20;
            text  := valoresDosCampos[i-1];
        end;
        distanciaEdit  := distanciaEdit +20;
        distanciaLabel := distanciaLabel+20;

        distanciaBotao := distanciaBotao+20;
  end;
  { Coloca o botão OK }
  with TBitBtn.Create(Form) do begin
  Parent := Form;
  { Posiciona de acordo com a largura do form }
  Left := Form.ClientWidth - (Width * 2) - 20;
  Top := 80+distanciaBotao;
  Kind := bkOK; { Botão Ok }
  Align:=alBottom;
  end;
  { Coloca o botão Cancel }
  with TBitBtn.Create(Form) do begin
  Parent := Form;
  Left := Form.ClientWidth - Width - 10;
  Top := 80+distanciaBotao;
  Kind := bkCancel; { Botão Cancel }
  Align:=alBottom;
  end;
  Form.Width := larguraForm;
  Form.Height := alturaForm+(30*numeroComponente);

  { Exibe o form e aguarda a ação do usuário. Se for OK... }
  dados := TStringList.Create;
  if Form.ShowModal = mrOK then begin
     With dados do begin
          for i:=0 to (form.ComponentCount -1) do begin
              if (form.components[I] is TEdit) then
                  add((form.components[I] as TEdit).Text);
          end;

     end;
  Result := dados;
  end
  else begin
     Result := dados;
  end;
  finally
  FreeAndNil(Form);


  end;

end;

procedure TFmTableDiff.tbInfoClick(Sender: TObject);
begin
  try
    AlteraCursor(crHourGlass);
//    GetDosOutput(INFO_PROJECT,EdoutFlyway,GetCurrentDir);
    WinExec(INFO_PROJECT,SW_SHOWNORMAL);
  finally
    AlteraCursor(crDefault);
  end;

end;

function TFmTableDiff.CriaSubDir(Dir, NomeSubDir: string): boolean;
var
  Caminho: string;
begin
  Caminho := dir + '\' + NomeSubDir;
  if DirectoryExists(Caminho) then
    Result := true
  else
    Result := CreateDir(Caminho);

end;

procedure TFmTableDiff.tbTestClick(Sender: TObject);
begin
  try
    AlteraCursor(crHourGlass);
    GetDosOutput(TEST_PROJECT,EdoutFlyway,GetCurrentDir);

    if Pos('SUCCESS',EdoutFlyway.Text) > 0 then
    begin
       ShowMessage('Teste Executado com Sucesso!');
    end
    Else
    begin
       ShowMessage('Desculpe, Seu teste Falhou, para detalhes veja a saída');
    end;
  finally
    AlteraCursor(crDefault);
  end;
end;

procedure TFmTableDiff.tbCompileClick(Sender: TObject);
begin
  try
    AlteraCursor(crHourGlass);
    GetDosOutput(COMPILE_PROJECT,EdoutFlyway,GetCurrentDir);

    if Pos('SUCCESS',EdoutFlyway.Text) > 0 then
    begin
       ShowMessage('Compilação Executada com Sucesso!');
    end
    Else
    begin
       ShowMessage('Desculpe, Sua compilação Falhou, para detalhes veja a saída');
    end;
  finally
    AlteraCursor(crDefault);
  end;

end;

procedure TFmTableDiff.tbMigrateClick(Sender: TObject);
begin
  try
    AlteraCursor(crHourGlass);
    GetDosOutput(START_MIGRATE,EdoutFlyway,GetCurrentDir);

    if Pos('SUCCESS',EdoutFlyway.Text) > 0 then
    begin
       ShowMessage('Migração realizada com Sucesso!');
    end
    Else
    begin
       ShowMessage('Desculpe, Sua Migração Falhou, para detalhes veja a saída');
    end;
  finally
    AlteraCursor(crDefault);
  end;

end;

procedure TFmTableDiff.tbDropClick(Sender: TObject);
begin
  try
    AlteraCursor(crHourGlass);
    GetDosOutput(DROP_ALL,EdoutFlyway,GetCurrentDir);

    if Pos('SUCCESS',EdoutFlyway.Text) > 0 then
    begin
       ShowMessage('Base de dados limpa realizada com Sucesso!');
    end
    Else
    begin
       ShowMessage('Desculpe, Sua operação Falhou, para detalhes veja a saída');
    end;
  finally
    AlteraCursor(crDefault);
  end;

end;

end.
