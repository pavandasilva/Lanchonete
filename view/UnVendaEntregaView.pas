unit UnVendaEntregaView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Data.DB, Datasnap.DBClient,
  Vcl.ImgList, Vcl.ToolWin, Vcl.TabNotBk, Vcl.Buttons, UnShowMessages, UnCliente,
  Vcl.Grids, Vcl.DBGrids, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  Data.Bind.DBScope, Vcl.Mask, UnFormControl, System.Actions, Vcl.ActnList,
  Vcl.Menus, UnClienteModel, UnClienteView, Contnrs, UnBuscarProdutoView,
  UnPedido, UnPedidoModel, UnProduto, UnProdutoModel, UnProdutoPedido,
  UnProdutoPedidoModel, UnPagamento, Vcl.Printers, IniFiles;
type
  TModoData = (tInsert, tUpdate, tDelete, tCancel);
  TfrmVendaEntregaVIew = class(TForm)
    pnTopo: TPanel;
    imgFechar: TImage;
    ImageList1: TImageList;
    ActionList1: TActionList;
    PopupMenu1: TPopupMenu;
    Adicionar1: TMenuItem;
    ActDeletar1: TMenuItem;
    ActTela2: TAction;
    ActTela1: TAction;
    ActTela3: TAction;
    ActAddProdutoPedido: TAction;
    ActBuscaProduto: TAction;
    pcPAdrao: TPageControl;
    tshTela1: TTabSheet;
    ListView1: TListView;
    pnBtnsNAv: TPanel;
    btnBuscar: TImage;
    tbNavegacao: TToolBar;
    BtnAdicionar: TToolButton;
    edtBuscar: TEdit;
    tshTela2: TTabSheet;
    Panel1: TPanel;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Action1: TAction;
    tshTela3: TTabSheet;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    ToolButton4: TToolButton;
    ActSalvarPedido: TAction;
    meObs: TMemo;
    paFormulario: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    edtQtde: TEdit;
    edtProdutoId: TEdit;
    edtProduto: TEdit;
    paListView: TPanel;
    lvPedido: TListView;
    meDetalhePedido: TMemo;
    paMemo: TPanel;
    lbTotal: TLabel;
    paPagamento: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    EdtTroco: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    cbPagamento: TComboBox;
    ToolButton3: TToolButton;
    laTotal: TLabel;
    cbImprimir: TCheckBox;
    Label10: TLabel;
    procedure pnTopoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure edtBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure ActTela2Execute(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure ActTela1Execute(Sender: TObject);
    procedure ActTela3Execute(Sender: TObject);
    procedure ActAddProdutoPedidoExecute(Sender: TObject);
    procedure ActBuscaProdutoExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure paFormularioDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ActSalvarPedidoExecute(Sender: TObject);
    procedure edtProdutoIdExit(Sender: TObject);
    procedure edtProdutoIdKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutoEnter(Sender: TObject);
    procedure edtQtdeEnter(Sender: TObject);
    procedure meObsEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cbPagamentoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure paFormularioDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure edtQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure paMemoEnter(Sender: TObject);
    procedure meDetalhePedidoClick(Sender: TObject);   //Faz o clique do botao direito do mouse no List VIew
  private
    procedure AdicionarItemnaLista;
    procedure NovoPedido;
    function BuscarTaxaEntrega: Real;
    procedure Imprimir;
    function GeraStringListPedido:TStringList;
    procedure ConfiguraCheckBoxImprimir;
    procedure CriarLogPedido;
    const
      _pathIni = 'config/config.ini';
  public
  procedure BuscarClientes;
  procedure ConfigListView;
  procedure ConfigListViewPedido;
  procedure EscondeTabs;
  procedure PreencherListViewCliente;
  procedure IrTela2;virtual;
  procedure IrTela1; virtual;
  procedure IrTela3; virtual;
  procedure AddProdutoPedido;
  procedure BuscarProduto;
  procedure LimparCamposItem;
  procedure AddItemListViewPedido(AProdutoPedido : TProdutoPedido);
  procedure BuscarFormasPagamento;
  procedure PreencherCombosPagamento;
  procedure SalvarPedido;
  procedure destroyObj(AObj : Tobject);
  procedure CarregarProdutoFormulario;
  procedure PreencherMemo;
  procedure PreencherLabelTotal2;
  procedure PreencherLabelTotal3;
  end;
var
  frmVendaEntregaVIew: TfrmVendaEntregaVIew;
  umaListaCliente : TObjectList;
  umPedido : TPedido;
  umaListaPagamento : TObjectList;
implementation
{$R *.dfm}
{ TfrmVendaPadrao }
procedure TfrmVendaEntregaVIew.FormCreate(Sender: TObject);
begin
  configuraCheckBoxImprimir;
  umFormControl.EditFormatCurrency(EdtTroco);

  umPedido := TPedido.Create;
  umPedido.TaxaEntrega := BuscarTaxaEntrega;
  BuscarClientes;    //traz uma lista clientes conforme o digitado no campo de busca
  ConfigListView; //preenche o list view com a lista de clientes
  ConfigListViewPedido; //coloca os nomes das colunas no listview(tela 2)
  EscondeTabs;      //esconde as abas do PageControl
  PreencherListViewCliente; //preenche o listview com os dados dos clientes(Tela1)
  BuscarFormasPagamento; // traz uma lista de modos de pagamento
  PreencherCombosPagamento;// coloca a lista de pagamento no combobox forma de pagamento(Tela 3)
  IrTela1;   //vai para a tela 1
end;
procedure TfrmVendaEntregaVIew.FormDestroy(Sender: TObject);
begin
  FreeAndNil(umaListaPagamento);
  FreeAndNil(umPedido);
  destroyObj(umaListaProduto);
  FreeAndNil(umaListaCliente);
  frmVendaEntregaVIew := nil;
end;
procedure TfrmVendaEntregaVIew.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key:= #0;
    SelectNext(Sender as TWinControl, True, True);
  end;
end;

procedure TfrmVendaEntregaVIew.FormShow(Sender: TObject);
begin
  edtBuscar.SetFocus;
end;

function TfrmVendaEntregaVIew.GeraStringListPedido:TStringlist;
var
  umIniFile : TIniFile;
  umStrings : TStrings;
  I : Integer;
begin
   result := TStringList.Create;
   umIniFile := TIniFile.Create(_pathIni);
   try
     result.Add('Nome Fantasia:'+umIniFile.ReadString('store','fantasia',''));
     result.Add('Razão Social:'+umIniFile.ReadString('store','razao',''));
     result.Add('CNPJ:'+umIniFile.ReadString('store','cnpj',''));
     result.Add('Endereco:'+umIniFile.ReadString('store','endereco',''));
     result.Add('Bairro:'+umIniFile.ReadString('store','bairro',''));
     result.Add('Telefone:'+umIniFile.ReadString('store','telefone','') + ' '+umIniFile.ReadString('store','telefone2',''));
     result.Add('====================================================');
     result.Add('CODIGO No ' + IntToStr(umPedido.ID));
     result.Add(DateTimeToStr(Now));
     result.Add('====================================================');
     result.Add('ITENS:');
     for I := 0 to umPedido.ListaProduto.Count - 1 do
     begin
        result.Add(TProdutoPedido(umPedido.ListaProduto.Items[I]).Produto.Descricao + ' '
        + FormatFloat('R$ 0....,00',TProdutoPedido(umPedido.ListaProduto.Items[I]).Produto.Valor) + ' x '
        + IntToStr(TProdutoPedido(umPedido.ListaProduto.Items[I]).Quantidade) + 'UN = '
        + FormatFloat('R$ 0....,00',TProdutoPedido(umPedido.ListaProduto.Items[I]).Total));
     end;
     result.Add('=====================================================');
     result.Add('PRODUTOS   : ' + FormatFloat('R$ 0....,00,',umPedido.TotalLiquido));
     result.Add('ENTREGA    : ' + FormatFloat('R$ 0....,00',umPedido.TaxaEntrega));
     result.Add('TROCO PARA : ' + FormatFloat('R$ 0....,00',umPedido.ValorPago) + '('+FormatFloat('R$ 0....,00',umPedido.ValorPago - umPedido.Total)+')');
     result.Add('=====================================================');
     result.Add('DADOS DO CLIENTE:');
     result.Add('CLIENTE  : ' + TCliente(umPedido.Cliente).Nome);
     result.Add('ENDERECO : ' + TCliente(umPedido.Cliente).Endereco);
     result.Add('BAIRRO   : ' + TCliente(umPedido.Cliente).BAIRRO);
   finally
     umIniFile.Free;
   end;

end;

procedure TfrmVendaEntregaVIew.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;
procedure TfrmVendaEntregaVIew.ActAddProdutoPedidoExecute(Sender: TObject);
begin  // se o TEdido do id do produto não tiver nada no seu conteudo interrompe a execução
  if edtProdutoId.Text = '' then
  begin
    frmShowMessages.showMessage(ierror, 'Por favor, escolha um produto.');
    edtProdutoId.SetFocus;
    Exit;
  end
  else  if edtQtde.Text = '' then
  begin
    frmShowMessages.showMessage(ierror, 'Por favor, defina quantos desse produto quer adicionar em seu pedido.');
    edtQtde.SetFocus;
    Exit;
  end;
  AddProdutoPedido; //adiciona o produto no pedido
  PreencherLabelTotal2;
  LimparCamposItem;
end;
procedure TfrmVendaEntregaVIew.ActBuscaProdutoExecute(Sender: TObject);
begin
  BuscarProduto;
end;
procedure TfrmVendaEntregaVIew.ActSalvarPedidoExecute(Sender: TObject);
begin
  if cbPagamento.ItemIndex = - 1 then  //se nenhuma forma de pagamento foi selecionada
  begin
    frmShowMessages.showMessage(iError, 'Escolha uma forma de pagamento.');
    cbPagamento.SetFocus;
    Exit;
  end;
  SalvarPedido; //salva o pedido
  CriarLogPedido;
  if cbImprimir.Checked then   //se o usuario quiser que imprima
    Imprimir;
  Close;
end;
procedure TfrmVendaEntregaVIew.ActTela1Execute(Sender: TObject);
begin
  IrTela1;
end;
procedure TfrmVendaEntregaVIew.ActTela2Execute(Sender: TObject);
begin
  IrTela2;
end;
procedure TfrmVendaEntregaVIew.ActTela3Execute(Sender: TObject);
begin
  IrTela3;
end;
procedure TfrmVendaEntregaVIew.AddItemListViewPedido(AProdutoPedido : TProdutoPedido);
var
  umListItem : TListItem;
begin
  lvPedido.Items.BeginUpdate;
  umListItem := lvPedido.Items.Add;
  umListItem.Caption := IntToStr(AProdutoPedido.Quantidade);
  umListItem.SubItems.Add(AProdutoPedido.Produto.Descricao);
  umListItem.SubItems.Add(FormatFloat('R$ #....,00',AProdutoPedido.Produto.Valor));
  umListItem.SubItems.Add(FormatFloat('R$ #....,00',AProdutoPedido.Total));
  umListItem.SubItems.Add(AProdutoPedido.Observação);
  lvPedido.Items.EndUpdate;
end;
procedure TfrmVendaEntregaVIew.AddProdutoPedido;
begin
  AdicionarItemnaLista; //adiciona itens no listview e na Listade Produtos
end;
procedure TfrmVendaEntregaView.AdicionarItemnaLista;
var
  umProdutoModel : TProdutoModel;
  umProdutoPedido : TProdutoPedido;
  umProduto : TProduto;
begin
  umProdutoModel := TProdutoModel.Create;
  umProdutoPedido := TProdutoPedido.Create;
  try
    if edtQtde.Text <> '' then
    begin
      umProduto := umProdutoModel.BuscarPorId(StrToInt(edtProdutoId.Text));//budca um produto passando o id do produto
      umProdutoPedido.Produto := umProduto;
      umProdutoPedido.Quantidade := StrToInt(edtQtde.Text);
      umPedido.SetListaProduto(umProdutoPedido); //passa o produto para a lista de produto
      AddItemListViewPedido(umProdutoPedido); //passa o produto para o listview
    end;
  finally
    FreeAndNil(umProdutoModel);
  end;
end;
procedure TfrmVendaEntregaVIew.btnBuscarClick(Sender: TObject);
begin
  BuscarClientes;//busca o clientes no banco de dados
  PreencherListViewCliente; // preenche o listview com os clientes
end;
procedure TfrmVendaEntregaVIew.BuscarClientes;
var
  umClienteModel : TCLienteModel;
begin
  umClienteModel := TCLienteModel.Create;
  try
    if umaListaCLiente <> nil then
      FreeAndNil(umaListaCLiente); //se a lista ja existe da destroy
    umaListaCliente := umClienteModel.Buscar(edtBuscar.Text);//busca uma lista de CLientes pelo o 'TEdit'
  finally
    FreeAndNil(umClienteModel);
  end;
end;
procedure TfrmVendaEntregaVIew.BuscarFormasPagamento;
var
  umPedidoModel : TPedidoModel;
begin
  umPedidoModel := TPedidoModel.Create;
  try
    umaListaPagamento := umPedidoModel.ListaPagamento;
  finally
    FreeAndNil(umPedidoModel);
  end;
end;
procedure TfrmVendaEntregaVIew.BuscarProduto;
begin
  if frmBuscaProduto = nil then
    frmBuscaProduto := TfrmBuscaProduto.Create(frmVendaEntregaVIew);
  frmBuscaProduto.Show;
end;
function TfrmVendaEntregaVIew.BuscarTaxaEntrega: Real;
var
  umInifiLe : TiniFile;
begin
  umInifiLe := TIniFile.Create(_pathIni);
  try
    result := StrToFloat(umIniFile.ReadString('system','delivery',''));
  finally
    umInifiLe.Free;
  end;
end;
procedure TfrmVendaEntregaVIew.PreencherCombosPagamento;
var
  I : Integer;
begin
  cbPagamento.Clear;
  for I := 0 to umaListaPagamento.Count - 1 do
  begin
    cbPagamento.Items.Add(TPagamento(umaListaPagamento.Items[I]).Cartao + ' ' + TPagamento(umaListaPagamento.Items[I]).Forma);
  end;
end;
procedure TfrmVendaEntregaVIew.PreencherLabelTotal2;
begin
  laTotal.Caption := FormatFloat('R$ 0....,00',umPedido.Total) + ' (Produtos: '+ FormatFloat('R$ 0....,00', umPedido.TotalLiquido) + ' + Taxa Entrega: ' + FormatFloat('R$ 0....,00',umPedido.TaxaEntrega) + ')'  ;
end;
procedure TfrmVendaEntregaVIew.PreencherLabelTotal3;
begin
  lbTotal.Caption := FormatFloat('R$ 0....,00',umPedido.Total);
end;
procedure TfrmVendaEntregaVIew.PreencherListViewCliente;
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
procedure TfrmVendaEntregaVIew.PreencherMemo;
begin
  meDetalhePedido.Clear;
  meDetalhePedido.Lines.Add('Dados Do Cliente:');
  meDetalhePedido.Lines.Add('');
  meDetalhePedido.Lines.Add('Código: ' + intToStr(umPedido.Cliente.Id));
  meDetalhePedido.Lines.Add('Nome: ' + umPedido.Cliente.Nome);
  meDetalhePedido.Lines.Add('Endereço: ' + umPedido.Cliente.Endereco);
  meDetalhePedido.Lines.Add('Telefone: '  + umPedido.Cliente.Tel);
  meDetalhePedido.Lines.Add('Celular: ' + umPedido.Cliente.Cel);
  meDetalhePedido.Lines.Add('');

end;

procedure TfrmVendaEntregaVIew.SalvarPedido;
var
  umPedidoModel : TPedidoModel;
begin
  if EdtTroco.Text <> '' then
    umPedido.ValorPago := StrToFloat(StringReplace(EdtTroco.Text, '.', '', []));
  umPedidoModel := TPedidoModel.Create(umPedido);
  umPedido.Pagamento.Forma := TPagamento(umaListaPagamento.Items[cbPagamento.ItemIndex]).Forma;
  umPedido.Pagamento.Cartao :=  TPagamento(umaListaPagamento.Items[cbPagamento.ItemIndex]).Cartao;
  umPedido.Pagamento.ID :=  TPagamento(umaListaPagamento.Items[cbPagamento.ItemIndex]).ID;
  try
    if umPedidoModel.Inserir = true then
    begin
      frmShowMessages.showMessage(iOk, 'Pedido salvo com sucesso.');
    end
    else
      frmShowMessages.showMessage(iOk, 'Não foi possível salvar o pedido');
  finally
      FreeAndNil(umPedidoModel);
  end;
end;

procedure TfrmVendaEntregaVIew.EscondeTabs;
begin
  tshTela1.TabVisible:= false;
  tshTela2.TabVisible:= false;
  tshTela3.TabVisible:= false;
  pcPAdrao.ActivePageIndex:= 0;
end;
procedure TfrmVendaEntregaVIew.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmVendaEntregaVIew.Imprimir;
var
  umIniFile : TIniFile;
  umaStringList : TStringList;
begin
  umIniFile := TIniFile.Create(_pathIni);
  umaStringList := GeraStringListPedido;
  try
    if umIniFile.ReadString('printer','device','') <> '' then
      try
        umFormControl.Imprimir(umaStringList, umIniFile.ReadString('printer','device',''))
      except
      on E : Exception do
        frmShowMessages.showMessage(iError,E.ClassName+ 'Não foi possível imprimir. Erro: '+E.Message);
      end
    else
      frmShowMessages.showMessage(iError, 'É preciso configurar as impressoras em "Configurações"');
  finally
    FreeAndNil(umaStringList);
    umIniFile.Free;
  end;
end;
procedure TfrmVendaEntregaVIew.IrTela1;
begin
  pcPAdrao.ActivePageIndex:= 0;
  pnTopo.Caption :=  ' Venda para entrega: Escolha um Cliente';
end;

procedure TfrmVendaEntregaVIew.IrTela2;
begin
  if ListView1.Selected <> nil then
  begin
    pcPAdrao.ActivePageIndex:= 1;
    pnTopo.Caption :=  ' Venda para entrega: Adicione Produtos ao seu pedido';
    NovoPedido;
  end
  else
    frmShowMessages.showMessage(iError,'Escolha um Cliente antes de avançar.');
end;

procedure TfrmVendaEntregaVIew.IrTela3;
begin
  if umPedido.ListaProduto.Count = 0 then
  begin
    frmShowMessages.showMessage(ierror, 'Você precisa adicionar pelo menos um produto para realizar uma venda.');
    Exit;
  end;


  PreencherMemo;// Preenche o Memo com dados do Cliente (tela 3)
  PreencherLabelTotal3;
  pcPAdrao.ActivePageIndex:= 2;
  pnTopo.Caption :=  ' Venda para entrega: Pagamento';
end;

procedure TfrmVendaEntregaVIew.LimparCamposItem;
begin
  edtProdutoId.Clear;
  edtProduto.Clear;
  edtQtde.Text := '1';
  edtProdutoId.SetFocus;
end;

procedure TfrmVendaEntregaVIew.ListView1DblClick(Sender: TObject);
begin
  if ListView1.Selected <> nil then
    IrTela2;
end;

procedure TfrmVendaEntregaVIew.meDetalhePedidoClick(Sender: TObject);
begin
  HideCaret (0);
end;

procedure TfrmVendaEntregaVIew.meObsEnter(Sender: TObject);
begin
  if edtProdutoId.Text = '' then
    edtProdutoId.SetFocus;
end;

procedure TfrmVendaEntregaVIew.NovoPedido;
var
  umListItem : TListItem;
begin
  umListItem := ListView1.Selected;
  umPedido.Id := 0;
  umPedido.Cliente.ID := StrToInt(umListItem.Caption);
  umPedido.Cliente.Nome := umListItem.SubItems.Strings[0];
  umPedido.Cliente.Tel:= umListItem.SubItems.Strings[1];
  umPedido.Cliente.Cel:= umListItem.SubItems.Strings[2];
  umPedido.Cliente.Endereco:= umListItem.SubItems.Strings[3];
  umPedido.Cliente.Bairro:= umListItem.SubItems.Strings[4];
end;
procedure TfrmVendaEntregaVIew.paFormularioDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  umListItem : TListItem;
begin
  if Source is TlistView then
  begin
    umListItem :=  TListView(Source).Selected;
    edtProdutoId.Text := umListItem.Caption;
    edtProduto.Text := umListItem.SubItems.Strings[0];
    edtQtde.SetFocus;
    GetParentForm(TListView(Source)).Close;    //fecha o form de busca
  end;
end;

procedure TfrmVendaEntregaVIew.paFormularioDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := true;
end;

procedure TfrmVendaEntregaVIew.paMemoEnter(Sender: TObject);
begin
  HideCaret (1);

end;

procedure TfrmVendaEntregaVIew.pnTopoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  umFormControl : TFormControl;
begin
  umFormControl := TFormControl.Create;
  try
    umformControl.SetCliqueAndDrag(Self, Button);
  finally
    FreeAndNil(umFormControl);
  end;
end;
procedure TfrmVendaEntregaVIew.CarregarProdutoFormulario;
var
  umProdutoModel : TProdutoModel;
  umProduto : TProduto;
begin
  if edtProdutoId.Text = '' then
  begin
    Exit;
  end;
  umProdutoModel := TProdutoModel.Create;
  try
    umProduto := umProdutoModel.BuscarPorId(StrToInt(edtProdutoId.Text));
    if umProduto.Descricao <> '' then
    begin
      edtProduto.Text := umProduto.Descricao;
      edtQtde.Text := '1';
      edtQtde.SetFocus;
    end
    else
    begin
      frmShowMessages.showMessage(iError, 'Esse produto não existe.');
      edtProdutoId.SetFocus;
      edtProdutoId.Clear;
    end;
    finally
      destroyObj(umProdutoModel);
      destroyObj(umProduto);
    end;
end;

procedure TfrmVendaEntregaVIew.cbPagamentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  key := #0;
end;

procedure TfrmVendaEntregaVIew.ConfigListView;
var
  I : Integer;
  ListColunn : TListColumn;
  umCLiente : TCliente;
  Fields : TStringList;
begin
  umCliente := TCliente.Create;
  try
    Fields := umCLiente.FieldsView;
    //criar as colunas do ListVIew
    for I := 0 to Fields.Count - 1 do
    begin
      ListColunn := ListView1.Columns.Add;
      ListColunn.Caption := Fields.Strings[I];
      //o campo 0 é o ID, defino com tamanho menor a largura dele
      if I = 0 then
      begin
        ListColunn.AutoSize := false;
        ListColunn.Width := 75;
      end
      else
        ListColunn.AutoSize := true;
    end;
  finally
    FreeAndNil(umCLiente);
  end;
end;
procedure TfrmVendaEntregaVIew.ConfigListViewPedido;
var
  FieldsProdutoPedido  : TStringList;
  umListColumn : TListColumn;
  tempPedido : TPedido;//usado para buscar os nomes dos campos do pedido
  I : Integer;
begin
  tempPedido := TPedido.Create;
  try
    FieldsProdutoPedido :=  tempPedido.FieldsView;
    for I := 0  to FieldsProdutoPedido.Count - 1 do
    begin
      umListColumn:= lvPedido.Columns.Add;
      umListColumn.Caption := FieldsProdutoPedido.Strings[I];
      umListColumn.Width := Trunc(lvPedido.Width / FieldsProdutoPedido.Count);
    end;
  finally
    FreeAndNil(tempPedido);
  end;
end;
procedure TfrmVendaEntregaVIew.ConfiguraCheckBoxImprimir;
var
 umIniFile : TIniFile;
begin
  //formata os edits de dinheiro
  umIniFile := TIniFile.Create(_pathIni);
  try
    if (umIniFile.ReadString('printer','print','') = 'yes') then
      cbImprimir.Checked := true
    else
      cbImprimir.Checked := false;
  finally
    umIniFile.Free;
  end;
end;

procedure TfrmVendaEntregaVIew.CriarLogPedido;
var
  umaStringList : TStringList;
begin
  umaStringList := GeraStringListPedido;
  try
    umFormControl.CriarPedidoTxt(umaStringList,intToStr(umPedido.ID));//gera um Log do pedido
  finally
    FreeAndNil(umaStringList);
  end;
end;

procedure TfrmVendaEntregaVIew.edtBuscarKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    key := #0;//coloca o key em 0 para nao emitir nenhum bip
    BuscarClientes;
    PreencherListViewCliente;
  end;
end;
procedure TfrmVendaEntregaVIew.edtProdutoEnter(Sender: TObject);
begin
  if edtProdutoId.Text = '' then
    edtProdutoId.SetFocus;
end;
procedure TfrmVendaEntregaVIew.edtProdutoIdExit(Sender: TObject);
begin
  CarregarProdutoFormulario;
end;
procedure TfrmVendaEntregaVIew.edtProdutoIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(key in['0'..'9',#08, #13] ) then
    key:= #0;
  if key = #13 then //se o enter for pressionado
  begin
    key := #0; //para nao emitir bipe ao apertar enter
    CarregarProdutoFormulario;     //carrega os dados do produto buscado no formulario
  end;
end;

procedure TfrmVendaEntregaVIew.edtQtdeEnter(Sender: TObject);
begin
  if edtProdutoId.Text = '' then
    edtProdutoId.SetFocus;
end;
procedure TfrmVendaEntregaVIew.edtQtdeKeyPress(Sender: TObject; var Key: Char);
begin
  if not(key in['0'..'9',#08] ) then
    key:= #0;
end;

procedure TfrmVendaEntregaVIew.destroyObj(AObj: Tobject);
begin
  if AObj <> nil then
  begin
      FreeAndNil(AObj);
  end;
end;
end.
