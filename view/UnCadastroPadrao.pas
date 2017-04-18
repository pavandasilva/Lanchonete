unit UnCadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB, Datasnap.DBClient,
  Vcl.ImgList, Vcl.ToolWin, Vcl.TabNotBk, Vcl.Buttons, UnShowMessages, UnCliente,
  Vcl.Grids, Vcl.DBGrids, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, Vcl.Mask, UnFormControl, System.Actions, Vcl.ActnList,
  Vcl.Menus;
type
  TModoData = (tInsert, tUpdate, tDelete, tCancel);
  TfrmCadastroPadrao = class(TForm)
    pnTopo: TPanel;
    imgFechar: TImage;
    ImageList1: TImageList;
    pcPAdrao: TPageControl;
    tshNavegacao: TTabSheet;
    tshEdicao: TTabSheet;
    tbNavegacao: TToolBar;
    BtnAdicionar: TToolButton;
    btnExcluir: TToolButton;
    btnEditar: TToolButton;
    pnBtnsNAv: TPanel;
    pnBotton: TPanel;
    ToolBar1: TToolBar;
    btnSalvar: TToolButton;
    btnCancelar: TToolButton;
    edtBuscar: TEdit;
    btnBuscar: TImage;
    ListView1: TListView;
    ActionList1: TActionList;
    ActAdicionar: TAction;
    ActEditar: TAction;
    ActDeletar: TAction;
    ActCancelar: TAction;
    ActSalvar: TAction;
    PopupMenu1: TPopupMenu;
    Adicionar1: TMenuItem;
    ActDeletar1: TMenuItem;
    procedure imgFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure ActAdicionarExecute(Sender: TObject);
    procedure ActEditarExecute(Sender: TObject);
    procedure ActDeletarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActSalvarExecute(Sender: TObject);
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnTopoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    ModoData : TModoData;
  public
    procedure Deletar; virtual;
    procedure Editar; virtual;
    procedure Adicionar; virtual;
    procedure Atualizar; virtual;
    procedure BuscarDados; virtual;
    procedure ConfigFormulario;
    procedure Cancelar; virtual;
    procedure Salvar; virtual;
    procedure Inserir; virtual;
  end;
var
  frmCadastroPadrao: TfrmCadastroPadrao;
implementation
{$R *.dfm}
procedure TfrmCadastroPadrao.FormCreate(Sender: TObject);
begin
   //esconda as tabs do PageControl
  ConfigFormulario;
  BuscarDados;

end;
procedure TfrmCadastroPadrao.FormShow(Sender: TObject);
begin
  edtBuscar.SetFocus;
end;

procedure TfrmCadastroPadrao.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroPadrao.Inserir;
begin
  pcPAdrao.ActivePageIndex := 0;
end;

procedure TfrmCadastroPadrao.ListView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbright then
  begin
    if ListView1.Selected = nil then
      exit;
    PopupMenu1.Popup(Mouse.CursorPos.x, Mouse.CursorPos.y);
end;
end;
procedure TfrmCadastroPadrao.pnTopoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbleft then
  begin
    ReleaseCapture;
    Self.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;
procedure TfrmCadastroPadrao.Salvar;
begin
  if ModoData = tUpdate then
    Atualizar
  else if
    ModoData = tInsert then
      Inserir;
end;
procedure TfrmCadastroPadrao.Cancelar;
begin
  pcPAdrao.ActivePageIndex := 0;
  BuscarDados;
end;

procedure TfrmCadastroPadrao.ConfigFormulario;
begin
  tshNavegacao.TabVisible:= false;
  tshEdicao.TabVisible:= false;
  pcPAdrao.ActivePageIndex:= 0;
end;

procedure TfrmCadastroPadrao.Deletar;
begin
   showMEssage('Deletar');

end;

procedure TfrmCadastroPadrao.Editar;
begin
  if ListView1.Selected <> nil then
  begin
    ModoData := tUpdate;
    pcPAdrao.ActivePageIndex := 1;
  end;
end;

procedure TfrmCadastroPadrao.edtBuscarKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
  begin
    key := #0;//coloca o key em 0 para nao emitir nenhum bip
    BuscarDados;
  end;
end;

procedure TfrmCadastroPadrao.ActAdicionarExecute(Sender: TObject);
begin
  Adicionar;
end;

procedure TfrmCadastroPadrao.ActCancelarExecute(Sender: TObject);
begin
  Cancelar;
end;

procedure TfrmCadastroPadrao.ActDeletarExecute(Sender: TObject);
begin
  Deletar;
end;

procedure TfrmCadastroPadrao.ActEditarExecute(Sender: TObject);
begin
  Editar;
end;

procedure TfrmCadastroPadrao.ActSalvarExecute(Sender: TObject);
begin
  Salvar;
end;
procedure TfrmCadastroPadrao.Adicionar;
begin
  pcPAdrao.ActivePageIndex := 1;
  ModoData := tInsert;
end;
procedure TfrmCadastroPadrao.Atualizar;
begin
  ShowMEssage('Atualizar');
end;
procedure TfrmCadastroPadrao.btnBuscarClick(Sender: TObject);
begin
  BuscarDados;
end;
procedure TfrmCadastroPadrao.btnCancelarClick(Sender: TObject);
begin
   ModoData := tCancel;
   pcPAdrao.ActivePageIndex := 0;
   BuscarDados;
end;
procedure TfrmCadastroPadrao.btnExcluirClick(Sender: TObject);
begin
  if ListView1.Selected  = nil then
  begin
    frmShowMessages.showMessage(iError, 'Escolha um registro para excluir.');
    exit;
  end
  else
  begin
    ModoData := tDelete;
    pcPAdrao.ActivePageIndex := 0;
    Deletar;
  end;
end;
procedure TfrmCadastroPadrao.btnSalvarClick(Sender: TObject);
begin
  if ModoData = tInsert then
    Adicionar
  else if ModoData = tUpdate then
    Atualizar;

end;
procedure TfrmCadastroPadrao.BuscarDados;
begin
  showMEssage('BuscarDados');
end;


end.
