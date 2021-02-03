object frmSorteios: TfrmSorteios
  Left = 168
  Top = 208
  Caption = 'Sorteios'
  ClientHeight = 402
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu1
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 31
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 0
    object btnIncluir: TSpeedButton
      Left = 2
      Top = 3
      Width = 25
      Height = 25
      Hint = 'Incluir  Ctrl+I'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btnIncluirClick
    end
    object btnExcluir: TSpeedButton
      Left = 52
      Top = 3
      Width = 25
      Height = 25
      Hint = 'Excluir  Ctrl+X'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btnExcluirClick
    end
    object btnPesquisar: TSpeedButton
      Left = 399
      Top = 3
      Width = 25
      Height = 25
      Hint = 'Pesquisa conforme o campo ordem  F3'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333FF3FF3333333333CC30003333333333773777333333333C33
        3000333FF33337F33777339933333C3333333377F33337F3333F339933333C33
        33003377333337F33377333333333C333300333F333337F33377339333333C33
        3333337FF3333733333F33993333C33333003377FF33733333773339933C3333
        330033377FF73F33337733339933C33333333FF377F373F3333F993399333C33
        330077F377F337F33377993399333C33330077FF773337F33377399993333C33
        33333777733337F333FF333333333C33300033333333373FF7773333333333CC
        3000333333333377377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btnPesquisarClick
    end
    object Label1: TLabel
      Left = 255
      Top = 8
      Width = 34
      Height = 13
      Caption = '&Ordem:'
      FocusControl = cboOrdem
    end
    object Bevel1: TBevel
      Left = 455
      Top = 0
      Width = 5
      Height = 50
      Shape = bsLeftLine
    end
    object Bevel2: TBevel
      Left = 248
      Top = -22
      Width = 5
      Height = 56
      Shape = bsLeftLine
    end
    object btnEditar: TSpeedButton
      Left = 27
      Top = 3
      Width = 25
      Height = 25
      Hint = 'Editar  Ctrl+E'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = btnEditarClick
    end
    object btnAtualizarDados: TSpeedButton
      Left = 77
      Top = 3
      Width = 25
      Height = 25
      Hint = 'Atualizar dados'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF33339993707399933333773337F3777FF3399933000339
        9933377333777F3377F3399333707333993337733337333337FF993333333333
        399377F33333F333377F993333303333399377F33337FF333373993333707333
        333377F333777F333333993333101333333377F333777F3FFFFF993333000399
        999377FF33777F77777F3993330003399993373FF3777F37777F399933000333
        99933773FF777F3F777F339993707399999333773F373F77777F333999999999
        3393333777333777337333333999993333333333377777333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      Spacing = 5
      OnClick = btnAtualizarDadosClick
    end
    object cboOrdem: TComboBox
      Left = 291
      Top = 5
      Width = 105
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      TabStop = False
      Text = 'C'#211'DIGO'
      OnChange = cboOrdemChange
      Items.Strings = (
        'C'#211'DIGO'
        'NOME')
    end
    object panRegistros: TPanel
      Left = 461
      Top = 7
      Width = 69
      Height = 17
      BevelOuter = bvLowered
      Caption = 'regs.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object DBNavigator1: TDBNavigator
      Left = 130
      Top = 3
      Width = 100
      Height = 25
      DataSource = DataSource1
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 31
    Width = 584
    Height = 154
    Align = alTop
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDblClick = btnEditarClick
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 185
    Width = 584
    Height = 217
    ActivePage = tbsClientes
    Align = alClient
    TabOrder = 2
    object tbsClientes: TTabSheet
      Caption = '&Premia'#231#245'es'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 576
        Height = 29
        Align = alTop
        TabOrder = 0
        object btnIncluir2: TSpeedButton
          Left = 6
          Top = 3
          Width = 25
          Height = 25
          Hint = 'Incluir Clientes ao Conv'#234'nio  Ctrl+C'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33333333FF33333333FF333993333333300033377F3333333777333993333333
            300033F77FFF3333377739999993333333333777777F3333333F399999933333
            33003777777333333377333993333333330033377F3333333377333993333333
            3333333773333333333F333333333333330033333333F33333773333333C3333
            330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
            993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
            333333333337733333FF3333333C333330003333333733333777333333333333
            3000333333333333377733333333333333333333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          Spacing = 5
          OnClick = btnIncluir2Click
        end
        object btnExcluir2: TSpeedButton
          Left = 56
          Top = 3
          Width = 25
          Height = 25
          Hint = 'Excluir Cliente do Conv'#234'nio  Ctrl+E'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333FF33333333333330003333333333333777333333333333
            300033FFFFFF3333377739999993333333333777777F3333333F399999933333
            3300377777733333337733333333333333003333333333333377333333333333
            3333333333333333333F333333333333330033333F33333333773333C3333333
            330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
            993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
            333333377F33333333FF3333C333333330003333733333333777333333333333
            3000333333333333377733333333333333333333333333333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          Spacing = 5
          OnClick = btnExcluir2Click
        end
        object btnEditar2: TSpeedButton
          Left = 31
          Top = 3
          Width = 25
          Height = 25
          Hint = 'Editar C'#243'd. Externo  Ctrl+O'
          Enabled = False
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
            000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
            00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
            F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
            0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
            FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
            FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
            0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
            00333377737FFFFF773333303300000003333337337777777333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          Visible = False
        end
        object Bevel3: TBevel
          Left = 455
          Top = -21
          Width = 5
          Height = 50
          Shape = bsLeftLine
        end
        object panRegistros2: TPanel
          Left = 461
          Top = 7
          Width = 69
          Height = 17
          BevelOuter = bvLowered
          Caption = 'regs.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 29
        Width = 576
        Height = 160
        Align = alClient
        TabOrder = 1
        object DBGrid2: TDBGrid
          Left = 1
          Top = 1
          Width = 574
          Height = 158
          Align = alClient
          DataSource = DataSource2
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
  end
  object IBQuery1: TIBQuery
    Database = dmDados.IBDatabase
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT SORTEIOS.*, LOCAL.NOMELOCAL'
      'FROM SORTEIOS INNER JOIN'
      '            LOCAL ON LOCAL.CODIGO = SORTEIOS.CODLOCAL'
      'ORDER BY SORTEIOS.CODIGO DESC'
      '')
    Left = 216
    Top = 100
    object IBQuery1CODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 6
      FieldName = 'CODIGO'
      Origin = 'SORTEIOS.CODIGO'
      Required = True
    end
    object IBQuery1NUMEROLOOP: TIntegerField
      DisplayLabel = 'N'#186' Loop'
      DisplayWidth = 8
      FieldName = 'NUMEROLOOP'
      Origin = 'SORTEIOS.NUMEROLOOP'
      Required = True
    end
    object IBQuery1NOMESORTEIO: TIBStringField
      DisplayLabel = 'Sorteio'
      DisplayWidth = 40
      FieldName = 'NOMESORTEIO'
      Origin = 'SORTEIOS.NOMESORTEIO'
      Size = 60
    end
    object IBQuery1NOMELOCAL: TIBStringField
      DisplayLabel = 'Local'
      DisplayWidth = 30
      FieldName = 'NOMELOCAL'
      Origin = 'LOCAL.NOMELOCAL'
      Size = 60
    end
    object IBQuery1DATA: TDateField
      DisplayLabel = 'Data Sorteio'
      FieldName = 'DATA'
      Origin = 'SORTEIOS.DATA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object IBQuery1HORA: TTimeField
      DisplayLabel = 'Hora'
      DisplayWidth = 6
      FieldName = 'HORA'
      Origin = 'SORTEIOS.HORA'
      DisplayFormat = 'MM:SS'
    end
    object IBQuery1PRECOCARTELA: TFloatField
      DisplayLabel = 'Pr'#231'. Cartela'
      FieldName = 'PRECOCARTELA'
      Origin = 'SORTEIOS.PRECOCARTELA'
      DisplayFormat = '###,##0.00'
    end
    object IBQuery1APOIO: TIBStringField
      DisplayLabel = 'Apoio'
      DisplayWidth = 40
      FieldName = 'APOIO'
      Origin = 'SORTEIOS.APOIO'
      Size = 60
    end
    object IBQuery1DATACADASTRO: TDateField
      DisplayLabel = 'Dt. Cadastro'
      FieldName = 'DATACADASTRO'
      Origin = 'SORTEIOS.DATACADASTRO'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object IBQuery1CODLOCAL: TIntegerField
      FieldName = 'CODLOCAL'
      Origin = 'SORTEIOS.CODLOCAL'
      Visible = False
    end
  end
  object MainMenu1: TMainMenu
    Left = 418
    Top = 106
    object mniMenu1: TMenuItem
      Caption = '[&1-Sorteios]'
      Checked = True
      GroupIndex = 1
      object mniIncluir: TMenuItem
        Caption = '&Incluir'
        ShortCut = 16457
        OnClick = btnIncluirClick
      end
      object mniEditar: TMenuItem
        Caption = '&Editar'
        ShortCut = 16453
        OnClick = btnEditarClick
      end
      object mniExcluir: TMenuItem
        Caption = 'E&xcluir'
        ShortCut = 16472
        OnClick = btnExcluirClick
      end
      object mniAtualizarDados: TMenuItem
        Caption = '&Atualizar Dados'
        OnClick = btnAtualizarDadosClick
      end
      object mniPesquisar: TMenuItem
        Caption = '&Pesquisar'
        Hint = 'Pesquisa conforme o campo ordem'
        ShortCut = 114
        OnClick = btnPesquisarClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mniFechar: TMenuItem
        Caption = '&Fechar'
        ShortCut = 16499
        OnClick = mniFecharClick
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = IBQuery1
    OnDataChange = DataSource1DataChange
    Left = 320
    Top = 111
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = dmDados.IBDatabase
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 148
    Top = 100
  end
  object IBQuery2: TIBQuery
    Database = dmDados.IBDatabase
    Transaction = IBTransaction1
    DataSource = DataSource1
    SQL.Strings = (
      
        'SELECT CV.CODCLIENTE, CV.CODVENDEDOR, CV.CODAREA, AREAS.DESCRICA' +
        'O,'
      '       CLI.NOME, CLI.TIPO, ENDBAIRRO, ENDCIDADE'
      '  FROM CLIE_VENDEDOR CV INNER JOIN'
      '       CLIENTES CLI ON (CLI.CODIGO = CV.CODCLIENTE) INNER JOIN'
      '       AREAS ON (AREAS.CODIGO = CV.CODAREA)'
      'WHERE (CV.ATIVO = '#39'T'#39')'
      '  AND (CLI.ATIVO = '#39'T'#39')'
      '  AND (CV.CODVENDEDOR = :CODIGO)'
      'ORDER BY CV.CODAREA, CLI.NOME')
    Left = 104
    Top = 201
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODIGO'
        ParamType = ptUnknown
      end>
    object IBQuery2CODCLIENTE: TIntegerField
      FieldName = 'CODCLIENTE'
      Origin = 'CLIE_VENDEDOR.CODCLIENTE'
      Required = True
      Visible = False
    end
    object IBQuery2CODVENDEDOR: TIntegerField
      FieldName = 'CODVENDEDOR'
      Origin = 'CLIE_VENDEDOR.CODVENDEDOR'
      Required = True
      Visible = False
    end
    object IBQuery2CODAREA: TIntegerField
      FieldName = 'CODAREA'
      Origin = 'CLIE_VENDEDOR.CODAREA'
      Required = True
      Visible = False
    end
    object IBQuery2DESCRICAO: TIBStringField
      DisplayLabel = #193'rea'
      FieldName = 'DESCRICAO'
      Origin = 'AREAS.DESCRICAO'
      Size = 30
    end
    object IBQuery2NOME: TIBStringField
      DisplayLabel = 'Cliente'
      FieldName = 'NOME'
      Origin = 'CLIENTES.NOME'
      Size = 40
    end
    object IBQuery2TIPO: TIBStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Origin = 'CLIENTES.TIPO'
      Size = 1
    end
    object IBQuery2ENDBAIRRO: TIBStringField
      DisplayLabel = 'Bairro'
      DisplayWidth = 20
      FieldName = 'ENDBAIRRO'
      Origin = 'CLIENTES.ENDBAIRRO'
      Size = 25
    end
    object IBQuery2ENDCIDADE: TIBStringField
      DisplayLabel = 'Cidade'
      DisplayWidth = 20
      FieldName = 'ENDCIDADE'
      Origin = 'CLIENTES.ENDCIDADE'
      Size = 25
    end
  end
  object DataSource2: TDataSource
    DataSet = IBQuery2
    Left = 96
    Top = 265
  end
end
