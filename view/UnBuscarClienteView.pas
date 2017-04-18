unit UnBuscarClienteView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    pnBtnsNAv: TPanel;
    btnBuscar: TImage;
    tbNavegacao: TToolBar;
    edtBuscar: TEdit;
    pnTopo: TPanel;
    imgFechar: TImage;
    lbNavegacao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
