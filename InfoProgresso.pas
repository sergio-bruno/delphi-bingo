unit InfoProgresso;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls,
  StdCtrls;                                 

type
  TfrmInfoProgresso = class(TForm)
    panProgresso: TPanel;
    lblMensagem: TLabel;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInfoProgresso: TfrmInfoProgresso;

implementation

{$R *.DFM}

end.
