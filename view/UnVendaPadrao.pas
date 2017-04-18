unit UnVendaPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB, Datasnap.DBClient,
  Vcl.ImgList, Vcl.ToolWin, Vcl.TabNotBk, Vcl.Buttons, UnShowMessages, UnCliente,
  Vcl.Grids, Vcl.DBGrids, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, Vcl.Mask, UnFormControl, System.Actions, Vcl.ActnList,
  Vcl.Menus, UnClienteModel, UnClienteView, Contnrs;
type
  TModoData = (tInsert, tUpdate, tDelete, tCancel);
  TfrmVendaPadrao = class(TForm)
    pnTopo: TPanel;
    imgFechar: TImage;
    ImageList1: TImageList;
    pcPAdrao: TPageControl;
    tshTela1: TTabSheet;
    tshTela2: TTabSheet;
    ListView1: TListView;
    ActionList1: TActionList;
    PopupMenu1: TPopupMenu;
    Adicionar1: TMenuItem;
    ActDeletar1: TMenuItem;
    Panel1: TPanel;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    lbNavegacao: TLabel;
    pnBtnsNAv: TPanel;
    btnBuscar: TImage;
    tbNavegacao: TToolBar;
    BtnAdicionar: TToolButton;
    edtBuscar: TEdit;
    ActTela2: TAction;
    ActTela1: TAction;
    ActTela3: TAction;
    edtProdutoId: TEdit;
    Label1: TLabel;
    lvObservacao: TListView;
    Label2: TLabel;
    Label3: TLabel;
    edtProduto: TEdit;
    Button1: TButton;
    ActAddProdutoPedido: TAction;
    procedure pnTopoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure edtBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure ActTela2Execute(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure ActTela1Execute(Sender: TObject);
    procedure ActTela3Execute(Sender: TObject);
    procedure ActAddProdutoPedidoExecute(Sender: TObject);   //Faz o clique do botao direito do mouse no List VIew

  private
    ModoData : TModoData;
  public
  procedure BuscarClientes;
  procedure ConfigListView;
  procedure EscondeTabs;
  procedure PreencherListView;
  procedure IrTela2;virtual;
  procedure IrTela1; virtual;
  procedure IrTela3; virtual;
  procedure AddProdutoPedido;
  end;
var
  frmVendaPadrao: TfrmVendaPadrao;
  umaListaCliente : TObjectList;
implementation
{$R *.dfm}


{ TfrmVendaPadrao }
procedure TfrmVendaPadrao.FormCreate(Sender: TObject);
begin
  BuscarClientes;    //traz uma lista clientes conforme o digitado no campo de busca
  ConfigListView; //preenche o list view com a lista de clientes
  EscondeTabs;      //esconde as abas do PageControl
  PreencherListView;
  IrTela1;
end;
procedure TfrmVendaPadrao.ActAddProdutoPedidoExecute(Sender: TObject);
begin
  AddProdutoPedido;
end;

procedure TfrmVendaPadrao.ActTela1Execute(Sender: TObject);
begin
  IrTela1;
end;

procedure TfrmVendaPadrao.ActTela2Execute(Sender: TObject);
begin
  IrTela2;
end;


procedure TfrmVendaPadrao.ActTela3Execute(Sender: TObject);
begin
  IrTela3;
end;

procedure TfrmVendaPadrao.AddProdutoPedido;
begin
  shoWMessage('add ProdutoPedido');
end;

procedure TfrmVendaPadrao.btnBuscarClick(Sender: TObject);
begin
  BuscarClientes;
  PreencherListView;
end;

procedure TfrmVendaPadrao.BuscarClientes;
var
  umCliente : TCliente;
  umClienteModel : TCLienteModel;
begin
  umCliente := TCLiente.Create;
  umClienteModel := TCLienteModel.Create;
  if umaListaCliente <> nil then
    FreeAndNil(umaListaCliente);
  try
    umaListaCliente := umClienteModel.Buscar(edtBuscar.Text);
  finally
    umClienteModel.Free;
    umCLiente.Free;
  end;
end;

procedure TfrmVendaPadrao.PreencherListView;
var
  I           : Integer;
  umCliente   : TCliente;
  umListItem  : TListItem;
begin
  ListView1.Clear;
  ListView1.Items.BeginUpdate;
  for I := 0 to umaListaCliente.Count - 1 do
  begin
    umListItem := ListView1.Items.Add;
    umListItem.Caption := IntToStr(TCLiente(umaListaCliente.Items[I]).Id);
    umListItem.SubItems.Add(TCLiente(umaListaCliente.Items[I]).Nome);
    umListItem.SubItems.Add(TCLiente(umaListaCliente.Items[I]).Tel);
    umListItem.SubItems.Add(TCLiente(umaListaCliente.Items[I]).Cel);
    umListItem.SubItems.Add(TCLiente(umaListaCliente.Items[I]).Endereco);
    umListItem.SubItems.Add(TCLiente(umaListaCliente.Items[I]).Bairro);
  end;
  ListView1.Items.EndUpdate;
end;

procedure TfrmVendaPadrao.EscondeTabs;
begin
  tshTela1.TabVisible:= false;
  tshTela2.TabVisible:= false;
  pcPAdrao.ActivePageIndex:= 0;
end;



procedure TfrmVendaPadrao.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmVendaPadrao.IrTela1;
begin
  lbNavegacao.Caption := 'Escolha o Cliente para iniciar a venda';
  pcPAdrao.ActivePageIndex:= 0;
end;

procedure TfrmVendaPadrao.IrTela2;
begin
  if ListView1.Selected <> nil then
  begin
    lbNavegacao.Caption := 'Escolha os produtos';
    pcPAdrao.ActivePageIndex:= 1

  end
  else
    frmShowMessages.showMessage(iError,'Escolha um Cliente antes de avançar.');
end;

procedure TfrmVendaPadrao.IrTela3;
begin

end;

procedure TfrmVendaPadrao.ListView1DblClick(Sender: TObject);
begin
  if ListView1.Selected <> nil then
    IrTela2;
end;

procedure TfrmVendaPadrao.pnTopoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  if Button = mbleft then
  begin
    ReleaseCapture;
    Self.Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;
procedure TfrmVendaPadrao.ConfigListView;
var
  I : Integer;
  ListColunn : TListColumn;
  umCLiente : TCliente;
  Fields : TStringList;
begin
  umCliente := TCliente.Create;
  try
    Fields := umCLiente.FieldsView;
    for I := 0 to Fields.Count - 1 do
    begin
      ListColunn := ListView1.Columns.Add;
      ListColunn.Caption := Fields.Strings[I];
      if I = 0 then
      begin
        ListColunn.AutoSize := false;
        ListColunn.Width := 75;
      end
      else
        ListColunn.AutoSize := true;
    end;
  finally
    umCLiente.Free;
  end;
end;
procedure TfrmVendaPadrao.edtBuscarKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    key := #0;//coloca o key em 0 para nao emitir nenhum bip
    BuscarClientes;
    PreencherListView;
  end;
end;

procedure TfrmVendaPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;



procedure TfrmVendaPadrao.FormDestroy(Sender: TObject);
begin
  frmVendaPadrao := nil;
  FreeAndNil(umaListaCliente);
end;
end.
