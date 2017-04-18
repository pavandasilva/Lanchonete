unit UnPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  Vcl.ActnMenus, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ImgList, UnClienteView,
  UnProdutoView, UnVendaEntregaView, Vcl.Buttons, UnConfigView, IniFiles,
  UnShowMessages, UnFormControl;

type
  TfrmPrincipal = class(TForm)
    pnTopo: TPanel;
    ActionList1: TActionList;
    actClientes: TAction;
    ilMenuPrincipal: TImageList;
    ToolBar1: TToolBar;
    tbClientes: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ActProdutos: TAction;
    ActPedidoEntrega: TAction;
    actRelatorioVendas: TAction;
    actInfo: TAction;
    Panel1: TPanel;
    ToolBar2: TToolBar;
    ToolButton7: TToolButton;
    ToolButton1: TToolButton;
    actConfig: TAction;
    ToolButton2: TToolButton;
    actClose: TAction;
    procedure Image1Click(Sender: TObject);
    procedure ActProdutosExecute(Sender: TObject);
    procedure actClientesExecute(Sender: TObject);
    procedure ActPedidoEntregaExecute(Sender: TObject);
    procedure actConfigExecute(Sender: TObject);
    procedure actRelatorioVendasExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    const
      _iniPath = 'config/config.ini';
      procedure PreenchePanelTop;
  public
    { Public declarations }
  end;
var
  frmPrincipal: TfrmPrincipal;
implementation
{$R *.dfm}

uses UnRelatorioVendasView;


procedure TfrmPrincipal.actClientesExecute(Sender: TObject);
begin
  if not Assigned(frmCliente) then
    frmCliente := TfrmCliente.Create(self);
  frmCliente.Show;
end;
procedure TfrmPrincipal.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.actConfigExecute(Sender: TObject);
begin
  if not Assigned(frmConfigView)  then
    frmConfigView := TfrmConfigView.Create(self);
  frmConfigView.Show;
end;

procedure TfrmPrincipal.ActPedidoEntregaExecute(Sender: TObject);
begin
if not Assigned(frmVendaEntregaView)  then
    frmVendaEntregaView := TfrmVendaEntregaView.Create(self);
  frmVendaEntregaView.Show;
end;

procedure TfrmPrincipal.ActProdutosExecute(Sender: TObject);
begin
  if not Assigned(frmProdutoView) then
    frmProdutoView := TfrmProdutoView.Create(Self);
  frmProdutoView.Show;
end;
procedure TfrmPrincipal.actRelatorioVendasExecute(Sender: TObject);
begin
  if frmRelatorioVendasView = nil then
    frmRelatorioVendasView := TfrmRelatorioVendasView.Create(self);
  frmRelatorioVendasView.Show;
end;


procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  PreenchePanelTop; //Personaliza o texto do panel do topo
end;

procedure TfrmPrincipal.Image1Click(Sender: TObject);
begin
   Close;
end;
procedure TfrmPrincipal.PreenchePanelTop;
var
  umIniFile : TIniFile;
begin
  umIniFile := TIniFile.Create(_iniPath);
  try
    pnTopo.Caption := ' ' + umIniFile.ReadString('store','fantasia', '');
  finally
    umIniFile.Free;
  end;

end;

initialization
    ReportMemoryLeaksOnShutdown := True;
end.
