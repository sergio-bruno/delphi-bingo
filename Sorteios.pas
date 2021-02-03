unit Sorteios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  Db, StdCtrls, Mask, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, Buttons, IBDatabase,
  IBCustomDataSet, DBCtrls, IBQuery, Controls;

type
  TfrmSorteios = class(TForm)
    IBQuery1: TIBQuery;
    Panel4: TPanel;
    btnIncluir: TSpeedButton;
    btnExcluir: TSpeedButton;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    cboOrdem: TComboBox;
    panRegistros: TPanel;
    MainMenu1: TMainMenu;
    mniMenu1: TMenuItem;
    mniIncluir: TMenuItem;
    mniEditar: TMenuItem;
    mniExcluir: TMenuItem;
    N2: TMenuItem;
    mniAtualizarDados: TMenuItem;
    DataSource1: TDataSource;
    mniFechar: TMenuItem;
    btnEditar: TSpeedButton;
    btnAtualizarDados: TSpeedButton;
    btnPesquisar: TSpeedButton;
    mniPesquisar: TMenuItem;
    DBGrid1: TDBGrid;
    IBTransaction1: TIBTransaction;
    DBNavigator1: TDBNavigator;
    PageControl1: TPageControl;
    tbsClientes: TTabSheet;
    Panel1: TPanel;
    btnIncluir2: TSpeedButton;
    btnExcluir2: TSpeedButton;
    btnEditar2: TSpeedButton;
    Panel2: TPanel;
    DBGrid2: TDBGrid;
    IBQuery2: TIBQuery;
    DataSource2: TDataSource;
    IBQuery2CODCLIENTE: TIntegerField;
    IBQuery2CODVENDEDOR: TIntegerField;
    IBQuery2CODAREA: TIntegerField;
    IBQuery2DESCRICAO: TIBStringField;
    IBQuery2NOME: TIBStringField;
    IBQuery2TIPO: TIBStringField;
    IBQuery2ENDBAIRRO: TIBStringField;
    IBQuery2ENDCIDADE: TIBStringField;
    Bevel3: TBevel;
    panRegistros2: TPanel;
    IBQuery1CODIGO: TIntegerField;
    IBQuery1NUMEROLOOP: TIntegerField;
    IBQuery1NOMESORTEIO: TIBStringField;
    IBQuery1CODLOCAL: TIntegerField;
    IBQuery1DATA: TDateField;
    IBQuery1HORA: TTimeField;
    IBQuery1PRECOCARTELA: TFloatField;
    IBQuery1APOIO: TIBStringField;
    IBQuery1DATACADASTRO: TDateField;
    IBQuery1NOMELOCAL: TIBStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mniFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAtualizarDadosClick(Sender: TObject);
    procedure cboOrdemChange(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnIncluir2Click(Sender: TObject);
    procedure btnExcluir2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    procedure PreparaFormED(LimpaCampos: boolean);
  public
    { Public declarations }
    procedure AtualizaDados;
  end;

var
  frmSorteios: TfrmSorteios;

implementation

uses Dados, clsSORTEIOS, SorteiosEd, FuncStrings;

{$R *.DFM}

//**eventos do Form
procedure TfrmSorteios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmSorteios.FormCreate(Sender: TObject);
var oSorteios: TSorteios;
begin
 	Top :=0; Left := 0;
  IBTransaction1.DefaultDatabase := dmDados.IBDatabase;
  IBQuery1.Database := dmDados.IBDatabase;
  IBQuery2.Database := dmDados.IBDatabase;
  oSorteios := TSorteios.Create;
  try
    Screen.Cursor := crHourglass;
    IBQuery1.Open;
//...    IBQuery2.Open;

    panRegistros.Caption := IntToStr(oSorteios.InformaQtdSorteios) + ' regs.';
    cboOrdem.ItemIndex := 1;
  finally
    Screen.Cursor := crDefault;
    IBQuery1.EnableControls;
    oSorteios.Free;
  end;
end;

procedure TfrmSorteios.mniFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSorteios.btnIncluirClick(Sender: TObject);
var oSorteios: TSorteios;
    numeroLoop: integer;
begin
  Application.CreateForm(TfrmSorteiosEd, frmSorteiosEd);
  with frmSorteiosED do
  begin
    //**Limpa os campos em ED e seta MaxLength
    PreparaFormED(True);
    numeroLoop := MinsPerHour;
    EditDataCadastro.Text := FormatDateTime('dd/mm/yyyy', Date);
    //...

    ShowModal;
    if ModalResult = mrOK then
    begin
      //**inclui o registro
      oSorteios := TSorteios.Create;
      try
        Screen.Cursor := crHourglass;

        oSorteios.NumeroLoop := numeroLoop;
        oSorteios.NomeSorteio := EditNomeSorteio.Text;
        oSorteios.CodLocal := StrToInt(EditCodLocal.Text);
        oSorteios.Data := StrToDateTime(EditData.Text);
        oSorteios.Hora := StrToDateTime(EditHora.Text);
        oSorteios.PrecoCartela := CustomStrToFloat(EditPrecoCartela.Text);
        oSorteios.Apoio := EditApoio.Text;
        oSorteios.DataCadastro := Date;
        if not oSorteios.Incluir then
        begin
          MessageDlg('Ocorreu um erro na inclusão.', mtError, [mbOk], 0);
          exit;
        end;
        AtualizaDados;
        IBQuery1.Last;
        panRegistros.Caption := IntToStr(oSorteios.InformaQtdSorteios) + ' regs.';
      finally
        Screen.Cursor := crDefault;
        IBQuery1.EnableControls;
        oSorteios.Free;
      end;
    end;
  end;
  frmSorteiosEd.Free;
end;

procedure TfrmSorteios.btnEditarClick(Sender: TObject);
//var oSorteios: TSorteios;
begin
{
  Application.CreateForm(TfrmSorteiosEd, frmSorteiosEd);
  with frmSorteiosED do
  begin
    //**preenche os campos para edição e estabelece MaxLength
    PreparaFormED(false);
    PreencheEditxVarNumericas;
    ShowModal;
    if ModalResult = mrOK then
    begin
      //**modifica o registro
      Sorteios := TSorteios.Create;
      try
        Screen.Cursor := crHourglass;

        Sorteios.CODIGO := StrToInt(EditCODIGO.Text);
        Sorteios.NOME := EditNOME.Text;
        Sorteios.ABREVIATURA := EditABREVIATURA.Text;
        Sorteios.CPF := EditCPF.Text;
        Sorteios.COMISSAO := uCurCOMISSAO; //**(numérico)
        Sorteios.COTAVALOR := uCurCOTAVALOR; //**(numérico)
        Sorteios.COTAQUANTIDADE := uIntCOTAQUANTIDADE; //**(numérico)
        if not Sorteios.Gravar then
        begin
          MessageDlg('Ocorreu um erro na edição de um vendedor.', mtError, [mbOk], 0);
          exit;
        end;
        AtualizaDados;
        IBQuery1.Locate('CODIGO', StrToInt(EditCODIGO.Text),[]);
      finally
        Screen.Cursor := crDefault;
        IBQuery1.EnableControls;
        Sorteios.Free;
      end;
    end;
  end;
  frmSorteiosEd.Free;}
end;

procedure TfrmSorteios.btnExcluirClick(Sender: TObject);
var oSorteios: TSorteios;
begin
  if MessageDlg('Excluir registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    //**deleta o registro
    oSorteios := TSorteios.Create;
    try
      Screen.Cursor := crHourglass;

      oSorteios.CODIGO := IBQuery1.Fields[0].AsInteger;
      if not oSorteios.Excluir then
      begin
        MessageDlg('Não é possível excluir porque há movimentos para este Sorteio.', mtWarning, [mbOk], 0);
        exit;
      end;
      AtualizaDados;
      panRegistros.Caption := IntToStr(oSorteios.InformaQtdSorteios) + ' regs.';
    finally
      Screen.Cursor := crDefault;
      IBQuery1.EnableControls;
      oSorteios.Free;
    end;
  end;
end;

procedure TfrmSorteios.cboOrdemChange(Sender: TObject);
begin
  AtualizaDados;
end;

procedure TfrmSorteios.btnPesquisarClick(Sender: TObject);
var
  ClickedOK: Boolean;
  Resposta: String;
  Numero: integer;
begin
  if cboOrdem.ItemIndex = 0 then
  begin
    ClickedOK := InputQuery('Pesquisa', 'Informe o código:', Resposta);
    if ClickedOK then
    with IBQuery1 do
    begin
        try
          Numero := StrToInt(Resposta);
        except
          on EConvertError do
          begin
            MessageDlg('O valor informado não é válido.', mtWarning, [mbOk], 0);
            Exit;
          end;
        end;
        if not Locate('CODIGO', Numero, []) then
        begin
          MessageDlg('Registro não encontrado.', mtWarning, [mbOk], 0);
          btnPesquisarClick(Sender);
        end;
    end;
  end
  else if cboOrdem.ItemIndex = 1 then
  begin
    ClickedOK := InputQuery('Pesquisa', 'Informe A descrição:', Resposta);
    if ClickedOK then
      IBQuery1.Locate('NOME', UpperCase(RESPOSTA),[loPartialKey]);
  end;
end;

//**funcoes definidas
procedure TfrmSorteios.PreparaFormED(LimpaCampos: boolean);
var i,j: integer;
    Temp: TComponent;
    Aux: string;
begin
  with frmSorteiosED do
  begin
    for i := 0 to IBQuery1.FieldCount - 1 do
    begin
      Aux := IBQuery1.Fields[i].FieldName;
      for j := ComponentCount - 1 downto 0 do
      begin
        Temp := Components[j];
        if UpperCase(Temp.Name) = UpperCase('Edit' + Aux) then
        begin
           if LimpaCampos then
             (Temp as TCustomEdit).Clear
           else
           begin
             if Temp is TEdit then
               (Temp as TEdit).Text := IBQuery1.Fields[i].DisplayText
             else if Temp is TEdit then
               (Temp as TEdit).Text := IBQuery1.Fields[i].AsString
             else if Temp is TMaskEdit then
               (Temp as TMaskEdit).Text := IBQuery1.Fields[i].AsString;
           end;
           if Temp is TEdit then
             (Temp as TEdit).MaxLength := IBQuery1.Fields[i].Size;
           Break;
        end;
      end;
    end;
  end;
end;

procedure TfrmSorteios.btnAtualizarDadosClick(Sender: TObject);
begin
  AtualizaDados;
end;

procedure TfrmSorteios.AtualizaDados;
begin
  try
    Screen.Cursor := crHourglass;
    IBQuery1.DisableControls;
    IBQuery1.Close;
    IBQuery1.SQL.Clear;
    IBQuery1.SQL.Add('SELECT SORTEIOS.*, LOCAL.NOMELOCAL ');
    IBQuery1.SQL.Add('FROM SORTEIOS INNER JOIN ');
    IBQuery1.SQL.Add('     LOCAL ON LOCAL.CODIGO = SORTEIOS.CODLOCAL ');
    if cboOrdem.ItemIndex = 0 then
      IBQuery1.SQL.Add('ORDER BY SORTEIOS.CODIGO')
    else if cboOrdem.ItemIndex = 1 then
      IBQuery1.SQL.Add('ORDER BY SORTEIOS.NOMESORTEIO');
    IBQuery1.Open;
//...    IBQuery2.Open;
  finally
    Screen.Cursor := crDefault;
    IBQuery1.EnableControls;
  end;
  DBGrid1.Setfocus
end;

procedure TfrmSorteios.btnIncluir2Click(Sender: TObject);
//var oClie_Vendedor: TCLIE_VENDEDOR;
begin
{  if IBQuery1CODIGO.AsString = '' then
  	exit;

  with frmClie_VendedorED do
  begin
    //**Chama o form de Edicao
    EditCODVENDEDOR.Text := IBQuery1CODIGO.AsString;
    EditDESCVENDEDOR.Text := IBQuery1NOME.AsString;
    EditCODCLIENTE.Text := '';
    EditDESCCLIENTE.Text := '';
    EditCODAREA.Text := '';
    EditDescArea.Text := '';
    ShowModal;
    //**inclui o registro
    if ModalResult = mrOK then
    begin
      oClie_Vendedor := TCLIE_VENDEDOR.Create;
      try
        Screen.Cursor := crHourglass;
        IBQuery2.DisableControls;

        oClie_Vendedor.CODVENDEDOR := IBQuery1CODIGO.AsInteger; //**CODCONVENIO
        oClie_Vendedor.CODCLIENTE := StrToInt(EditCODCLIENTE.Text);
        if not oClie_Vendedor.Ler then
        begin
          oClie_Vendedor.CODAREA := StrToInt(EditCODAREA.Text);
          oClie_Vendedor.ATIVO := true;
          if not oClie_Vendedor.Incluir then
          begin
            MessageDlg('Ocorreu um erro na inclusão de um Cliente no vendedor', mtError, [mbOk], 0);
            exit;
          end;
        end
        else
          MessageDlg('Cliente já existente. Não pode ser incluido novamente.', mtWarning, [mbOk], 0);
        //**atualiza query
        DataSource1DataChange(Sender, nil);
        IBQuery2.Close;
        IBQuery2.Open;
        IBQuery2.Locate('CODCLIENTE', oClie_Vendedor.CODCLIENTE,[]);
      finally
        Screen.Cursor := crDefault;
        IBQuery2.EnableControls;
        oClie_Vendedor.Free;
      end;
    end;
  end;}
end;

procedure TfrmSorteios.btnExcluir2Click(Sender: TObject);
//var oClie_Vendedor: TCLIE_VENDEDOR;
begin
{  if not IBQuery2.Active then
    exit;
  if IBQuery2CODVENDEDOR.AsString = '' then
  	exit;

  if MessageDlg('Excluir registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    //**verifica se é possível excluir

    //**deleta o registro
    oClie_Vendedor := TCLIE_VENDEDOR.Create;
    try
      Screen.Cursor := crHourglass;
      IBQuery2.DisableControls;

      oClie_Vendedor.CODCLIENTE := IBQuery2CODCLIENTE.AsInteger;
      oClie_Vendedor.CODVENDEDOR := IBQuery2CODVENDEDOR.AsInteger;
      if not oClie_Vendedor.Excluir then
      begin
        MessageDlg('Ocorreu um erro na exclusão de um Cliente de um Vendedor.', mtError, [mbOk], 0);
        exit;
      end;
      //**atualiza query
      DataSource1DataChange(Sender, nil);
      IBQuery2.Close;
      IBQuery2.Open;
    finally
      Screen.Cursor := crDefault;
      IBQuery2.EnableControls;
      oClie_Vendedor.Free;
    end;
  end;}
end;

procedure TfrmSorteios.DataSource1DataChange(Sender: TObject;
  Field: TField);
//var oClie_Vendedor: TCLIE_VENDEDOR;
begin
{  oClie_Vendedor := TCLIE_VENDEDOR.Create;
  try
    oClie_Vendedor.CODVENDEDOR := IBQuery2CODVENDEDOR.AsInteger;
    panRegistros2.Caption := IntToStr(oClie_Vendedor.RetornaTotalporVendedor) + ' regs.';

  finally
    Screen.Cursor := crDefault;
    IBQuery2.EnableControls;
    oClie_Vendedor.Free;
  end;}
end;

end.
