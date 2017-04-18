unit UnClienteView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnCadastroPadrao, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.Buttons, UnCliente, Data.DB,
  Vcl.Mask, Vcl.DBCtrls, UnClienteModel, UnFormControl,  Contnrs;

type
  TfrmCliente = class(TfrmCadastroPadrao)
    pnEdicao: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbNome: TLabel;
    edtNome: TEdit;
    edtEndereco: TEdit;
    edtBairro: TEdit;
    meCelular: TMaskEdit;
    meTelefone: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure Deletar; override;
    procedure Editar; override;
    procedure Adicionar; override;
    procedure Atualizar; override;
    procedure BuscarDados; override;
    procedure Cancelar; override;
    procedure Salvar; override;
    procedure Inserir; override;
    { Private declarations }
  public
  end;
var
  frmCliente: TfrmCliente;
  umFormControl : TFormControl;
  umaListaCliente : TObjectList;

implementation
{$R *.dfm}

uses UnShowMessages;
procedure TfrmCliente.Adicionar;
var
  umClienteModel : TCLienteModel;
begin
  pcPAdrao.ActivePageIndex := 1;
  umFormControl.LimparFields(Self);
end;

procedure TfrmCliente.Atualizar;
var
  umCLienteModel : TCLienteModel;
begin
  umCLienteModel := TCLienteModel.Create;
  try
    umCLienteModel.Id :=  TCliente(umaListaCliente.Items[ListView1.Selected.Index]).Id;
    umCLienteModel.Nome := edtNome.Text;
    umCLienteModel.Endereco := edtEndereco.Text;
    umCLienteModel.Bairro := edtBairro.Text;
    umCLienteModel.Tel := meTelefone.Text;
    umCLienteModel.Cel := meCelular.Text;
    if umCLienteModel.Atualizar then
    begin
      frmShowMessages.showMessage(iOk, 'Cliente Atualizado com Sucesso.');
      BuscarDados;
      pcPAdrao.ActivePageIndex:= 0;
    end
    else
      frmShowMessages.showMessage(iError, 'Não foi possível atualizar o CLiente.');
  finally
    umCLienteModel.Free;
  end;
end;
procedure TfrmCliente.BuscarDados;
var
  umCLienteModel : TCLienteModel;
begin
  if umaListaCliente <> nil then
     umaListaCliente.Free;

  umCLienteModel := TCLienteModel.Create;
  try
    umaListaCliente := umCLienteModel.Buscar(edtBuscar.Text);
    umFormControl.ListViewSetContent(ListView1, umaListaCliente);//Preenche a ListView com a lista de CLientes
  finally
    umCLienteModel.Free;
  end;
end;
procedure TfrmCliente.Cancelar;
begin

  umFormControl.LimparFields(Self);

  inherited;

end;

procedure TfrmCliente.Deletar;
var
  umListItem : TListItem;
  umClientModel : TCLienteModel;
begin
  if ListView1.Selected = nil then   //se nao tiver nada selecionado da tabela , sai
  begin
    frmShowMessages.ShowMessage(iError, 'Selecione um Item na Tabela para excluir.');
    Exit;
  end;
  umClientModel := TCLienteModel.Create;
  try
    if ListView1.Selected  <> nil then
    begin
      umListItem := ListView1.ItemFocused;
      if umClientModel.Deletar(StrToInt(umListItem.Caption)) then
      begin
        frmShowMessages.showMessage(iOk, 'Cliente Deletado com sucesso.');
        BuscarDados;
      end
      else
       frmShowMessages.showMessage(iOk, 'Não foi possível deletar o cliente')
    end;
  finally
     umClientModel.Free;
  end;
end;
procedure TfrmCliente.Editar;
begin
  if ListView1.Selected  = nil then
  begin
    frmShowMessages.showMessage( iError,'Selecione algum registro na tabela antes de editar.');
    Exit;
  end;
  edtNome.Text          :=  TCliente(umaListaCliente.Items[ListView1.Selected.Index]).Nome;
  edtEndereco.Text         := TCliente(umaListaCliente.Items[ListView1.Selected.Index]).Endereco;
  edtBairro.Text := TCliente(umaListaCliente.Items[ListView1.Selected.Index]).Bairro;
  meTelefone.Text := TCliente(umaListaCliente.Items[ListView1.Selected.Index]).Tel;
  meCelular.Text := TCliente(umaListaCliente.Items[ListView1.Selected.Index]).Cel;
  inherited;
end;

procedure TfrmCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
var
  umCliente: TCLiente;
  umFieldsView : TstringList;
begin
  pnTopo.Caption := ' Cadastro de Clientes';
  pnEdicao.Parent := tshEdicao; //coloca o panel  'pnEdicao' do form com os TEdits dentro da aba de edicao
  umFormControl := TFormControl.Create;//classe que limpa forms, preenche listviews
  UmCliente := TCLiente.Create;
  try
   umFieldsView := umCliente.FieldsView;
   umFormControl.ListViewSetColTitles(ListView1, umFieldsView); //passa os captions das colunas do listview
  finally
    umCliente.Free;
  end;
  inherited;
end;
procedure TfrmCliente.FormDestroy(Sender: TObject);
begin
  inherited;
  umFormControl.Free;
  FreeAndNil(umaListaCliente);
  frmCliente := nil;

  end;

procedure TfrmCliente.Inserir;
var
  umCLienteModel : TCLienteModel;
begin
  umClienteModel := TCLienteModel.Create;
  try
    with umClienteModel do
    begin
      {passa os valores digitados nos TEdits para a Classe Tcliente}
      Id        := 0;
      Nome      := edtNome.Text;
      Endereco  := edtEndereco.Text;
      Tel       := meTelefone.Text;
      Cel       := meCelular.Text;
      Bairro    := edtBairro.Text;
      if umCLienteModel.Adicionar then  //manda a classe modelo adicionar no banco de dados
      begin
        frmShowMessages.showMessage(iOk, 'Cliente Salvo com sucesso.');
        umFormControl.LimparFields(Self);
      end
      else
      begin
        frmShowMessages.showMessage(iError, 'Não foi possível salvar o cliente. Tente novamente mais tarde.');
        umFormControl.LimparFields(Self);
      end;
    end;
  finally
    umClienteModel.Free;
    BuscarDados;
  end;
  inherited;
end;
procedure TfrmCliente.Salvar;
begin
  inherited;
end;



end.
