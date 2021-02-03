unit clsLOCAL;

interface

uses Classes, Sysutils, IBQuery, Ibdatabase, Db, Variants;

type
  TLOCAL = class(TObject)
  protected
    FCodigo: integer;
    FNomeLocal: string;
    FEndereco: string;
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
    function TemValoresIguais(UmaInstancia: TLOCAL): boolean;

    property Codigo: integer read FCodigo write FCodigo;
    property NomeLocal: string read FNomeLocal write FNomeLocal;
    property Endereco: string read FEndereco write FEndereco;
  end;

implementation

uses Dados;

constructor TLOCAL.Create;
begin
  FCodigo := 0;
  FNomeLocal := '';
  FEndereco := '';

  inherited Create;
end;

destructor TLOCAL.Destroy;
begin
  inherited Destroy;

end;

function TLOCAL.Incluir: boolean;
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
    IBQuery.SQL.Add('SELECT MAX(CODIGO) FROM LOCAL');
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

procedure TLOCAL.MontaSQLIncluir(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('INSERT INTO LOCAL (');
  IBQuery.SQL.Add('  Codigo,');
  IBQuery.SQL.Add('  NomeLocal,');
  IBQuery.SQL.Add('  Endereco)');
  IBQuery.SQL.Add('VALUES (');
  IBQuery.SQL.Add('  :parCodigo,');
  IBQuery.SQL.Add('  :parNomeLocal,');
  IBQuery.SQL.Add('  :parEndereco)');

  IBQuery.Params := InformaParametros(IBQuery.SQL);
end;


function TLOCAL.Gravar: boolean;
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

procedure TLOCAL.MontaSQLGravar(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('UPDATE LOCAL SET');
  IBQuery.SQL.Add('  Codigo = :parCodigo,');
  IBQuery.SQL.Add('  NomeLocal = :parNomeLocal,');
  IBQuery.SQL.Add('  Endereco = :parEndereco');
  //cláusula WHERE para individualizar o registro a ser gravado (atualizado)
  IBQuery.SQL.Add('WHERE Codigo = ' + IntToStr(FCodigo));

  IBQuery.Params := InformaParametros(IBQuery.SQL);
end;


function TLOCAL.Ler: boolean;
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
    IBQuery.SQL.Add('SELECT * FROM LOCAL');
    IBQuery.SQL.Add('WHERE Codigo = ' + IntToStr(FCodigo));
    IBQuery.Open;

    if IBQuery.RecordCount > 0 then
    begin
      Result := True;
      FCodigo := IBQuery.Fields[0].AsInteger;
      FNomeLocal := IBQuery.Fields[1].AsString;
      FEndereco := IBQuery.Fields[2].AsString;
    end;
  finally
    IBQuery.Free;
    IBTransaction.Free;
  end;

end;

function TLOCAL.Excluir: boolean;
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

function TLOCAL.PodeExcluir: boolean;
begin
  Result := False;// a ser implementado
end;

procedure TLOCAL.MontaSQLExcluir(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('DELETE FROM LOCAL');
  //cláusula WHERE para individualizar o registro a ser deletado
  IBQuery.SQL.Add('WHERE Codigo = ' + IntToStr(FCodigo));
end;


function TLOCAL.InformaParametros(SQL: TStrings): TParams;
var IBQuery: TIBQuery;
    i: integer;
begin
  IBQuery := TIBQuery.Create(nil);
  IBQuery.SQL := SQL;

  for i := 0 to IBQuery.ParamCount-1 do
    IBQuery.Params[i].Value := null;

  if FCodigo > 0 then IBQuery.Params[0].AsInteger := FCodigo;
  if FNomeLocal <> '' then IBQuery.Params[1].AsString := FNomeLocal;
  if FEndereco <> '' then IBQuery.Params[2].AsString := FEndereco;

  Result := IBQuery.Params;
end;

function TLOCAL.TemValoresIguais(UmaInstancia: TLOCAL): boolean;
begin
  Result := True;
  if not (UmaInstancia.Codigo = FCodigo) then Result := False;
  if not (UmaInstancia.NomeLocal = FNomeLocal) then Result := False;
  if not (UmaInstancia.Endereco = FEndereco) then Result := False;
end;

end.
