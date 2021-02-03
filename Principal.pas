unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ExtCtrls, jpeg;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    mnuRelatorios: TMenuItem;
    mniImpressaoCartelas: TMenuItem;
    mnuGerenciamento: TMenuItem;
    mniConfiguraSorteio: TMenuItem;
    mnuSair: TMenuItem;
    stbBanco: TStatusBar;
    Image2: TImage;
    Image1: TImage;
    procedure mnuSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mniImpressaoCartelasClick(Sender: TObject);
    procedure mniConfiguraSorteioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses clsBD, Sorteios;

{$R *.dfm}

procedure TfrmPrincipal.mnuSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var oBD: TBD;
    Banco: string;
begin
  //mudado do fim para ocomeço da procedure em 18/04/2006
  //verifica e faz alterações no BD a partir de um banco padrão
  oBD := TBD.Create;
  try
    if oBD.Executa(Banco) then
    begin
      stbBanco.Font.Style := [fsBold];
      stbBanco.Font.Color := clRed;
      stbBanco.Panels[0].Text := Banco;
    end
    else
    begin
      Beep;
      stbBanco.Font.Style := [fsBold];
      stbBanco.Font.Color := clRed;
      stbBanco.Panels[0].Text := 'Seu banco de dados pode estar desatualizado. Entre em contato com a In Control.';
      stbBanco.Hint := oBD.Mensagem;
    end
  finally
    oBD.Free;
  end;    
end;

procedure TfrmPrincipal.mniImpressaoCartelasClick(Sender: TObject);
begin
  //
end;

procedure TfrmPrincipal.mniConfiguraSorteioClick(Sender: TObject);
var i: integer;
begin
  for i := MDIChildCount-1 downto 0 do
  begin
    if MDIChildren[i] = frmSorteios then
    begin
      MDIChildren[i].BringToFront;
      MDIChildren[i].WindowState := wsNormal;
      Exit;
    end;
  end;
  try
    Screen.Cursor := crHourglass;
    Application.CreateForm(TfrmSorteios, frmSorteios);
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
