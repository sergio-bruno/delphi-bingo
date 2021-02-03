unit clsBD; //configuração de Bando de Dados

interface

uses Windows, Forms, Classes, Sysutils, IBQuery, IBTable, Ibdatabase, Db;

type
  TBD = class(TObject)
  private
    FRetorno: integer;
    Mensagens: array[-1..1] of string;
    IBTable1: TIBTable;
    IBTransaction1: TIBTransaction;
    function PegaMensagem: string;
    function ConectaBanco(var _Texto: string): boolean;
  public
    constructor Create;
    destructor Destroy;
    function Executa(var _Texto: string): boolean;
    property Retorno: integer read FRetorno;
    property Mensagem: string read PegaMensagem;
 end;

implementation

uses Dados, InfoProgresso, clsControladorArqCfg;

{ TBD }

function TBD.ConectaBanco(var _Texto: string): boolean;
var oControladorArqCfg: TControladorArqCfg;
    ArquivoDados: string;
begin
  Result := True;
  if not FileExists('BingoControl.conf') then
    Result := False
  else
  begin
    oControladorArqCfg := TControladorArqCfg.Create('BingoControl.conf');
    try
      ArquivoDados := oControladorArqCfg.InformaValor('DADOS', 'ARQUIVO DADOS');
      dmDados.IBDatabase.DatabaseName := ArquivoDados;
      try
        dmDados.IBDatabase.Connected := True;
        _Texto := ArquivoDados;
      except
        Result := False;
        FRetorno := -1;
        _Texto := '';
      end;
    finally
      oControladorArqCfg.free;
    end;
  end
end;

constructor TBD.Create;
begin
  FRetorno := 0;
  Mensagens[1]  := 'OK';
  Mensagens[0]  := 'Não executado.';
  Mensagens[-1] := 'Não conectou banco de dados.';
  IBTable1  := TIBTable.Create(nil);
  IBTransaction1 := TIBTransaction.Create(nil);

  Application.CreateForm(TdmDados, dmDados);
  IBTable1.Database := dmDados.IBDatabase;
  IBTable1.Transaction := IBTransaction1;
  IBTransaction1.DefaultDatabase := dmDados.IBDatabase;

  inherited Create;
end;

destructor TBD.Destroy;
begin
  IBTable1.Free;
  IBTransaction1.Free;
  dmDados.Free;
  inherited Destroy;
end;

function TBD.Executa(var _Texto: string): boolean;
begin
  Result := False;
  Application.CreateForm(TfrmInfoProgresso, frmInfoProgresso);
  frmInfoProgresso.Show;
  Application.ProcessMessages;
  try
    frmInfoProgresso.lblMensagem.Caption := 'Conectando banco de dados...';
    Application.ProcessMessages;
    Result := ConectaBanco(_Texto);
    if Result = False then
      exit;
    {aqui outras verificações}
  finally
    frmInfoProgresso.Free;
  end;                          
end;

function TBD.PegaMensagem: string;
begin
  Result := Mensagens[FRetorno];
end;

end.
