object frmSorteiosEd: TfrmSorteiosEd
  Left = 195
  Top = 226
  BorderStyle = bsDialog
  Caption = 'Sorteios'
  ClientHeight = 273
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblCODIGO: TLabel
    Left = 20
    Top = 22
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'C'#243'digo'
  end
  object lblNomeSorteio: TLabel
    Left = 20
    Top = 44
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Nome Sorteio (*)'
  end
  object lblApoio: TLabel
    Left = 20
    Top = 155
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Apoio (*)'
  end
  object lblData: TLabel
    Left = 20
    Top = 89
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Data do Sorteio (*)'
  end
  object lblPrecoCartela: TLabel
    Left = 20
    Top = 133
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Pre'#231'o da Cartela (*)'
  end
  object lblLocal: TLabel
    Left = 20
    Top = 67
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Local (*)'
  end
  object lblCamposObrigatorios: TLabel
    Left = 6
    Top = 223
    Width = 108
    Height = 13
    Caption = '(*) Campos obrigat'#243'rios'
  end
  object Shape1: TShape
    Left = 344
    Top = 34
    Width = 65
    Height = 65
    Brush.Color = clBlue
    Pen.Color = clBlue
  end
  object lblNumeroLoop: TLabel
    Left = 194
    Top = 22
    Width = 48
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'N'#186' Loop'
  end
  object btnPesqLocal: TSpeedButton
    Left = 379
    Top = 63
    Width = 33
    Height = 21
    Hint = 'Procura Cliente'
    Caption = '? F5'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = btnPesqLocalClick
  end
  object lblHora: TLabel
    Left = 20
    Top = 111
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Hora do Sorteio (*)'
  end
  object lblDataCadastro: TLabel
    Left = 20
    Top = 177
    Width = 100
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Data de Cadastro'
  end
  object btnSalvar: TBitBtn
    Left = 6
    Top = 238
    Width = 100
    Height = 25
    Caption = '&Salvar  F12'
    ModalResult = 1
    TabOrder = 0
    OnClick = btnSalvarClick
    OnEnter = EditCodigoEnter
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btnCancelar: TBitBtn
    Left = 118
    Top = 238
    Width = 100
    Height = 25
    Caption = 'Cancelar  Esc'
    TabOrder = 1
    OnEnter = EditCodigoEnter
    Kind = bkCancel
  end
  object EditCodigo: TEdit
    Left = 126
    Top = 19
    Width = 75
    Height = 21
    TabOrder = 2
    Text = 'EditCodigo'
  end
  object EditNomeSorteio: TEdit
    Left = 126
    Top = 41
    Width = 75
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object EditCodLocal: TEdit
    Left = 126
    Top = 63
    Width = 75
    Height = 21
    TabOrder = 4
    Text = 'Edit1'
  end
  object EditPrecoCartela: TEdit
    Left = 126
    Top = 129
    Width = 75
    Height = 21
    TabOrder = 5
    Text = 'EditPrecoCartela'
  end
  object EditApoio: TEdit
    Left = 126
    Top = 151
    Width = 75
    Height = 21
    TabOrder = 6
    Text = 'Edit1'
  end
  object EditNumeroLoop: TEdit
    Left = 248
    Top = 19
    Width = 75
    Height = 21
    TabOrder = 7
    Text = 'Edit1'
  end
  object EditDescLocal: TEdit
    Left = 207
    Top = 63
    Width = 121
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 8
    Text = 'EditDescLocal'
  end
  object EditHora: TMaskEdit
    Left = 126
    Top = 107
    Width = 75
    Height = 21
    TabOrder = 9
    Text = 'EditHora'
  end
  object EditDataCadastro: TMaskEdit
    Left = 126
    Top = 174
    Width = 75
    Height = 21
    TabOrder = 10
    Text = 'EditDataCadastro'
  end
  object EditData: TMaskEdit
    Left = 126
    Top = 85
    Width = 75
    Height = 21
    TabOrder = 11
    Text = 'EditData'
  end
end
