unit Pesquisa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Buttons, Db, IBCustomDataSet,
  IBQuery, IBDatabase;

type
  TfrmPesquisa = class(TForm)
    DBGrid1: TDBGrid;
    btnTransferir: TSpeedButton;
    btnCancelar: TSpeedButton;
    ibqPesquisa: TIBQuery;
    DataSource1: TDataSource;
    IBTransaction1: TIBTransaction;
    edtPesquisa: TEdit;
    procedure btnTransferirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtPesquisaChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

uses Dados;

{$R *.DFM}

procedure TfrmPesquisa.btnTransferirClick(Sender: TObject);
begin
  if ibqPesquisa.Active then
    ModalResult := mrOK
  else
    ModalResult := mrCancel;
end;

procedure TfrmPesquisa.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmPesquisa.FormActivate(Sender: TObject);
begin
  with ibqPesquisa do
  begin
    Close;
    Params[0].AsString := edtPesquisa.Text;
    Open;
  end;
  edtPesquisa.SetFocus;
  edtPesquisa.SelStart := 50;
end;

procedure TfrmPesquisa.edtPesquisaChange(Sender: TObject);
begin
  with ibqPesquisa do
  begin
    Close;
    Params[0].AsString := edtPesquisa.Text;
    Open;
  end;
end;

procedure TfrmPesquisa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnTransferirClick(Sender)
  else if key = #27 then
    btnCancelarClick(Sender);
end;

procedure TfrmPesquisa.FormCreate(Sender: TObject);
begin
  IBTransaction1.DefaultDatabase := dmDados.IBDatabase;
  ibqPesquisa.Database := dmDados.IBDatabase;
end;

end.
