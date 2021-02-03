unit clsPREMIOS;

interface

uses Classes, Sysutils, IBQuery, Ibdatabase, Db;

type
  TPREMIOS = class(TObject)
  protected
    FCodSorteio: integer;
    FNumeroPremio: integer;
    FDescricao: string;
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
    function TemValoresIguais(UmaInstancia: TPREMIOS): boolean;

    property CodSorteio: integer read FCodSorteio write FCodSorteio;
    property NumeroPremio: integer read FNumeroPremio write FNumeroPremio;
    property Descricao: string read FDescricao write FDescricao;
  end;

implementation

uses DMObjetos;

constructor TPREMIOS.Create;
begin
  FCodSorteio := 0;
  FNumeroPremio := 0;
  FDescricao := '';

  inherited Create;
end;

destructor TPREMIOS.Destroy;
begin
  inherited Destroy;

end;

function TPREMIOS.Incluir: boolean;
var IBQuery: TIBQuery;
    IBTransaction: TIBTransaction;
begin
  Result := False;
  IBQuery := TIBQuery.Create(nil);
  IBTransaction := TIBTransaction.Create(nil);
  try
    IBQuery.Database := dtmObjetos.IBDatabase;
    IBQuery.Transaction := IBTransaction;
    IBTransaction.DefaultDatabase := dtmObjetos.IBDatabase;
    IBTransaction.Params.Add('read_committed');
    IBTransaction.Params.Add('rec_version');
    IBTransaction.Params.Add('nowait');
    //obtenção da próxima chave primária
??? IBQuery.SQL.Add('SELECT MAX(CODIGO) FROM PREMIOS');
    IBQuery.Open;
??? FCODIGO := IBQuery.Fields[0].AsInteger + 1;
    //FIM obtenção da próxima chave primária

    MontaSQLIncluir(IBQuery);

    try
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

procedure TPREMIOS.MontaSQLIncluir(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('INSERT INTO PREMIOS (');
  IBQuery.SQL.Add('  CodSorteio,');
  IBQuery.SQL.Add('  NumeroPremio,');
  IBQuery.SQL.Add('  Descricao)');
  IBQuery.SQL.Add('VALUES (');
  IBQuery.SQL.Add('  :parCodSorteio,');
  IBQuery.SQL.Add('  :parNumeroPremio,');
  IBQuery.SQL.Add('  :parDescricao)');

  IBQuery.Params := InformaParametros(IBQuery.SQL);
end;


function TPREMIOS.Gravar: boolean;
var IBQuery: TIBQuery;
    IBTransaction: TIBTransaction;
begin
  Result := False;
  IBQuery := TIBQuery.Create(nil);
  IBTransaction := TIBTransaction.Create(nil);
  try
    IBQuery.Database := dtmObjetos.IBDatabase;
    IBQuery.Transaction := IBTransaction;
    IBTransaction.DefaultDatabase := dtmObjetos.IBDatabase;
    IBTransaction.Params.Add('read_committed');
    IBTransaction.Params.Add('rec_version');
    IBTransaction.Params.Add('nowait');

    MontaSQLGravar(IBQuery);

    try
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

procedure TPREMIOS.MontaSQLGravar(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('UPDATE PREMIOS SET');
  IBQuery.SQL.Add('  CodSorteio = :parCodSorteio,');
  IBQuery.SQL.Add('  NumeroPremio = :parNumeroPremio,');
  IBQuery.SQL.Add('  Descricao = :parDescricao');
  //cláusula WHERE para individualizar o registro a ser gravado (atualizado)
  IBQuery.SQL.Add('WHERE CodSorteio = ' + IntToStr(FCodSorteio));
  IBQuery.SQL.Add('  AND NumeroPremio = ' + IntToStr(FNumeroPremio));

  IBQuery.Params := InformaParametros(IBQuery.SQL);
end;


function TPREMIOS.Ler: boolean;
var IBQuery: TIBQuery;
    IBTransaction: TIBTransaction;
begin
  Result := False;
  IBQuery := TIBQuery.Create(nil);
  IBTransaction := TIBTransaction.Create(nil);
  try
    IBQuery.Database := dtmObjetos.IBDatabase;
    IBQuery.Transaction := IBTransaction;
    IBTransaction.DefaultDatabase := dtmObjetos.IBDatabase;
    IBTransaction.Params.Add('read_committed');
    IBTransaction.Params.Add('rec_version');
    IBTransaction.Params.Add('nowait');
    //query para retornar um único registro usando a chave primária
    IBQuery.SQL.Add('SELECT * FROM PREMIOS');
    IBQuery.SQL.Add('WHERE CodSorteio = ' + IntToStr(FCodSorteio));
    IBQuery.SQL.Add('  AND NumeroPremio = ' + IntToStr(FNumeroPremio));
    IBQuery.Open;

    if IBQuery.RecordCount > 0 then
    begin
      Result := True;
      FCodSorteio := IBQuery.Fields[0].AsInteger;
      FNumeroPremio := IBQuery.Fields[1].AsInteger;
      FDescricao := IBQuery.Fields[2].AsString;
    end;
  finally
    IBQuery.Free;
    IBTransaction.Free;
  end;

end;

function TPREMIOS.Excluir: boolean;
var IBQuery: TIBQuery;
    IBTransaction: TIBTransaction;
begin
  Result := False;
  if not PodeExcluir then
    exit;
  IBQuery := TIBQuery.Create(nil);
  IBTransaction := TIBTransaction.Create(nil);
  try
    IBQuery.Database := dtmObjetos.IBDatabase;
    IBQuery.Transaction := IBTransaction;
    IBTransaction.DefaultDatabase := dtmObjetos.IBDatabase;
    IBTransaction.Params.Add('read_committed');
    IBTransaction.Params.Add('rec_version');
    IBTransaction.Params.Add('nowait');

    MontaSQLExcluir(IBQuery);

    try
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

function TPREMIOS.PodeExcluir: boolean;
begin
  Result := False;// a ser implementado
end;

procedure TPREMIOS.MontaSQLExcluir(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('DELETE FROM PREMIOS');
  //cláusula WHERE para individualizar o registro a ser deletado
  IBQuery.SQL.Add('WHERE CodSorteio = ' + IntToStr(FCodSorteio));
  IBQuery.SQL.Add('  AND NumeroPremio = ' + IntToStr(FNumeroPremio));
end;


function TPREMIOS.InformaParametros(SQL: TStrings): TParams;
var IBQuery: TIBQuery;
    i: integer;
begin
  IBQuery := TIBQuery.Create(nil);
  IBQuery.SQL := SQL;

  for i := 0 to IBQuery.ParamCount-1 do
    IBQuery.Params[i].Value := null;

  if FCodSorteio > 0 then IBQuery.Params[0].AsInteger := FCodSorteio;
  if FNumeroPremio > 0 then IBQuery.Params[1].AsInteger := FNumeroPremio;
  if FDescricao <> '' then IBQuery.Params[2].AsString := FDescricao;

  Result := IBQuery.Params;
end;

function TPREMIOS.TemValoresIguais(UmaInstancia: TPREMIOS): boolean;
begin
  Result := True;
  if not (UmaInstancia.CodSorteio = FCodSorteio) then Result := False;
  if not (UmaInstancia.NumeroPremio = FNumeroPremio) then Result := False;
  if not (UmaInstancia.Descricao = FDescricao) then Result := False;
end;

end.
