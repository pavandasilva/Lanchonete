unit UnFormControl;

interface
uses System.Classes, Vcl.Controls, Vcl.StdCtrls, forms, Vcl.ComCtrls, UnCliente, Contnrs, SysUtils,
  UnProduto, MaskUtils, Vcl.Mask, Windows,  Messages,  Variants,  Graphics, Printers,
  Dialogs, ExtCtrls, Winprocs;
type
  TFormControl = class
  public
    procedure ListViewSetColTitles(AListView : TListView; ATitles: TstringList);
    procedure ListViewSetContent(AListView : TListVIew; AObjets: TobjectList);
    procedure LimparFields(AForm : TForm);
    procedure SetComboContents(AComboBOx :TCombobox; AItens : TstringList);
    procedure EditFormatCurrency(Sender : TObject);
    procedure OnChangeEditEditFormatCurrency(Sender : TObject);
    procedure SetCliqueAndDrag(Sender : TObject; MouseButton: TMouseButton);
    function AbortImpressao(Sender: TObject; var Key: Char): Boolean;
    function Imprimir(AStrings : TStrings; AImpressora : String): Boolean;
    procedure CriarPedidoTxt(AStrings: TStrings; ANome: String);
  end;
implementation
{ TFormControl }


function TFormControl.AbortImpressao(Sender: TObject; var Key: Char): Boolean;
begin

end;

procedure TFormControl.CriarPedidoTxt(AStrings: TStrings; ANome: String);
begin
  AStrings.SaveToFile('pedidos/'+ANome + '.txt');
end;
procedure TFormControl.EditFormatCurrency(Sender: TObject);
begin
  if Sender is TEdit then
     TEdit(Sender).OnChange := OnChangeEditEditFormatCurrency;

end;
function TFormControl.Imprimir(AStrings : TStrings; AImpressora : String):Boolean;
var
  I: Integer;
  MarginLeft,
  MarginTop: Integer; // Margins' from printable area
  Y: Integer; // Y-Position in Pixel
  Max: Integer; // Vertical resolution in Pixel
begin
  //cria um log
  with Printer do
  begin
    Printer.PrinterIndex := Printer.Printers.IndexOf(AImpressora);
    Canvas.Font.Size := 10;
    MarginLeft := 10;
    MarginTop := 10;
    Max := PageHeight - MarginTop;
    BeginDoc;
    try
      Y   := MarginTop;
      for I := 0 to AStrings.Count - 1 do
      begin
        Canvas.TextOut(MarginLeft, Y, AStrings[I]);
        Y := Y + Canvas.TextHeight(AStrings[I]);
        If Y >= Max Then
        begin
          If i < (AStrings.Count-1) Then
            NewPage;
          Y:= MarginTop;
        end;
        //Application.ProcessMessages; // for Printer.Abort();
      end;
    finally
      EndDoc;
      //AStrings.Free;
  end;
end;


end;
procedure TFormControl.LimparFields(AForm: TForm);
var
  I : Integer;
begin
  for I := 0 to AForm.ComponentCount - 1 do
  begin
    if AForm.Components[I] is TEdit then
    begin
      TEdit(AForm.Components[I]).Clear;
      if TEdit(AForm.Components[I]).TabOrder = 0 then
        TEdit(AForm.Components[I]).SetFocus;
    end
    else if AForm.Components[I] is TMaskEdit then
    begin
      TMaskEdit (AForm.Components[I]).Clear;
      if TMaskEdit (AForm.Components[I]).TabOrder = 0 then
        TMaskEdit (AForm.Components[I]).SetFocus;
    end;
  end;
end;

procedure TFormControl.ListViewSetColTitles(AListView: TListView;
  ATitles: TstringList);
var
  I : Integer;
  umListColun : TListColumn;
begin
  try
    for I := 0 to ATitles.Count - 1 do
    begin
      umListColun :=  AListView.Columns.Add;
      umListColun.Caption := ATitles.Strings[I];
      if I = 0  then
      begin
        umListColun.AutoSize := false;
        umListColun.Width := 70;
      end
      else
        umListColun.AutoSize := true;
    end;
  finally

  end;
end;

procedure TFormControl.ListViewSetContent(AListView: TListVIew;
  AObjets: TobjectList);
var
  I : Integer;
  umListItem : TListItem;
begin
    try
    AListView.Items.BeginUpdate;
    AListView.Clear;
    for I := 0 to AObjets.Count - 1 do
    begin
      umListItem := AListView.Items.Add;
      if (AObjets.Items[I] is TCliente) then
      begin
        umListItem.Caption := IntToStr(TCLiente(AObjets.Items[I]).Id);
        umListItem.SubItems.Add(TCliente(AObjets.Items[I]).Nome);
        umListItem.SubItems.Add(TCliente(AObjets.Items[I]).Tel);
        umListItem.SubItems.Add(TCliente(AObjets.Items[I]).Cel);
        umListItem.SubItems.Add(TCliente(AObjets.Items[I]).Endereco);
        umListItem.SubItems.Add(TCliente(AObjets.Items[I]).Bairro);
      end
      else if (AObjets.Items[I] is TProduto) then
      begin
        umListItem.Caption  := IntToStr(TProduto(AObjets.Items[I]).Id);
        umListItem.SubItems.Add(TProduto(AObjets.Items[I]).Descricao);
        umListItem.SubItems.Add(TProduto(AObjets.Items[I]).Categoria);
        umListItem.SubItems.Add(TProduto(AObjets.Items[I]).Unidade);
        umListItem.SubItems.Add(FormatFloat('R$ ###,###,##0.00',TProduto(AObjets.Items[I]).Valor));

      end;
    end;
    AListView.Items.EndUpdate;
    finally

    end;

end;

procedure TFormControl.OnChangeEditEditFormatCurrency(Sender: TObject);
var
  sAux, Text: String;
  i, iPos: Integer;
begin
  TEdit(Sender).SelStart := Length(TEdit(Sender).Text);
  Text := TEdit(Sender).Text;
  for i := 1 to Length(Text) do
  begin
    if not (Text[i] in ['0'..'9']) then
      Delete(Text,i,1);
  end;
  { Completar com ´0´ para deixar tamanho correto }
  sAux := StringOfChar('0',11 - Length(Text)) + Text;
  sAux := FormatMaskText('000.000.000,00;0',sAux);

  { Mostrar somente a parte relevante }
  iPos := 1;
  for i := 1 to Length(sAux) do
  begin
    if sAux[i] = ',' then
    begin
      iPos := i -1;
      Break;
    end;
    if not (sAux[i] in ['0','.']) then
    begin
      iPos := i;
      Break;
    end;
  end;
  TEdit(Sender).Text := Copy(sAux,iPos,Length(sAux));
end;
procedure TFormControl.SetCliqueAndDrag(Sender : TObject; MouseButton: TMouseButton);
const
  SC_DRAGMOVE = $F012;
begin
  if MouseButton = mbleft then
  begin
    ReleaseCapture;
    TForm(Sender).Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

procedure TFormControl.SetComboContents(AComboBOx: TCombobox;
  AItens: TstringList);
begin

end;

end.
