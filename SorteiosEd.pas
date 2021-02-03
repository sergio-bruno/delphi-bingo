unit SorteiosEd;
                   
interface          
                   
uses               
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask;
                   
type               
  TfrmSorteiosEd = class(TForm)
    lblCODIGO: TLabel;
    lblNomeSorteio: TLabel;
    lblApoio: TLabel;
    lblData: TLabel;
    lblPrecoCartela: TLabel;
    lblLocal: TLabel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    Shape1: TShape;
    lblNumeroLoop: TLabel;
    btnPesqLocal: TSpeedButton;
    lblHora: TLabel;
    lblDataCadastro: TLabel;
    EditCodigo: TEdit;
    EditNomeSorteio: TEdit;
    EditCodLocal: TEdit;
    EditPrecoCartela: TEdit;
    EditApoio: TEdit;
    EditNumeroLoop: TEdit;
    EditDescLocal: TEdit;
    EditHora: TMaskEdit;
    EditDataCadastro: TMaskEdit;
    EditData: TMaskEdit;

    procedure FormActivate(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure EditCodigoEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditCodLocalExit(Sender: TObject);
    procedure btnPesqLocalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSorteiosEd: TfrmSorteiosEd;

implementation

uses clsLOCAL, Pesquisa;

{$R *.DFM}

procedure TfrmSorteiosEd.FormActivate(Sender: TObject);
begin
  EditNomeSorteio.SetFocus;
end;

procedure TfrmSorteiosEd.btnSalvarClick(Sender: TObject);
var i: integer;
    Temp: TComponent;
begin
  ModalResult := mrNone;
  //elimina "leading and trailing blanks"
  for i := ComponentCount - 1 downto 0 do
  begin
    Temp := Components[i];
    if Temp is TEdit then
      (Temp as TEdit).Text := Trim((Temp as TEdit).Text)
    else if Temp is TMaskEdit then
       (Temp as TMaskEdit).Text := Trim((Temp as TMaskEdit).Text);
  end;

	//**criticas
  if EditNomeSorteio.Text = '' then
  begin
    MessageDlg('Nome do Sorteio em branco.', mtWarning, [mbOk],0);
    EditNomeSorteio.SetFocus;
  end
  else if (EditCodLocal.Text = '') then //or (EditDescLocal.Text = '')
  begin
    MessageDlg('Local em branco.', mtWarning, [mbOk],0);
    EditCodLocal.SetFocus;
  end
  //...
  else
    ModalResult := mrOK;
end;

procedure TfrmSorteiosEd.EditCodigoEnter(Sender: TObject);
begin
  Shape1.Parent := (Sender as TControl).Parent;
  Shape1.Left := (Sender as TControl).Left - 2;
  Shape1.Top := (Sender as TControl).Top - 2;
  Shape1.Width := (Sender as TControl).Width + 4;
  Shape1.Height := (Sender as TControl).Height + 4;
end;

procedure TfrmSorteiosEd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F5 then
    btnPesqLocal.Click
  else if Key = VK_F12 then
    btnSalvar.Click;
end;

procedure TfrmSorteiosEd.EditCodLocalExit(Sender: TObject);
var oLocal: TLOCAL;
begin
  if trim(EditCodLocal.Text) = '' then
    exit;

  oLocal := TLOCAL.Create;
  try
    oLocal.CODIGO := StrToInt(EditCodLocal.Text);
    if oLocal.Ler then
      EditDescLocal.Text := oLocal.NomeLocal
    else
      EditDescLocal.Text := '';
  finally
    oLocal.Free;
  end;
end;

procedure TfrmSorteiosEd.btnPesqLocalClick(Sender: TObject);
begin
  Application.CreateForm(TfrmPesquisa, frmPesquisa);
  try
    frmPesquisa.Width := 455; //355
    frmPesquisa.Left := Left + EditDescLocal.Left + 2;
    frmPesquisa.Top := Top + (Height - ClientHeight) + (btnPesqLocal.Top + btnPesqLocal.Height) - 4;
    frmPesquisa.ibqPesquisa.Close;
    frmPesquisa.ibqPesquisa.SQL.Text := 'SELECT CODIGO, NOMELOCAL FROM LOCAL '+
      'WHERE NOMELOCAL STARTING WITH :parInicio '+
      'ORDER BY NOMELOCAL';
    frmPesquisa.ShowModal;
    if frmPesquisa.ModalResult = mrOK then
    begin
      EditCodLocal.Text := frmPesquisa.ibqPesquisa.Fields[0].AsString;
      EditDescLocal.Text := frmPesquisa.ibqPesquisa.Fields[1].AsString;
    end;
  finally
  	frmPesquisa.Free;
  end;
end;

end.
