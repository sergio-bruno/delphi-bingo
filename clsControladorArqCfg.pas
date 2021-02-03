unit clsControladorArqCfg;

{Esta classe serve para controlar um arquivo de configuração
como o do exemplo abaixo
--------------------------------------
;Linha de comentário começa com ;    |
[Seção]                              | seções entre colchetes
Item=valor                           | sem espaço antes e depois do sinal de igual '='
Item2=S;S­N                          | Opções possíveis após o valor e ';' separadas por #173 (­)
--------------------------------------
Obs: 1- Não pode haver os caracteres '=' , ';' e #173 no Item nem no Valor.
     2- As linhas de comentário ABAIXO de um determinado ITEM referem-se
        a este item.

em 29/12/2005 PV
Para permitir inserir um valor (SUBITEM) em  um item
ex.: como em
PERMITE VENDA COM ESTOQUE ZERADO=SIM;SIM­NÃO­SIM EXCETO SEÇÕES
O comentário que começa com ;] abrigará o valor do subitem, assim:

   seção              item                   subitem      #173
;]VENDAS;PERMITE VENDA COM ESTOQUE ZERADO;SIM EXCETO SEÇÕES­1,4,5

}

interface

uses Sysutils, Classes, FuncStrings; //, ParseLinha, EliminaCaracteres;

const CaracsNaoPermitidos = '=;' + #173;

type
  TControladorArqCfg = class(TObject)
  private
    NomeDoArquivo: string;
    NomeDoArquivoTreeView: string;

    NomeDoArquivoImagens: string;
    { O Arquivo de imagem será criado para guardar as informações das figuras
    marcadas e desmarcadas para os itens que têm opções.
    Cada linha deste arquivo corresponde a uma linha no arquivo treeView
    0 sem opções (incolor) / 1 figura desmarcada / 2 figura marcada }

    ComArqParaTreeView: boolean; //se cria ou não arquivo para treeview
    procedure InformaInicioFimSecao(var LinhaInicialSecao, LinhaFinalSecao: integer;Secao: string);
    function ExisteSecao(_Secao: string): boolean;
    procedure CriaArquivo; //caso não exista, cria o arquivo
    procedure EliminaComentario(Secao, Item: string);
    function InformaItens(_Secao: string): TStringList;
  public
    function getNomeDoArquivo: String;
    function getNomeDoArquivoTreeView : string;
    function getNomeDoArquivoImagens : string;
    constructor Create(_NomeDoArquivo: string); overload;
    constructor Create(_NomeDoArquivo: string; _ComArqParaTreeView: boolean); overload;
    destructor Destroy; override;
    function ExisteOArquivo: boolean;
    function InformaValor(Secao, Item: string): string;
    function InformaComentarioItem(Secao, Item: string): TStrings;
    procedure SalvaComentario(Secao, Item: string; Comentario: TStrings);
    function RetornaLinhaListaOrdenada(Lista: TStrings): string;
    function ExisteItem(Secao, Item: string): boolean;
    function InformaLinhaValores(Secao, Item: string): String;
    function InformaNumItensSecao(Secao: string): integer;
    function InformaNumSecoes: integer;
  end;

implementation

destructor TControladorArqCfg.Destroy;
begin
  inherited Destroy;
end;

constructor TControladorArqCfg.Create(_NomeDoArquivo: string);
begin
  NomeDoArquivo := _NomeDoArquivo;
  if not ExisteOArquivo then
    CriaArquivo;
  ComArqParaTreeView := True;
  NomeDoArquivoTreeView := 'TreeView.txt';
  NomeDoArquivoImagens := 'Imagens.txt';
end;

constructor TControladorArqCfg.Create(_NomeDoArquivo: string;
  _ComArqParaTreeView: boolean);
begin
  ComArqParaTreeView := _ComArqParaTreeView;
  NomeDoArquivo := _NomeDoArquivo;
  if not ExisteOArquivo then
    CriaArquivo;
end;

function TControladorArqCfg.ExisteOArquivo: boolean;
begin
  Result := False;
  if FileExists(NomeDoArquivo) then
    Result := True;
end;

function TControladorArqCfg.InformaValor(Secao, Item: string): string;
var ArqCfg: TStrings;
    i, x, y, LinhaInicialSecao, LinhaFinalSecao: integer;
begin
  Result := '';
  if not ExisteOArquivo then
    exit;
  LinhaInicialSecao := 0;
  LinhaFinalSecao := 0;
  ArqCfg := TStringList.Create;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');
  try
    InformaInicioFimSecao(LinhaInicialSecao,LinhaFinalSecao, Secao);

    for i := LinhaInicialSecao to LinhaFinalSecao do
    begin
      x := Pos('=', ArqCfg[i]);
      if Item = Copy(ArqCfg[i], 1, x-1) then
      begin
        y := Pos(';', ArqCfg[i]);
        if y= 0 then
          Result := Copy(ArqCfg[i],x+1,Length(ArqCfg[i]))
        else
          Result := Copy(ArqCfg[i],x+1, y-x-1 );
        break;
      end;
    end;
  finally
    ArqCfg.Free;
  end;

end;

function TControladorArqCfg.getNomeDoArquivo: String;
begin
  Result := NomeDoArquivo;
end;

procedure TControladorArqCfg.InformaInicioFimSecao(var LinhaInicialSecao,
  LinhaFinalSecao: integer; Secao: string);
var ArqCfg: TStrings;
    i,j: integer;
begin
  ArqCfg := TStringList.Create;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');
  try
    for i := 0 to ArqCfg.Count-1 do
    begin
      if Pos('[' + Secao + ']', ArqCfg[i]) = 1 then
      begin
        LinhaInicialSecao := i;
        LinhaFinalSecao := i+1;
        for j := i+1 to ArqCfg.Count-1 do
        begin
          if Pos('[', ArqCfg[j]) = 1 then
          begin
            LinhaFinalSecao := j-1;
            break;
          end
          else
          begin
            inc(LinhaFinalSecao);
          end;
        end;
        break;
      end;
    end;
    if LinhaFinalSecao > ArqCfg.Count-1 then
      LinhaFinalSecao := ArqCfg.Count-1;
  finally
    ArqCfg.Free;
  end;

end;

function TControladorArqCfg.InformaNumSecoes: integer;
var ArqCfg: TStrings;
    i, cont: integer;
begin
  Result := 0;
  if not ExisteOArquivo then exit;
  ArqCfg := TStringList.Create;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');
  Cont := 0;
  try
    for i := 0 to ArqCfg.Count-1 do
    begin
      if Pos('[', ArqCfg[i]) = 1  then
        inc(Cont);
    end;
  finally
    ArqCfg.Free;
  end;
  Result := Cont;
end;

function TControladorArqCfg.getNomeDoArquivoTreeView: string;
begin
  Result := NomeDoArquivoTreeView;
end;

function TControladorArqCfg.getNomeDoArquivoImagens: string;
begin
  Result := NomeDoArquivoImagens;
end;

function TControladorArqCfg.ExisteSecao(_Secao: string): boolean;
var ArqCfg: TStrings;
    i: integer;
begin
  Result := False;
  ArqCfg := TStringList.Create;
  if not ExisteOArquivo then exit;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');
  try
    for i := 0 to ArqCfg.Count-1 do
    begin
      if Pos('[' + _Secao + ']', ArqCfg[i]) = 1  then
      begin
        Result := True;
        break;
      end;
    end;
  finally
    ArqCfg.Free;
  end;
end;

procedure TControladorArqCfg.CriaArquivo;
var Linhas: TStrings;
begin
  Linhas := TStringList.Create;
  try
    if not ExisteOArquivo then
      Linhas.SaveToFile(NomeDoArquivo);
  finally
    Linhas.Free;
  end;

end;

function TControladorArqCfg.InformaComentarioItem(Secao,
  Item: string): TStrings;
var ArqCfg: TStrings;
    i, j, k, LinhaInicialSecao, LinhaFinalSecao: integer;
    Comentario: TStrings;
begin
  Comentario := TStringList.Create;
  ArqCfg := TStringList.Create;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');
  try
    InformaInicioFimSecao(LinhaInicialSecao,LinhaFinalSecao, Secao);
    for i := LinhaInicialSecao to LinhaFinalSecao do
    begin
      k := Pos('=', ArqCfg[i]);
      if Item = Copy(ArqCfg[i], 1, k-1)  then //achou o item
      begin
        for j := i+1 to ArqCfg.Count-1 do
        begin
          if Copy(ArqCfg[j], 1, 1) = ';' then
            Comentario.Add(Copy(ArqCfg[j], 2, Length(ArqCfg[j])))
          else
            break;
        end;
        break;
      end;
    end;
  finally
    ArqCfg.Free;
  end;
  Result := Comentario;
end;

procedure TControladorArqCfg.EliminaComentario(Secao, Item: string);
var ArqCfg: TStrings;
    i, k, LinhaInicialSecao, LinhaFinalSecao: integer;
begin
  ArqCfg := TStringList.Create;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');
  try
    InformaInicioFimSecao(LinhaInicialSecao,LinhaFinalSecao, Secao);
    for i := LinhaInicialSecao to LinhaFinalSecao do
    begin
      k := Pos('=', ArqCfg[i]);
      if Item = Copy(ArqCfg[i], 1, k-1)  then //achou o item
      begin

        //deleta os comentários (abaixo de i+1)
			  while Copy(ArqCfg[i+1],1,1) = ';' do
			    ArqCfg.Delete(i+1);

        break;
      end;
    end;
    ArqCfg.SaveToFile(NomeDoArquivo);
  finally
    ArqCfg.Free;
  end;
end;

procedure TControladorArqCfg.SalvaComentario(Secao, Item: string;
  Comentario: TStrings);
var ArqCfg: TStrings;
    i, j, k, LinhaInicialSecao, LinhaFinalSecao: integer;
begin
  EliminaComentario(Secao, Item);
  ArqCfg := TStringList.Create;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');
  try
    InformaInicioFimSecao(LinhaInicialSecao,LinhaFinalSecao, Secao);
    for i := LinhaInicialSecao to LinhaFinalSecao do
    begin
      k := Pos('=', ArqCfg[i]);
      if Item = Copy(ArqCfg[i], 1, k-1)  then //achou o item
      begin
        for j := 0 to Comentario.Count-1 do
          ArqCfg.Insert(i+j+1, ';' + Comentario[j]);
        break;
      end;
    end;
  ArqCfg.SaveToFile(NomeDoArquivo);
  finally
    ArqCfg.Free;
  end;
end;

function TControladorArqCfg.InformaItens(_Secao: string): TStringList;
var i, LinhaInicialSecao, LinhaFinalSecao: integer;
    ArqCfg: TStrings;
begin
  Result := TStringList.Create;
  InformaInicioFimSecao(LinhaInicialSecao,LinhaFinalSecao, _Secao);
  ArqCfg := TStringList.Create;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');
  try
    for i := LinhaInicialSecao to LinhaFinalSecao do
    begin
      if (Copy(ArqCfg[i], 1, 1) <> '[') and (Copy(ArqCfg[i], 1, 1) <> ';') then
      begin
        if LeftTrim(ArqCfg[i]) <> '' then
          Result.Add(ArqCfg[i]);
      end;
    end;
  finally
    ArqCfg.Free;
  end;
end;

function TControladorArqCfg.RetornaLinhaListaOrdenada(Lista: TStrings): string;
var aux: string;
    i: integer;
begin
  aux := '#LISTA ORDENADA#';
  for i := 0 to Lista.Count-1 do
  begin
    if i <> Lista.Count-1 then
      aux := aux + Lista[i] + #173
    else
      aux := aux + Lista[i];
  end;
  result := aux;
end;

function TControladorArqCfg.ExisteItem(Secao, Item: string): boolean;
var i, x, LinhaInicialSecao, LinhaFinalSecao: integer;
    AuxItem: string;
    ArqCfg: TStrings;
begin
  Result := False;
  LinhaInicialSecao := 0;
  LinhaFinalSecao := 0;
  ArqCfg := TStringList.Create;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');

  try
    InformaInicioFimSecao(LinhaInicialSecao,LinhaFinalSecao, Secao);

    for i := LinhaInicialSecao to LinhaFinalSecao do
    begin
      x := Pos('=', ArqCfg[i]);
      AuxItem := Copy(ArqCfg[i], 1, x-1);
      if Item = AuxItem then //achou o item
      begin
        Result := True;
        break;
      end;
    end;
  finally
   ArqCfg.Free;
  end;
end;

function TControladorArqCfg.InformaLinhaValores(Secao, Item: string): String;
var i, x, LinhaInicialSecao, LinhaFinalSecao: integer;
    AuxItem: string;
    ArqCfg: TStrings;
begin
  LinhaInicialSecao := 0;
  LinhaFinalSecao := 0;
  ArqCfg := TStringList.Create;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');

  try
    Result := '';

    InformaInicioFimSecao(LinhaInicialSecao,LinhaFinalSecao, Secao);

    for i := LinhaInicialSecao to LinhaFinalSecao do
    begin
      x := Pos('=', ArqCfg[i]);
      AuxItem := Copy(ArqCfg[i], 1, x-1);
      if Item = AuxItem then //achou o item
      begin
        x := Pos('=', ArqCfg[i]);
        Result := Copy(ArqCfg[i], x+1, Length(ArqCfg[i]));
        break;
      end;
    end;
  finally
   ArqCfg.Free;
  end;

end;

function TControladorArqCfg.InformaNumItensSecao(Secao: string): integer;
var iAux, i, LinhaInicialSecao, LinhaFinalSecao : integer;
    ArqCfg: TStrings;
begin
  Result := 0;
  LinhaInicialSecao := 0;
  LinhaFinalSecao := 0;
  ArqCfg := TStringList.Create;
  ArqCfg.LoadFromFile(NomeDoArquivo);
  ArqCfg.Add('');
  try
    InformaInicioFimSecao(LinhaInicialSecao,LinhaFinalSecao,Secao);
    //for i:= LinhaInicialSecao + 1 to LinhaFinalSecao - 1 do antigo
    for i:= LinhaInicialSecao + 1 to LinhaFinalSecao  do
    begin
      if (copy(ArqCfg[i],1,1) = ';') or (copy(ArqCfg[i],1,1) = ' ') or (ArqCfg[i] = '') then
        Continue;
      iAux := Pos('=',ArqCfg[i]);
      if iAux > 0 then
        inc(Result);
    end;
  finally
   ArqCfg.Free;
  end;

end;

end.
