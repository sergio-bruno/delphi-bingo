unit clsCARTELAS;

interface

uses Classes, Sysutils, IBQuery, Ibdatabase, Db;

type
  TCARTELAS = class(TObject)
  protected
    FCodSorteio: integer;
    FNumeroCartela: integer;
    FTexto: string;
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
    function TemValoresIguais(UmaInstancia: TCARTELAS): boolean;

    property CodSorteio: integer read FCodSorteio write FCodSorteio;
    property NumeroCartela: integer read FNumeroCartela write FNumeroCartela;
    property Texto: string read FTexto write FTexto;
  end;

implementation

uses DMObjetos;

constructor TCARTELAS.Create;
begin
  FCodSorteio := 0;
  FNumeroCartela := 0;
  FTexto := '';

  inherited Create;
end;

destructor TCARTELAS.Destroy;
begin
  inherited Destroy;

end;

function TCARTELAS.Incluir: boolean;
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
??? IBQuery.SQL.Add('SELECT MAX(CODIGO) FROM CARTELAS');
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

procedure TCARTELAS.MontaSQLIncluir(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('INSERT INTO CARTELAS (');
  IBQuery.SQL.Add('  CodSorteio,');
  IBQuery.SQL.Add('  NumeroCartela,');
  IBQuery.SQL.Add('  Texto)');
  IBQuery.SQL.Add('VALUES (');
  IBQuery.SQL.Add('  :parCodSorteio,');
  IBQuery.SQL.Add('  :parNumeroCartela,');
  IBQuery.SQL.Add('  :parTexto)');

  IBQuery.Params := InformaParametros(IBQuery.SQL);
end;


function TCARTELAS.Gravar: boolean;
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

procedure TCARTELAS.MontaSQLGravar(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('UPDATE CARTELAS SET');
  IBQuery.SQL.Add('  CodSorteio = :parCodSorteio,');
  IBQuery.SQL.Add('  NumeroCartela = :parNumeroCartela,');
  IBQuery.SQL.Add('  Texto = :parTexto');
  //cláusula WHERE para individualizar o registro a ser gravado (atualizado)
  IBQuery.SQL.Add('WHERE CodSorteio = ' + IntToStr(FCodSorteio));
  IBQuery.SQL.Add('  AND NumeroCartela = ' + IntToStr(FNumeroCartela));

  IBQuery.Params := InformaParametros(IBQuery.SQL);
end;


function TCARTELAS.Ler: boolean;
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
    IBQuery.SQL.Add('SELECT * FROM CARTELAS');
    IBQuery.SQL.Add('WHERE CodSorteio = ' + IntToStr(FCodSorteio));
    IBQuery.SQL.Add('  AND NumeroCartela = ' + IntToStr(FNumeroCartela));
    IBQuery.Open;

    if IBQuery.RecordCount > 0 then
    begin
      Result := True;
      FCodSorteio := IBQuery.Fields[0].AsInteger;
      FNumeroCartela := IBQuery.Fields[1].AsInteger;
      FTexto := IBQuery.Fields[2].AsString;
    end;
  finally
    IBQuery.Free;
    IBTransaction.Free;
  end;

end;

function TCARTELAS.Excluir: boolean;
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

function TCARTELAS.PodeExcluir: boolean;
begin
  Result := False;// a ser implementado
end;

procedure TCARTELAS.MontaSQLExcluir(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('DELETE FROM CARTELAS');
  //cláusula WHERE para individualizar o registro a ser deletado
  IBQuery.SQL.Add('WHERE CodSorteio = ' + IntToStr(FCodSorteio));
  IBQuery.SQL.Add('  AND NumeroCartela = ' + IntToStr(FNumeroCartela));
end;


function TCARTELAS.InformaParametros(SQL: TStrings): TParams;
var IBQuery: TIBQuery;
    i: integer;
begin
  IBQuery := TIBQuery.Create(nil);
  IBQuery.SQL := SQL;

  for i := 0 to IBQuery.ParamCount-1 do
    IBQuery.Params[i].Value := null;

  if FCodSorteio > 0 then IBQuery.Params[0].AsInteger := FCodSorteio;
  if FNumeroCartela > 0 then IBQuery.Params[1].AsInteger := FNumeroCartela;
  if FTexto <> '' then IBQuery.Params[2].AsString := FTexto;

  Result := IBQuery.Params;
end;

function TCARTELAS.TemValoresIguais(UmaInstancia: TCARTELAS): boolean;
begin
  Result := True;
  if not (UmaInstancia.CodSorteio = FCodSorteio) then Result := False;
  if not (UmaInstancia.NumeroCartela = FNumeroCartela) then Result := False;
  if not (UmaInstancia.Texto = FTexto) then Result := False;
end;

end.
