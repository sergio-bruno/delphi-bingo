unit clsSORTEIOS;

interface

uses Classes, Sysutils, IBQuery, Ibdatabase, Db, Variants;

type
  TSORTEIOS = class(TObject)
  protected
    FCodigo: integer;
    FNumeroLoop: integer;
    FNomeSorteio: string;
    FCodLocal: integer;
    FData: TDateTime;
    FHora: TDateTime;
    FPrecoCartela: double;
    FApoio: string;
    FDataCadastro: TDateTime;
    function PodeExcluir: boolean;
    function InformaParametros(SQL: TStrings): TParams;
  public
    constructor Create;
    destructor Destroy; override;
    function Incluir: boolean;
    function Gravar: boolean;
    function Ler: boolean;
    function Excluir: boolean;
    procedure MontaSQLIncluir(IBQuery: TIBQuery);
    procedure MontaSQLGravar(IBQuery: TIBQuery);
    procedure MontaSQLExcluir(IBQuery: TIBQuery);
    function TemValoresIguais(UmaInstancia: TSORTEIOS): boolean;
    function InformaQtdSorteios: integer;

    property Codigo: integer read FCodigo write FCodigo;
    property NumeroLoop: integer read FNumeroLoop write FNumeroLoop;
    property NomeSorteio: string read FNomeSorteio write FNomeSorteio;
    property CodLocal: integer read FCodLocal write FCodLocal;
    property Data: TDateTime read FData write FData;
    property Hora: TDateTime read FHora write FHora;
    property PrecoCartela: double read FPrecoCartela write FPrecoCartela;
    property Apoio: string read FApoio write FApoio;
    property DataCadastro: TDateTime read FDataCadastro write FDataCadastro;
  end;

implementation

uses Dados;

constructor TSORTEIOS.Create;
begin
  FCodigo := 0;
  FNumeroLoop := 0;
  FNomeSorteio := '';
  FCodLocal := 0;
  FData := 0;
  FHora := 0;
  FPrecoCartela := 0;
  FApoio := '';
  FDataCadastro := 0;

  inherited Create;
end;

destructor TSORTEIOS.Destroy;
begin
  inherited Destroy;

end;

function TSORTEIOS.Incluir: boolean;
var IBQuery: TIBQuery;
    IBTransaction: TIBTransaction;
begin
  Result := False;
  IBQuery := TIBQuery.Create(nil);
  IBTransaction := TIBTransaction.Create(nil);
  try
    IBQuery.Database := dmDados.IBDatabase;
    IBQuery.Transaction := IBTransaction;
    IBTransaction.DefaultDatabase := dmDados.IBDatabase;
    IBTransaction.Params.Add('read_committed');
    IBTransaction.Params.Add('rec_version');
    IBTransaction.Params.Add('nowait');
    //obtenção da próxima chave primária
    IBQuery.SQL.Add('SELECT MAX(CODIGO) FROM SORTEIOS');
    IBQuery.Open;
    FCODIGO := IBQuery.Fields[0].AsInteger + 1;
    //FIM obtenção da próxima chave primária

    MontaSQLIncluir(IBQuery);

    try
      if not IBTransaction.InTransaction then
        IBTransaction.StartTransaction;
      IBQuery.ExecSQL;
      IBTransaction.Commit;
      Result := True;
    except
      if IBTransaction.InTransaction then
        IBTransaction.Rollback;
    end;

  finally
    IBQuery.Free;
    IBTransaction.Free;
  end;

end;

procedure TSORTEIOS.MontaSQLIncluir(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('INSERT INTO SORTEIOS (');
  IBQuery.SQL.Add('  Codigo,');
  IBQuery.SQL.Add('  NumeroLoop,');
  IBQuery.SQL.Add('  NomeSorteio,');
  IBQuery.SQL.Add('  CodLocal,');
  IBQuery.SQL.Add('  Data,');
  IBQuery.SQL.Add('  Hora,');
  IBQuery.SQL.Add('  PrecoCartela,');
  IBQuery.SQL.Add('  Apoio,');
  IBQuery.SQL.Add('  DataCadastro)');
  IBQuery.SQL.Add('VALUES (');
  IBQuery.SQL.Add('  :parCodigo,');
  IBQuery.SQL.Add('  :parNumeroLoop,');
  IBQuery.SQL.Add('  :parNomeSorteio,');
  IBQuery.SQL.Add('  :parCodLocal,');
  IBQuery.SQL.Add('  :parData,');
  IBQuery.SQL.Add('  :parHora,');
  IBQuery.SQL.Add('  :parPrecoCartela,');
  IBQuery.SQL.Add('  :parApoio,');
  IBQuery.SQL.Add('  :parDataCadastro)');

  IBQuery.Params := InformaParametros(IBQuery.SQL);
end;


function TSORTEIOS.Gravar: boolean;
var IBQuery: TIBQuery;
    IBTransaction: TIBTransaction;
begin
  Result := False;
  IBQuery := TIBQuery.Create(nil);
  IBTransaction := TIBTransaction.Create(nil);
  try
    IBQuery.Database := dmDados.IBDatabase;
    IBQuery.Transaction := IBTransaction;
    IBTransaction.DefaultDatabase := dmDados.IBDatabase;
    IBTransaction.Params.Add('read_committed');
    IBTransaction.Params.Add('rec_version');
    IBTransaction.Params.Add('nowait');

    MontaSQLGravar(IBQuery);

    try
      if not IBTransaction.InTransaction then
        IBTransaction.StartTransaction;
      IBQuery.ExecSQL;
      IBTransaction.Commit;
      Result := True;
    except
      if IBTransaction.InTransaction then
        IBTransaction.Rollback;
    end;

  finally
    IBQuery.Free;
    IBTransaction.Free;
  end;

end;

procedure TSORTEIOS.MontaSQLGravar(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('UPDATE SORTEIOS SET');
  IBQuery.SQL.Add('  Codigo = :parCodigo,');
  IBQuery.SQL.Add('  NumeroLoop = :parNumeroLoop,');
  IBQuery.SQL.Add('  NomeSorteio = :parNomeSorteio,');
  IBQuery.SQL.Add('  CodLocal = :parCodLocal,');
  IBQuery.SQL.Add('  Data = :parData,');
  IBQuery.SQL.Add('  Hora = :parHora,');
  IBQuery.SQL.Add('  PrecoCartela = :parPrecoCartela,');
  IBQuery.SQL.Add('  Apoio = :parApoio,');
  IBQuery.SQL.Add('  DataCadastro = :parDataCadastro');
  //cláusula WHERE para individualizar o registro a ser gravado (atualizado)
  IBQuery.SQL.Add('WHERE Codigo = ' + IntToStr(FCodigo));

  IBQuery.Params := InformaParametros(IBQuery.SQL);
end;


function TSORTEIOS.Ler: boolean;
var IBQuery: TIBQuery;
    IBTransaction: TIBTransaction;
begin
  Result := False;
  IBQuery := TIBQuery.Create(nil);
  IBTransaction := TIBTransaction.Create(nil);
  try
    IBQuery.Database := dmDados.IBDatabase;
    IBQuery.Transaction := IBTransaction;
    IBTransaction.DefaultDatabase := dmDados.IBDatabase;
    IBTransaction.Params.Add('read_committed');
    IBTransaction.Params.Add('rec_version');
    IBTransaction.Params.Add('nowait');
    //query para retornar um único registro usando a chave primária
    IBQuery.SQL.Add('SELECT * FROM SORTEIOS');
    IBQuery.SQL.Add('WHERE Codigo = ' + IntToStr(FCodigo));
    IBQuery.Open;

    if IBQuery.RecordCount > 0 then
    begin
      Result := True;
      FCodigo := IBQuery.Fields[0].AsInteger;
      FNumeroLoop := IBQuery.Fields[1].AsInteger;
      FNomeSorteio := IBQuery.Fields[2].AsString;
      FCodLocal := IBQuery.Fields[3].AsInteger;
      FData := IBQuery.Fields[4].AsDateTime;
      FHora := IBQuery.Fields[5].AsDateTime;
      FPrecoCartela := IBQuery.Fields[6].AsFloat;
      FApoio := IBQuery.Fields[7].AsString;
      FDataCadastro := IBQuery.Fields[8].AsDateTime;
    end;
  finally
    IBQuery.Free;
    IBTransaction.Free;
  end;

end;

function TSORTEIOS.Excluir: boolean;
var IBQuery: TIBQuery;
    IBTransaction: TIBTransaction;
begin
  Result := False;
  if not PodeExcluir then
    exit;
  IBQuery := TIBQuery.Create(nil);
  IBTransaction := TIBTransaction.Create(nil);
  try
    IBQuery.Database := dmDados.IBDatabase;
    IBQuery.Transaction := IBTransaction;
    IBTransaction.DefaultDatabase := dmDados.IBDatabase;
    IBTransaction.Params.Add('read_committed');
    IBTransaction.Params.Add('rec_version');
    IBTransaction.Params.Add('nowait');

    MontaSQLExcluir(IBQuery);

    try
      if not IBTransaction.InTransaction then
        IBTransaction.StartTransaction;
      IBQuery.ExecSQL;
      IBTransaction.Commit;
      Result := True;
    except
      if IBTransaction.InTransaction then
        IBTransaction.Rollback;
    end;

  finally
    IBQuery.Free;
    IBTransaction.Free;
  end;

end;

function TSORTEIOS.PodeExcluir: boolean;
begin
  Result := False;// a ser implementado
end;

procedure TSORTEIOS.MontaSQLExcluir(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('DELETE FROM SORTEIOS');
  //cláusula WHERE para individualizar o registro a ser deletado
  IBQuery.SQL.Add('WHERE Codigo = ' + IntToStr(FCodigo));
end;


function TSORTEIOS.InformaParametros(SQL: TStrings): TParams;
var IBQuery: TIBQuery;
    i: integer;
begin
  IBQuery := TIBQuery.Create(nil);
  IBQuery.SQL := SQL;

  for i := 0 to IBQuery.ParamCount-1 do
    IBQuery.Params[i].Value := null;

  if FCodigo > 0 then IBQuery.Params[0].AsInteger := FCodigo;
  if FNumeroLoop > 0 then IBQuery.Params[1].AsInteger := FNumeroLoop;
  if FNomeSorteio <> '' then IBQuery.Params[2].AsString := FNomeSorteio;
  if FCodLocal > 0 then IBQuery.Params[3].AsInteger := FCodLocal;
  if FData > 0 then IBQuery.Params[4].AsDateTime := FData;
  if FHora > 0 then IBQuery.Params[5].AsDateTime := FHora;
  if FPrecoCartela > 0 then IBQuery.Params[6].AsFloat := FPrecoCartela;
  if FApoio <> '' then IBQuery.Params[7].AsString := FApoio;
  if FDataCadastro > 0 then IBQuery.Params[8].AsDateTime := FDataCadastro;

  Result := IBQuery.Params;
end;

function TSORTEIOS.TemValoresIguais(UmaInstancia: TSORTEIOS): boolean;
begin
  Result := True;
  if not (UmaInstancia.Codigo = FCodigo) then Result := False;
  if not (UmaInstancia.NumeroLoop = FNumeroLoop) then Result := False;
  if not (UmaInstancia.NomeSorteio = FNomeSorteio) then Result := False;
  if not (UmaInstancia.CodLocal = FCodLocal) then Result := False;
  if not (UmaInstancia.Data = FData) then Result := False;
  if not (UmaInstancia.Hora = FHora) then Result := False;
  if not (UmaInstancia.PrecoCartela = FPrecoCartela) then Result := False;
  if not (UmaInstancia.Apoio = FApoio) then Result := False;
  if not (UmaInstancia.DataCadastro = FDataCadastro) then Result := False;
end;

function TSORTEIOS.InformaQtdSorteios: integer;
var IBQuery: TIBQuery;
    IBTransaction: TIBTransaction;
begin
  Result := 0;
  IBQuery := TIBQuery.Create(nil);
  IBTransaction := TIBTransaction.Create(nil);
  try
    IBQuery.Database := dmDados.IBDatabase;
    IBQuery.Transaction := IBTransaction;
    IBTransaction.DefaultDatabase := dmDados.IBDatabase;
    IBTransaction.Params.Add('read_committed');
    IBTransaction.Params.Add('rec_version');
    IBTransaction.Params.Add('nowait');
    //query para retornar a qtd se seções cadastradas
    IBQuery.SQL.Add('SELECT COUNT(*) FROM Sorteios');
    IBQuery.Open;

    if IBQuery.RecordCount > 0 then
      Result := IBQuery.Fields[0].AsInteger;
  finally
    IBQuery.Free;
    IBTransaction.Free;
  end;
end;

end.
