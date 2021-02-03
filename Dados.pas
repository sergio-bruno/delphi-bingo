unit Dados;

interface

uses
  SysUtils, Classes, DB, IBDatabase;

type
  TdmDados = class(TDataModule)
    IBDatabase: TIBDatabase;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDados: TdmDados;

implementation

{$R *.dfm}

end.
