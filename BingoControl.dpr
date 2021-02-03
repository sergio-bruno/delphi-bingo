program BingoControl;

uses
  Forms,
  Principal in 'Principal.pas' {frmPrincipal},
  Dados in 'Dados.pas' {dmDados: TDataModule},
  clsBD in 'clsBD.pas',
  InfoProgresso in 'InfoProgresso.pas' {frmInfoProgresso},
  clsControladorArqCfg in 'clsControladorArqCfg.pas',
  FuncStrings in 'FuncStrings.pas',
  SorteiosEd in 'SorteiosEd.pas' {frmSorteiosEd},
  Sorteios in 'Sorteios.pas' {frmSorteios},
  clsSORTEIOS in 'clsSORTEIOS.pas',
  clsLOCAL in 'clsLOCAL.pas',
  Pesquisa in 'Pesquisa.pas' {frmPesquisa};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Bingo - Control';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
