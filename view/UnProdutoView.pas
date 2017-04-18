unit UnProdutoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnCadastroPadrao, Vcl.StdCtrls,
  Vcl.Mask, Vcl.ExtCtrls, UnProdutoModel, Comctrls, UNProduto,
  UnCategoriaProduto, UnFormControl, Contnrs, UnUnidadeProduto, MaskUtils;

type
  TfrmProdutoView = class(TfrmCadastroPadrao)
    pnEdicao: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    lbNome: TLabel;
    edtNome: TEdit;
    cbUnidade: TComboBox;
    Label1: TLabel;
    cbCategoria: TComboBox;
    edtPreco: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbCategoriaKeyPress(Sender: TObject; var Key: Char);
    procedure cbUnidadeKeyPress(Sender: TObject; var Key: Char);
  private
    procedure Deletar; override;
    procedure Editar; override;
    procedure Adicionar; override;
    procedure Atualizar; override;
    procedure BuscarDados; override;
    procedure Cancelar; override;
    procedure Salvar; override;
    procedure Inserir; override;
    procedure AlimentaCombobox(ACategorias : TobjectList; AUnidades : TObjectList);


  public
    { Public declarations }
  end;
var
  frmProdutoView     : TfrmProdutoView;
  umFormControl : TFormControl;
  umaListaProduto : TobjectList;
  umaListaCategoria, umaListaUnidade : TObjectList;
implementation
{$R *.dfm}
uses UnShowMessages;
{ TfrmProdutoView }
procedure TfrmProdutoView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;

end;

procedure TfrmProdutoView.FormCreate(Sender: TObject);
var
  UmProduto : TProduto;
begin
  pnTopo.Caption := ' Cadastro de Produtos';
  pnEdicao.Parent := tshEdicao;
  umaListaProduto := TObjectList.Create;
  umFormControl := TFormControl.Create;
  UmProduto := TProduto.Create;
  try
    umFormControl.ListViewSetColTitles(ListView1, UmProduto.FieldsView);
    umFormControl.EditFormatCurrency(edtPreco);
  finally
    UmProduto.Free;
  end;
  inherited;
end;

procedure TfrmProdutoView.FormDestroy(Sender: TObject);
begin
  inherited;
  umFormControl.Free;
  umaListaProduto.Free;
  if umaListaCategoria <> nil then
    FreeAndNil(umaListaCategoria);
  if umaListaUnidade <> nil then
    FreeAndNil(umaListaUnidade);


  frmProdutoView := nil;
end;

procedure TfrmProdutoView.Adicionar;
var
  umProdutoModel : TProdutoModel;
  umStringList : TStringList;
  I : Integer;
begin
  inherited;
  UmFormControl.LimparFields(Self);
end;
procedure TfrmProdutoView.AlimentaCombobox(ACategorias, AUnidades: TObjectList);
var
  I : Integer;
begin
   cbUnidade.Clear;
   cbCategoria.Clear;

   for I := 0 to ACategorias.count - 1 do
    cbCategoria.Items.Add(TCategoriaProduto(Acategorias.Items[I]).Categoria);
   for I := 0 to AUnidades.count - 1 do
    cbUnidade.Items.Add(TUnidadeProduto(AUnidades.Items[I]).Unidade);
end;
procedure TfrmProdutoView.Editar;
var
  I : Integer;
begin
  inherited;
  if ListView1.Selected  = nil then
  begin
    frmShowMessages.showMessage( iError,'Selecione algum registro na tabela antes de editar.');
    Exit;
  end;
  edtNome.Text          :=  TProduto(umaListaProduto.Items[ListView1.Selected.Index]).Descricao;
  edtPreco.Text         :=  FloatToStr(TProduto(umaListaProduto.Items[ListView1.Selected.Index]).Valor * 100);
  cbCategoria.ItemIndex :=  cbCategoria.Items.IndexOf(TProduto(umaListaProduto.Items[ListView1.Selected.Index]).Categoria);
  cbUnidade.ItemIndex   :=  cbUnidade.Items.IndexOf(TProduto(umaListaProduto.Items[ListView1.Selected.Index]).Unidade);

end;
procedure TfrmProdutoView.Atualizar;
var
  umProdutoModel : TProdutoModel;
begin
  umProdutoModel := TProdutoModel.Create;
  try
    umProdutoModel.Produto.Id :=  TProduto(umaListaProduto.Items[ListView1.Selected.Index]).ID;
    umProdutoModel.Produto.Descricao := edtNome.Text;
    umProdutoModel.Produto.Categoria := TCategoriaProduto(umaListaCategoria.Items[cbCategoria.ItemIndex]).Categoria;
    umProdutoModel.Produto.CategoriaID := TCategoriaProduto(umaListaCategoria.Items[cbCategoria.ItemIndex]).ID;        //alterar
    umProdutoModel.Produto.Unidade := TUnidadeProduto(umaListaUnidade.Items[cbUnidade.ItemIndex]).Unidade;
    umProdutoModel.Produto.UnidadeID := TUnidadeProduto(umaListaUnidade.Items[cbUnidade.ItemIndex]).ID;
    umProdutoModel.Produto.Valor := strToFLoat(StringReplace(edtPreco.Text,'.','',[rfReplaceAll]));;
    if umProdutoModel.Atualizar then
    begin
      frmShowMessages.showMessage(iOk, 'Produto Atualizado com Sucesso.');
      BuscarDados;
      pcPAdrao.ActivePageIndex:= 0;
    end
    else
      frmShowMessages.showMessage(iError, 'Não foi possível atualizar o Produto.');
  finally
    umProdutoModel.Free;
  end;
end;

procedure TfrmProdutoView.BuscarDados;
var
  umProdutoModel : TProdutoModel;
  I : Integer;
begin
  if umaListaProduto <> nil then
  begin
    umaListaProduto.Free;
  end;
  if umaListaCategoria <> nil then
  begin
    umaListaCategoria.Free;
  end;
  if umaListaUnidade <> nil then
    umaListaUnidade.Free;
  umProdutoModel := TProdutoModel.Create;
  try
    umaListaCategoria := umProdutoModel.GetGategorias;
    umaListaUnidade := umProdutoModel.GetUnidades;
    umaListaProduto := umProdutoModel.Buscar(edtBuscar.Text); //retorna uma Lista de 'TProdutos'
    //configuraos TComboBOx Categoria e UNidade
    AlimentaComboBox(umaListaCategoria, umaListaUnidade);
    umFormControl.ListViewSetContent(ListView1, umaListaProduto); //popula o ListVIew
  finally
    umProdutoModel.Free;
  end;
end;


procedure TfrmProdutoView.Cancelar;
begin
  inherited;
  BuscarDados;
end;

procedure TfrmProdutoView.cbCategoriaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  key := #0;
end;

procedure TfrmProdutoView.cbUnidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  key := #0;
end;

procedure TfrmProdutoView.Deletar;
var
  umProdutoModel : TProdutoModel;
begin
  if ListView1.Selected = nil then   //se nao tiver nada selecionado da tabela , sai
  begin
    frmShowMessages.ShowMessage(iError, 'Selecione um Item na Tabela para excluir.');
    Exit;
  end;
  umProdutoModel := TProdutoModel.Create;
  try
   //passa o id do item da ListaDeproduto ela é sincronizada com o ListView1
   if umProdutoModel.Deletar(TProduto(umaListaProduto.Items[ListView1.Selected.Index]).ID) then
    frmShowMessages.showMessage(iOk, 'Produto excluído com sucesso.')
   else
    frmShowMessages.ShowMessage(iError, 'Não foi possível excluir o produto selecionado');
  finally
    umProdutoModel.Free;
    BuscarDados;
  end;
end;

procedure TfrmProdutoView.Salvar;
begin
  inherited;
end;
procedure TfrmProdutoView.Inserir;
var
  umProdutoModel : TProdutoModel;
  I : Integer;
begin
  umProdutoModel := TProdutoModel.Create;
  try
    umProdutoModel.Produto.ID := 0;
    umProdutoModel.Produto.Descricao := edtNome.Text;
    umProdutoModel.Produto.Valor := strToFLoat(StringReplace(edtPreco.Text,'.','',[rfReplaceAll]));
    umProdutoModel.Produto.Categoria := cbCategoria.Text;
    umProdutoModel.Produto.CategoriaID := TCategoriaProduto(umaListaCategoria.Items[cbCategoria.ItemIndex]).ID;        //alterar
    umProdutoModel.Produto.Unidade := cbUnidade.Text;
    umProdutoModel.Produto.UnidadeID := TUnidadeProduto(umaListaUnidade.Items[cbUnidade.ItemIndex]).ID; //alterar
    if (umProdutoModel.Inserir) then
      frmShowMessages.showMessage(iOk, 'Produto adicionado com sucesso.')
    else
      frmShowMessages.showMessage(iError, 'Não foi possível adicionar o Produto.');
  finally
    umProdutoModel.Free;
    BuscarDados;
  end;
  inherited;
end;

end.
