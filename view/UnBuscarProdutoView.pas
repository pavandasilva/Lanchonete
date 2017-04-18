unit UnBuscarProdutoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ToolWin, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, UnProduto, UnProdutoModel, Contnrs,
  UnFormControl;
type
  TfrmBuscaProduto = class(TForm)
    ListView1: TListView;
    pnBtnsNAv: TPanel;
    btnBuscar: TImage;
    tbNavegacao: TToolBar;
    edtBuscar: TEdit;
    pnTopo: TPanel;
    imgFechar: TImage;
    procedure FormCreate(Sender: TObject);
    procedure pnTopoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgFecharClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure edtBuscarKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ListView1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    procedure BuscarProdutos;
    procedure PreencherListView;
    procedure ConfigListView;
  public
    { Public declarations }
  end;
var
  frmBuscaProduto: TfrmBuscaProduto;
  umaListaProduto : TObjectList;
implementation
{$R *.dfm}
procedure TfrmBuscaProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmBuscaProduto.FormCreate(Sender: TObject);
begin
  ConfigListView;
  BuscarProdutos;
  PreencherListView;
end;
procedure TfrmBuscaProduto.FormDestroy(Sender: TObject);
begin
  frmBuscaProduto := nil;
end;

procedure TfrmBuscaProduto.ConfigListView;
var
  umProduto: TProduto;
  umListColumn : TListColumn;
  I : Integer;
  Fields : TstringList;
begin
  umProduto := TProduto.Create;
  try
    Fields := umProduto.FieldsView;

    for I := 0 to  Fields.Count - 1 do
    begin
      umListColumn := ListView1.Columns.Add;
      if I = 0 then
        umListColumn.Width := 75
      else
        umListColumn.AutoSize := true;
      umListColumn.Caption := Fields.Strings[I];
    end;
  finally
    FreeAndNil(umProduto);
  end;
end;
procedure TfrmBuscaProduto.edtBuscarKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    key := #0;//coloca o key em 0 para nao emitir nenhum bip
    BuscarProdutos;
    PreencherListView;
  end;
end;
procedure TfrmBuscaProduto.FormShow(Sender: TObject);
begin
  edtBuscar.SetFocus;
end;

procedure TfrmBuscaProduto.imgFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBuscaProduto.ListView1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  //Accept := True;
end;

procedure TfrmBuscaProduto.pnTopoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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

procedure TfrmBuscaProduto.PreencherListView;
var
  I : Integer;
  umListItem : TLIstItem;
begin
  ListView1.Clear;
  for I := 0 to umaListaProduto.Count - 1 do
  begin
    umListItem := ListView1.Items.Add;
    umListItem.Caption := IntToStr(TProduto(umaListaProduto.Items[I]).ID);
    umListItem.SubItems.Add(TProduto(umaListaProduto.Items[I]).Descricao);
    umListItem.SubItems.Add(TProduto(umaListaProduto.Items[I]).Categoria);
    umListItem.SubItems.Add(TProduto(umaListaProduto.Items[I]).Unidade);
    umListItem.SubItems.Add(FormatFloat('R$ #....,00',TProduto(umaListaProduto.Items[I]).Valor));
  end;
end;
procedure TfrmBuscaProduto.btnBuscarClick(Sender: TObject);
begin
  BuscarProdutos;
  PreencherListView;
end;
procedure TfrmBuscaProduto.BuscarProdutos;
var
  umProdutoModel : TProdutoModel;
  I : Integer;
begin

  umProdutoModel := TProdutoModel.Create;
  try
    FreeAndNil(umaListaProduto);
    umaListaProduto := umProdutoModel.Buscar(edtBuscar.Text);
  finally
    umProdutoModel.Free;
  end;
end;

end.
