object dmDados: TdmDados
  OldCreateOrder = False
  Left = 345
  Top = 177
  Height = 244
  Width = 354
  object IBDatabase: TIBDatabase
    Params.Strings = (
      'USER_NAME=sysdba'
      'PASSWORD=masterkey'
      'lc_ctype=WIN1252')
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 48
    Top = 28
  end
end
