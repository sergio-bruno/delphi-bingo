unit FuncStrings;

{
Esta unidade contem diversas funÁıes simples envolvendo strings .
}

interface

uses windows, sysutils, classes;

function Espacos(Quant: integer): String;
function Centraliza(Texto: String; Largura: integer): String;
function AlinhaADireita(Texto: String; Largura: integer): String;
function AlinhaAEsquerda(Texto: String; Largura: integer): String;
function Repete(Carac: char; Quant: integer): string;
function Substitui(Texto: string; ASubstituir, Substituicao: char): string;
function Alltrim(Texto : String): String;
function LeftTrim(Texto : String): String;
function RightTrim(Texto : String): String;
function CustomStrToFloat(Texto: string): Extended;
function InformaSerialHd: string;
procedure DataPortugues;
function EliminaCaracteresDeControle(UmaString: string): string;

//Coloca Texto em tantas linhas quantas forem a Largura atÈ um m·ximo de AlturaMax
function AcomodaTexto(Texto: String; Largura: integer): TStrings;

//para transformar os caracteres ANSI em CP850 usado por impressoras matriciais
//quando se imprime direto para a porta da impressora
function AnsiTo850(Texto: String): string;

//para eliminar caracteres acentuados e substituÌ-los por caracteres sem acentos
//inclusive 'Á'
function EliminaAcentos(Texto: String): string;

//transforma a string Caracteres em comandos de impressora
//observe que Caracteres tem que trazer os comandos em hexa
//exemplo do argumento Caracteres: #$1B#$40#$1B#$78'0'#$1B#$4D#$0F
function ConfigCaracteres(Caracteres: string): String;
function HexToInt(const HexStr: string): longint;

function ParseLinha(Linha: string; Separador: char): TStrings;

//se a string È composta por n˙meros retorna true;
function ENumeroInteiro(AString: string): Boolean;

function InformaDigitoEAN13(sNumero: string): integer;
function VerificaEAN13(sNumero: string): boolean;

//funÁıes de arredondamento
function Arredonda(Numero:Double): Double; overload;
{arredonda para n casas decimais e depois trunca}
function Arredonda(Valor : Extended; CasasDecimais : Byte) : Extended; overload;
//coloca o texto todo em letras maiusculas considerando acentos
function Maiuscula(Texto: string): string;

implementation

function Espacos(Quant: integer): String;
begin
  Result := '';
  while Length(Result) < Quant do
    Result := Result + ' ';
end;

function AlinhaADireita(Texto: String; Largura: integer): String;
var m, c, i: integer;
begin
  c := Length(Texto);
  m := (Largura - C);
  for i := 1 to m do
    Texto := ' ' + Texto;
  Result := Texto;
end;

function AlinhaAEsquerda(Texto: String; Largura: integer): String;
var m, c, i: integer;
begin
  c := Length(Texto);
  m := (Largura - C);
  for i := 1 to m do
    Texto := Texto + ' ';
  Result := Texto;
end;


function Centraliza(Texto: String; Largura: integer): String;
var m, c, i: integer;
begin
  c := Length(Texto);
  m := (Largura - C) div 2;
  for i := 1 to m do
    Texto := ' ' + Texto;
  while Length(Texto) < Largura do
    Texto := Texto + ' ';
  Result := Texto;

end;

function Repete(Carac: char; Quant: integer): string;
begin
  Result := '';
  while Length(Result) < Quant do
    Result := Result + Carac;
end;

function Substitui(Texto: string; ASubstituir, Substituicao: char): string;
var x: integer;
begin
  while pos(ASubstituir, Texto) > 0 do
  begin
    x := pos(ASubstituir, Texto);
    Texto := Copy(Texto, 1, x-1) + Substituicao + Copy(Texto, x + 1, Length(Texto));
  end;
  Result := Texto;
end;

// Est· funÁ„o substitui todos os caracteres em ASubstituir pelo caracter Substituicao.
function SubstituiCaracteres(Texto, ASubstituir: string; Substituicao: char): string;
var i: integer;
begin
  for i := 1 to Length(ASubstituir) do
  begin
    Texto := Substitui(Texto,ASubstituir[i],Substituicao);
  end;
  Result := Texto;
end;

function EliminaAcentos(Texto: String): string;
begin
  Texto := SubstituiCaracteres(Texto,'¡¬¿ƒ√','A');
  Texto := SubstituiCaracteres(Texto,'… »À','E');
  Texto := SubstituiCaracteres(Texto,'ÕŒÃœ','I');
  Texto := SubstituiCaracteres(Texto,'”‘“÷’','O');
  Texto := SubstituiCaracteres(Texto,'⁄€Ÿ‹','U');
  Texto := Substitui(Texto,'«','C');
  Texto := SubstituiCaracteres(Texto,'·‚‡‰„','a');
  Texto := SubstituiCaracteres(Texto,'ÈÍËÎ','e');
  Texto := SubstituiCaracteres(Texto,'ÌÓÏÔ','i');
  Texto := SubstituiCaracteres(Texto,'ÛÙÚˆı','o');
  Texto := SubstituiCaracteres(Texto,'˙˚˘¸','u');
  Texto := Substitui(Texto,'Á','c');

  Result := Texto;
end;

function AnsiTo850(Texto: String): string;
var i: integer;
    M: array of string[1];
begin
  SetLength(M,Length(Texto));
  for i := 0 to Length(Texto)-1 do
  begin
    if Ord(Texto[i+1]) > 127 then //atÈ 127 n„o h· diferenÁas entre ANSI e code page 850
    begin
      case Ord(Texto[i+1]) of
        128	: M[i] := #$45;	//	Ä
        129	: M[i] := #$20; //	Å
        130	: M[i] := #$2C; //	Ç
        131	: M[i] := #$66;	//	É
        132	: M[i] := #$2C;	//	Ñ
        133	: M[i] := #$2E;	//	Ö
        134	: M[i] := #$C5;	//	Ü
        135	: M[i] := #$CE;	//	á
        136	: M[i] := #$5E;	//	à
        137	: M[i] := #$20;	//	â
        138	: M[i] := #$53;	//	ä
        139	: M[i] := #$7B;	//	ã
        140	: M[i] := #$20;	//	å
        141	: M[i] := #$20;	//	ç
        142	: M[i] := #$5A;	//	é
        143	: M[i] := #$20;	//	è
        144	: M[i] := #$20;	//	ê
        145	: M[i] := #$EF;	//	ë
        146	: M[i] := #$F7;	//	í
        147	: M[i] := #$F9;	//	ì
        148	: M[i] := #$F9;	//	î
        149	: M[i] := #$FA;	//	ï
        150	: M[i] := #$F0;	//	ñ
        151	: M[i] := #$F0;	//	ó
        152	: M[i] := #$7E;	//	ò
        153	: M[i] := #$20;	//	ô
        154	: M[i] := #$73;	//	ö
        155	: M[i] := #$7D;	//	õ
        156	: M[i] := #$20;	//	ú
        157	: M[i] := #$20;	//	ù
        158	: M[i] := #$7A;	//	û
        159	: M[i] := #$59;	//	ü
        160	: M[i] := #$20;	//	†
        161	: M[i] := #$69;	//	°
        162	: M[i] := #$BD;	//	¢
        163	: M[i] := #$9C;	//	£
        164	: M[i] := #$CF;	//	§
        165	: M[i] := #$BE;	//	•
        166	: M[i] := #$DD;	//	¶
        167	: M[i] := #$F5;	//	ß
        168	: M[i] := #$20;	//	®
        169	: M[i] := #$20;	//	©
        170	: M[i] := #$A6;	//	™
        171	: M[i] := #$AF;	//	´
        172	: M[i] := #$FE;	//	¨
        173	: M[i] := #$F0;	//	≠
        174	: M[i] := #$52;	//	Æ
        175	: M[i] := #$EE;	//	Ø
        176	: M[i] := #$F8;	//	∞
        177	: M[i] := #$F1;	//	±
        178	: M[i] := #$FD;	//	≤
        179	: M[i] := #$FC;	//	≥
        180	: M[i] := #$EF;	//	¥
        181	: M[i] := #$E6;	//	µ
        182	: M[i] := #$F4;	//	∂
        183	: M[i] := #$FA;	//	∑
        184	: M[i] := #$2C;	//	∏
        185	: M[i] := #$FB;	//	π
        186	: M[i] := #$F8;	//	∫
        187	: M[i] := #$AF;	//	ª
        188	: M[i] := #$AC;	//	º
        189	: M[i] := #$AB;	//	Ω
        190	: M[i] := #$F3;	//	æ
        191	: M[i] := #$A8;	//	ø
        192	: M[i] := #$B7;	//	¿
        193	: M[i] := #$B5;	//	¡
        194	: M[i] := #$B6;	//	¬
        195	: M[i] := #$C7;	//	√
        196	: M[i] := #$8E;	//	ƒ
        197	: M[i] := #$8F;	//	≈
        198	: M[i] := #$92;	//	∆
        199	: M[i] := #$80;	//	«
        200	: M[i] := #$D4;	//	»
        201	: M[i] := #$90;	//	…
        202	: M[i] := #$D2;	//	 
        203	: M[i] := #$D3;	//	À
        204	: M[i] := #$DE;	//	Ã
        205	: M[i] := #$D6;	//	Õ
        206	: M[i] := #$D7;	//	Œ
        207	: M[i] := #$D8;	//	œ
        208	: M[i] := #$D1;	//	–
        209	: M[i] := #$A5;	//	—
        210	: M[i] := #$E3;	//	“
        211	: M[i] := #$E0;	//	”
        212	: M[i] := #$E2;	//	‘
        213	: M[i] := #$E5;	//	’
        214	: M[i] := #$99;	//	÷
        215	: M[i] := #$9E;	//	◊
        216	: M[i] := #$9D;	//	ÿ
        217	: M[i] := #$EB;	//	Ÿ
        218	: M[i] := #$E9;	//	⁄
        219	: M[i] := #$EA;	//	€
        220	: M[i] := #$9A;	//	‹
        221	: M[i] := #$ED;	//	›
        222	: M[i] := #$E7;	//	ﬁ
        223	: M[i] := #$E1;	//	ﬂ
        224	: M[i] := #$85;	//	‡
        225	: M[i] := #$A0;	//	·
        226	: M[i] := #$83;	//	‚
        227	: M[i] := #$C6;	//	„
        228	: M[i] := #$84;	//	‰
        229	: M[i] := #$86;	//	Â
        230	: M[i] := #$91;	//	Ê
        231	: M[i] := #$87;	//	Á
        232	: M[i] := #$8A;	//	Ë
        233	: M[i] := #$82;	//	È
        234	: M[i] := #$88;	//	Í
        235	: M[i] := #$89;	//	Î
        236	: M[i] := #$8D;	//	Ï
        237	: M[i] := #$A1;	//	Ì
        238	: M[i] := #$8C;	//	Ó
        239	: M[i] := #$8B;	//	Ô
        240	: M[i] := #$D0;	//	
        241	: M[i] := #$A4;	//	Ò
        242	: M[i] := #$95;	//	Ú
        243	: M[i] := #$A2;	//	Û
        244	: M[i] := #$93;	//	Ù
        245	: M[i] := #$E4;	//	ı
        246	: M[i] := #$94;	//	ˆ
        247	: M[i] := #$F6;	//	˜
        248	: M[i] := #$9B;	//	¯
        249	: M[i] := #$97;	//	˘
        250	: M[i] := #$A3;	//	˙
        251	: M[i] := #$96;	//	˚
        252	: M[i] := #$81;	//	¸
        253	: M[i] := #$EC;	//	˝
        254	: M[i] := #$E8;	//	˛
        255	: M[i] := #$98;	//	ˇ
      end;
    end
    else
      M[i] := Texto[i+1]
  end;
  Result := '';
  for i := 0 to Length(Texto)-1 do
    Result := Result + M[i];

end;

function Alltrim(Texto : String): String;
begin
  while Pos(' ',Texto) > 0 do
     Texto := Copy(Texto, 1, Pos(' ',Texto) - 1) + Copy(Texto, Pos(' ',Texto) + 1, 255);
  Result := Texto;
end;

function LeftTrim(Texto : String): String;
begin
  while Pos(' ',Texto) = 1 do
     Delete(Texto,1,1);
  Result := Texto;
end;

function RightTrim(Texto : String): String;
begin
  Texto := LeftTrim(Texto);
  Result := Texto;
  if Texto = '' then
  	exit;
  while True do
  begin
    if Texto[Length(Texto)] = ' ' then
      Texto := Copy(Texto, 1, Length(Texto)-1)
    else
    begin
      Result := Texto;
      Exit;
    end;
  end;
end;

function CustomStrToFloat(Texto: string):extended;
begin
	{elimina os separadores de milhar}
  if Texto = '' then
  	Texto := '0';
	while Pos('.', Texto) <> 0 do
		Delete(Texto, Pos('.',Texto), 1);
	Result := StrToFloat(Texto);
end;

function InformaSerialHd: string;
var NSerieHd:string;
    NomeVol, SisArq : String;
    NumSerial, Flags, TamMax : DWord;
begin
  NSerieHd := '';
  SetLength(NomeVol,255);
  SetLength(SisArq,255);
  GetVolumeInformation('\',PChar(NomeVol), 255, @NumSerial,
                       TamMax, Flags, PChar(SisArq), 255); //obs.: n„o deixar fixo o 'c:\'
  NSerieHd := IntToHex(NumSerial,8);
  Result := NSerieHd;
end;

//altera as constantes globais declaradas em SysUtils para portugues
Procedure DataPortugues;
begin
	LongMonthNames[1] := 'janeiro';
	LongMonthNames[2] := 'fevereiro';
	LongMonthNames[3] := 'marÁo';
	LongMonthNames[4] := 'abril';
	LongMonthNames[5] := 'maio';
	LongMonthNames[6] := 'junho';
	LongMonthNames[7] := 'julho';
	LongMonthNames[8] := 'agosto';
	LongMonthNames[9] := 'setembro';
	LongMonthNames[10] := 'outubro';
	LongMonthNames[11] := 'novembro';
	LongMonthNames[12] := 'dezembro';

	ShortMonthNames[1] := 'jan';
	ShortMonthNames[2] := 'fev';
	ShortMonthNames[3] := 'mar';
	ShortMonthNames[4] := 'abr';
	ShortMonthNames[5] := 'mai';
	ShortMonthNames[6] := 'jun';
	ShortMonthNames[7] := 'jul';
	ShortMonthNames[8] := 'ago';
	ShortMonthNames[9] := 'set';
	ShortMonthNames[10] := 'out';
	ShortMonthNames[11] := 'nov';
	ShortMonthNames[12] := 'dez';

	ShortdayNames[1] := 'dom';
	ShortdayNames[2] := 'seg';
	ShortdayNames[3] := 'ter';
	ShortdayNames[4] := 'qua';
	ShortdayNames[5] := 'qui';
	ShortdayNames[6] := 'sex';
	ShortdayNames[7] := 's·b';

 	LongdayNames[1] := 'domingo';
	LongdayNames[2] := 'segunda-feira';
	LongdayNames[3] := 'terÁa-feira';
	LongdayNames[4] := 'quarta-feira';
	LongdayNames[5] := 'quinta-feira';
	LongdayNames[6] := 'sexta-feira';
	LongdayNames[7] := 's·bado';

end;

function HexToInt(const HexStr: string): longint;
var iNdx: integer;
    cTmp: Char;
begin
  Result := 0;
  for iNdx := 1 to Length(HexStr) do
  begin
    cTmp := HexStr[iNdx];
    case cTmp of
      '0'..'9': Result := 16 * Result + (Ord(cTmp) - $30);
      'A'..'F': Result := 16 * Result + (Ord(cTmp) - $37);
      'a'..'f': Result := 16 * Result + (Ord(cTmp) - $57);
    else
      raise EConvertError.Create('Illegal character in hex string');
    end;
  end;
end;

//transforma a string Caracteres em comandos de impressora
//observe que Caracteres tem que trazer os comandos em hexa
//exemplo do argumento Caracteres: #$1B#$40#$1B#$78'0'#$1B#$4D#$0F
function ConfigCaracteres(Caracteres: string): String;
var Aux, CaracsControle: string;
    i, Contador: integer;
    Posicoes: array of integer;
    Comandos: array of string;
begin
  Aux := Caracteres;
  //"parsing" CaracsControle
  // 1∫ acha quantos # existem
  Contador := 0;
  for i := 1 to Length(Aux) do
    if Aux[i] = '#' then
      inc(Contador);
  //2∫ estabelece o tamanho de Posicoes e Comandos como o n∫ de # que existem
  SetLength(Posicoes, Contador);
  SetLength(Comandos, Contador);
  //3∫ preenche o array Posicoes
  Contador := 0;
  for i := 1 to Length(Aux) do
    if Aux[i] = '#' then
    begin
      Posicoes[Contador] := i;
      inc(Contador);
    end;
  //4∫ preenche o array Comandos
  for i := 0 to Contador - 1 do
  begin
    if  i < Contador-1 then
      Comandos[i] := Copy(Aux, Posicoes[i]+2, Posicoes[i+1]-Posicoes[i]-2)
    else
      Comandos[i] := Copy(Aux, Posicoes[i]+2, 255)
  end;

  //5∫ Cria os caracteres de controle para a impressora
  CaracsControle := '';

  for i := 0 to Contador - 1 do
  begin
    if Length(Comandos[i]) = 2 then
      CaracsControle := CaracsControle + Chr(HexToInt(Comandos[i]))
    else
    begin
      Aux := Copy( Comandos[i] , 1, Length(Comandos[i]) - 1);
      CaracsControle := CaracsControle + Chr(HexToInt( Copy(Comandos[i],1,2))) + Copy(Aux, 4, 255);
    end;
  end;

  Result := CaracsControle;

end;

//Coloca Texto em tantas linhas quantas forem a Largura atÈ um m·ximo de AlturaMax
function AcomodaTexto(Texto: String; Largura: integer): TStrings;
var NumLinhas: integer;
    AlturaMax, i: integer;
    aux: string;
begin
  AlturaMax := 4;
  Result := TStringList.Create;
  NumLinhas := Length(Texto) div Largura;
  if Length(Texto) mod Largura <> 0 then
    NumLinhas := NumLinhas+1;
  if NumLinhas > AlturaMax then
     NumLinhas := AlturaMax;

  for i := 1 to NumLinhas do
  begin
    Aux := Copy(Texto, 1 + Largura*(i-1) , Largura);
    {Case Alinhamento of
      alCentro: Aux := Centraliza(Aux, Largura);
      alDireita: Aux := AlinhaADireita(Aux, Largura);
    end;}
    while Length(Aux) < Largura do
      Aux := Aux + ' ';
    Result.Add( Aux );
  end;
end;

function ParseLinha(Linha: string; Separador: char): TStrings;
var Valores: TStrings;
    i, Cont: integer;
    PosSeparador: array of integer; //posiÁ„o do separador #173
begin
  Linha := Separador + Linha + Separador;
  //para achar o tamanho do array  PosSeparador:
  Cont := 0;
  for i := 1 to Length(Linha) do
  begin
    if Linha[i] = Separador then //≠=alt-0173
      inc(Cont);
  end;
  //estabelece o tamanho de  PosSeparador:
  SetLength(PosSeparador, Cont+2);

  //faz o "parsing"
  Cont := 0;
  for i := 1 to Length(Linha) do
  begin
    if Linha[i] = Separador then //≠=alt-0173
    begin
      inc(Cont);
      PosSeparador[Cont] := i;
    end;
  end;
  Valores := TStringList.Create;
  for i := 1 to Cont-1 do //valores
    Valores.Add(Copy(Linha, PosSeparador[i]+1 , PosSeparador[i+1]-PosSeparador[i]-1));

  result := Valores;

end;

function ENumeroInteiro(AString: string): Boolean;
var  i: Integer;
begin
  Result := True;
  for i := 1 to Length(AString) do
    if not (AString[i] in ['0'..'9']) then
    begin
      Result := False;
      Exit;
    end;

  if AString = '' then Result := False;
end;

function InformaDigitoEAN13(sNumero: string): integer;
var an: array[1..12] of integer;
    i: integer;
    Soma1, Soma2, Resto: integer;
begin
   Result := -1;
   if Length(sNumero) <> 12 then exit;
   for i := 1 to 12 do
     if not (sNumero[i] in ['0'..'9'] )then
        exit;

   for i := 1 to 12 do
     an[i] := StrToInt(Copy(sNumero,i,1));

   Soma1 := (an[12] + an[10] + an[8] + an[6] + an[4] + an[2])*3;
   Soma2 := an[11] + an[9] + an[7] + an[5] + an[3] + an[1];

   Resto := (Soma1+Soma2) mod 10;

   if Resto = 0 then
     Result := 0
   else
     Result := 10 - Resto;

end;

function VerificaEAN13(sNumero: string): boolean;
var  i: integer;
     an: array[1..13] of integer;
     Digito: integer;
begin
   Result := false;
   if Length(sNumero) <> 13 then exit;
   for i := 1 to 13 do
     if not (sNumero[i] in ['0'..'9'] )then
        exit;

   for i := 1 to 13 do
     an[i] := StrToInt(Copy(sNumero,i,1));

   Digito := InformaDigitoEAN13(Copy(sNumero,1,12));

   if Digito = an[13] then
     Result := true;
end;

function Arredonda(Numero:Double): Double;
var S: String;
begin
  Numero := Round(Numero*100) / 100;
  S := FormatFloat('0.000000',Numero);
  if Pos('.', S) <> 0 then
    S := Copy(S, 1, Pos('.', S) + 2)
  else if Pos(',', S) <> 0 then
    S := Copy(S, 1, Pos(',', S) + 2);

  Result := StrToFloat(S);
end;

{arredonda para n casas decimais e depois trunca}
function Arredonda(Valor : Extended; CasasDecimais : Byte) : Extended;
var i: Byte;
    formato: string;
    aux: string;
begin
  formato := '0.';
  for i := 1 To CasasDecimais do
      begin
      formato := formato + '0';
      end;
  aux := FormatFloat(formato,Valor);
  Result := StrToFloat (aux);
end;

function EliminaCaracteresDeControle(UmaString: string): string;
var i: integer;
begin
  Result := '';
  for i := 1 to Length(UmaString) do
  begin
    if not (UmaString[i] in [#0..#31]) then
      Result := Result + UmaString[i];
  end;
end;


//coloca o texto todo em letras maiusculas considerando acentos
function Maiuscula(Texto: string): string;
var i, j: integer;
const min = '·‚‡‰„ÈÍËÎÌÓÏÔÛÙÚˆı˙˚˘¸ÁÒ';
      mai = '¡¬¿ƒ√… »ÀÕŒÃœ”‘“÷’⁄€Ÿ‹«—';
begin
  Texto := Uppercase(Texto);
  for i := 1 to Length(min) do
  begin
    for j := 1 to Length(Texto) do
    begin
      if  min[i] = Texto[j] then
         Texto := Copy(Texto, 1, j-1) + mai[i] + Copy(Texto, j+1, Length(Texto));
    end;
  end;
  Result := Texto;
end;

end.


