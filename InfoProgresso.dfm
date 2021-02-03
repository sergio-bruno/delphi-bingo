object frmInfoProgresso: TfrmInfoProgresso
  Left = 116
  Top = 176
  Cursor = crSQLWait
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Iniciando  Gerenciador...'
  ClientHeight = 235
  ClientWidth = 492
  Color = clBtnFace
  Enabled = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object panProgresso: TPanel
    Left = 0
    Top = 0
    Width = 492
    Height = 235
    Align = alClient
    BevelOuter = bvSpace
    BevelWidth = 3
    BorderStyle = bsSingle
    Caption = 'Verificando estrutura do banco de dados...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lblMensagem: TLabel
      Left = 3
      Top = 143
      Width = 482
      Height = 20
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblMensagem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Image1: TImage
      Left = 164
      Top = 18
      Width = 160
      Height = 71
      Stretch = True
    end
  end
end
