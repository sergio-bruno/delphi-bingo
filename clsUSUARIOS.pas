unit clsUSUARIOS;

interface

uses Classes, Sysutils, IBQuery, Ibdatabase, Db;

type
  TUSUARIOS = class(TObject)
  protected
    FCodigo: integer;
    FNome: string;
    FSenha: string;
    FPerfil: string;
    FAtivo: boolean;
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
    function TemValoresIguais(UmaInstancia: TUSUARIOS): boolean;

    property Codigo: integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    property Senha: string read FSenha write FSenha;
    property Perfil: string read FPerfil write FPerfil;
    property Ativo: boolean read FAtivo write FAtivo;
  end;

implementation

uses DMObjetos;

constructor TUSUARIOS.Create;
begin
  FCodigo := 0;
  FNome := '';
  FSenha := '';
  FPerfil := '';
  FAtivo := False;

  inherited Create;
end;

destructor TUSUARIOS.Destroy;
begin
  inherited Destroy;

end;

function TUSUARIOS.Incluir: boolean;
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
??? IBQuery.SQL.Add('SELECT MAX(CODIGO) FROM USUARIOS');
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

procedure TUSUARIOS.MontaSQLIncluir(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('INSERT INTO USUARIOS (');
  IBQuery.SQL.Add('  Codigo,');
  IBQuery.SQL.Add('  Nome,');
  IBQuery.SQL.Add('  Senha,');
  IBQuery.SQL.Add('  Perfil,');
  IBQuery.SQL.Add('  Ativo)');
  IBQuery.SQL.Add('VALUES (');
  IBQuery.SQL.Add('  :parCodigo,');
  IBQuery.SQL.Add('  :parNome,');
  IBQuery.SQL.Add('  :parSenha,');
  IBQuery.SQL.Add('  :parPerfil,');
  IBQuery.SQL.Add('  :parAtivo)');

  IBQuery.Params := InformaParametros(IBQuery.SQL);
end;


function TUSUARIOS.Gravar: boolean;
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

procedure TUSUARIOS.MontaSQLGravar(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('UPDATE USUARIOS SET');
  IBQuery.SQL.Add('  Codigo = :parCodigo,');
  IBQuery.SQL.Add('  Nome = :parNome,');
  IBQuery.SQL.Add('  Senha = :parSenha,');
  IBQuery.SQL.Add('  Perfil = :parPerfil,');
  IBQuery.SQL.Add('  Ativo = :parAtivo');
  //cláusula WHERE para individualizar o registro a ser gravado (atualizado)
  IBQuery.SQL.Add('WHERE Codigo = ' + IntToStr(FCodigo));

  IBQuery.Params := InformaParametros(IBQuery.SQL);
end;


function TUSUARIOS.Ler: boolean;
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
    IBQuery.SQL.Add('SELECT * FROM USUARIOS');
    IBQuery.SQL.Add('WHERE Codigo = ' + IntToStr(FCodigo));
    IBQuery.Open;

    if IBQuery.RecordCount > 0 then
    begin
      Result := True;
      FCodigo := IBQuery.Fields[0].AsInteger;
      FNome := IBQuery.Fields[1].AsString;
      FSenha := IBQuery.Fields[2].AsString;
      FPerfil := IBQuery.Fields[3].AsString;
      FAtivo := IBQuery.Fields[4].AsBoolean;
    end;
  finally
    IBQuery.Free;
    IBTransaction.Free;
  end;

end;

function TUSUARIOS.Excluir: boolean;
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

function TUSUARIOS.PodeExcluir: boolean;
begin
  Result := False;// a ser implementado
end;

procedure TUSUARIOS.MontaSQLExcluir(IBQuery: TIBQuery);
begin
  IBQuery.SQL.Clear;

  IBQuery.SQL.Add('DELETE FROM USUARIOS');
  //cláusula WHERE para individualizar o registro a ser deletado
  IBQuery.SQL.Add('WHERE Codigo = ' + IntToStr(FCodigo));
end;


function TUSUARIOS.InformaParametros(SQL: TStrings): TParams;
var IBQuery: TIBQuery;
    i: integer;
begin
  IBQuery := TIBQuery.Create(nil);
  IBQuery.SQL := SQL;

  for i := 0 to IBQuery.ParamCount-1 do
    IBQuery.Params[i].Value := null;

  if FCodigo > 0 then IBQuery.Params[0].AsInteger := FCodigo;
  if FNome <> '' then IBQuery.Params[1].AsString := FNome;
  if FSenha <> '' then IBQuery.Params[2].AsString := FSenha;
  if FPerfil <> '' then IBQuery.Params[3].AsString := FPerfil;
  if FAtivo = True then IBQuery.Params[4].AsString := 'T' else IBQuery.Params[4].AsString := 'F';

  Result := IBQuery.Params;
end;

function TUSUARIOS.TemValoresIguais(UmaInstancia: TUSUARIOS): boolean;
begin
  Result := True;
  if not (UmaInstancia.Codigo = FCodigo) then Result := False;
  if not (UmaInstancia.Nome = FNome) then Result := False;
  if not (UmaInstancia.Senha = FSenha) then Result := False;
  if not (UmaInstancia.Perfil = FPerfil) then Result := False;
  if not (UmaInstancia.Ativo = FAtivo) then Result := False;
end;

end.
