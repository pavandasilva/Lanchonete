unit UnRelatorioVendasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  UnFormControl, UnPedido, UnPedidoModel, Contnrs, Vcl.ImgList, IniFiles,
  UnShowMessages;

type
  TfrmRelatorioVendasView = class(TForm)
    pnTopo: TPanel;
    imgFechar: TImage;
    Panel1: TPanel;
    laTotal: TLabel;
    ToolBar2: TToolBar;
    ActionList1: TActionList;
    lvPedidos: TListView;
    actFiltrar: TAction;
    ImageList1: TImageList;
    actImprimir: TAction;
    ToolButton1: TToolButton;
    Panel2: TPanel;
    paDatas: TPanel;
    lbNome: TLabel;
    laDF: TLabel;
    dtp1: TDateTimePicker;
    dtp2: TDateTimePicker;
    paToolBar: TPanel;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    lbContador: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure imgFecharClick(Sender: TObject);
    procedure pnTopoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure actFiltrarExecute(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
  private
    umObjectList : TObjectList;
    umFormControl : TFormControl;
    const _pathIni = 'config/config.ini';
    procedure ConfigListView;
    procedure BuscaPedidos;
    procedure PreencheListView;
    procedure PreencheLabel;
    function CalculaTotalPedido:Real;
    procedure ConfiguraDataPicker;
    function MontaStringsImpressao: TStringList;
  public
    { Public declarations }
  end;

var
  frmRelatorioVendasView: TfrmRelatorioVendasView;

implementation

{$R *.dfm}

procedure TfrmRelatorioVendasView.actFiltrarExecute(Sender: TObject);
begin
  BuscaPedidos;
  PreencheListView;
  PreencheLabel;
end;

procedure TfrmRelatorioVendasView.actImprimirExecute(Sender: TObject);
begin
  MontaStringsImpressao;
end;

procedure TfrmRelatorioVendasView.BuscaPedidos;
var
  umPedidoModel : TPedidoModel;
begin
  umPedidoModel := TPedidoModel.Create;
  try
    if umObjectList <> nil then
      FreeAndNil(umObjectList);
    umObjectList := umPedidoModel.getListaPedido(dtp1.Date, dtp2.Date);
  finally
     umPedidoModel.Free;
  end;
end;

function TfrmRelatorioVendasView.CalculaTotalPedido : Real;
var
  I : Integer;
  Total : Real;
begin
  Result := Total;
  //soma o valor de todos os pedidos
  for I := 0 to umObjectList.Count - 1 do
    Result := Result + TPedido(umObjectList.Items[I]).ValorTotal;
end;

procedure TfrmRelatorioVendasView.ConfigListView;
var
  umPedido : TPedido;
  umaStringList : TStringList;
  umColumnList : TListColumn;
  I : Integer;
  teste : integer;
begin
  umPedido := TPedido.Create;
  try
    umaStringList := umPedido.FieldsViewRelatorio;
    lvPedidos.Clear;
    umColumnList := lvPedidos.Columns.Add;
    umColumnList.Width := 20;
    for I := 0 to umaStringList.Count - 1 do
    begin
      umColumnList := lvPedidos.Columns.Add;
      umColumnList.Caption := umaStringList.Strings[I];
      if (I = 0) or (I = 1) then
         umColumnList.Width := 110
      else
        umColumnList.Width := Trunc((lvPedidos.Width - 240)/(umaStringList.Count - 2));
    end;
  finally
    FreeAndNil(umPedido);
  end;
end;

procedure TfrmRelatorioVendasView.ConfiguRaDataPicker;
begin
  dtp1.DateTime := Now;
  dtp2.DateTime := Now;
end;

procedure TfrmRelatorioVendasView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRelatorioVendasView.FormCreate(Sender: TObject);
begin
  ConfiguraDataPicker;
  ConfigListView; //configura as colunas do listview
  BuscaPedidos;   // busca os pedidos
  PreencheListView;
  PreencheLabel;
end;

procedure TfrmRelatorioVendasView.FormDestroy(Sender: TObject);
begin
  frmRelatorioVendasView := nil;
  FreeANdNil(umObjectList);
end;

procedure TfrmRelatorioVendasView.imgFecharClick(Sender: TObject);
begin
  Close;
end;
function TfrmRelatorioVendasView.MontaStringsImpressao: TStringList;
var
  I, J : Integer;
  umaStringList : TStringList;
  Linha : String;
  contador : Integer;
  umFieldsRelatorio : TStringList;
  umPedido : TPedido;
begin
  Result := TStringList.Create;
  Linha := '';
  umPedido := TPedido.Create;
  try
    umFieldsRelatorio := umPedido.FieldsViewRelatorio;
    Result.Add('Relatório de Vendas');
    Result.Add('De: '+ DateTimeToStr(dtp1.DateTime)+ ' a ' +DateTimeToStr(dtp2.DateTime) );

  //Result.Add(Format('%-32s',['teste']));


    for I := 0 to umFieldsRelatorio.count - 1 do
    begin
      if I = 0  then
        Linha := Linha + Format('%-10s', [umFieldsRelatorio.Strings[I]])
      else if I = 1 then
        Linha := Linha + Format('%-14s', [umFieldsRelatorio.Strings[I]])
      else if I = 2 then
        Linha := Linha + Format('%-40s', [umFieldsRelatorio.Strings[I]])
      else
        Linha := Linha + Format('%-10s', [umFieldsRelatorio.Strings[I]])
    end;
    Result.Add(Linha);
    for I := 0 to lvPedidos.Items.Count  - 1 do
    begin
      if (lvPedidos.Items.Item[I].Checked) then
      begin
        Linha := '';
        for J := 0 to lvPedidos.Items[I].SubItems.Count - 1 do
          if J = 0 then
            Linha := Linha + Format('%-10s', [lvPedidos.Items[I].SubItems[J]])
          else if J = 1 then
            Linha := Linha + Format('%-14s', [lvPedidos.Items[I].SubItems[J]])
          else if J = 2 then
            Linha := Linha + Format('%-40s', [lvPedidos.Items[I].SubItems[J]])
          else  
            Linha := Linha + Format('%-10s', [lvPedidos.Items[I].SubItems[J]]);
        Result.Add(Linha);
      end;
    end;
    Result.Add(' ');
    Result.Add(Format('%-100s', [lbContador.Caption]));
  finally
    FreeAndNil(umPedido);
  end;
end;

procedure TfrmRelatorioVendasView.pnTopoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  umFormControl : TFormControl;
begin
  umFormControl := TFormControl.Create;     
  try
    umformControl.SetCliqueAndDrag(Self, Button); //coloca o arrasta e solta no painel do topo
  finally
    FreeAndNil(umFormControl);
    
  end;
end;
procedure TfrmRelatorioVendasView.PreencheLabel;
var
  pl : String;
  I : Integer;
begin
  if (umObjectList.Count = 1) or (umObjectList.Count = 1) then
    pl := 'Venda Realizada'
  else
     pl := 'Vendas Realizadas';
  lbContador.Caption := intToStr(umObjectList.Count) + ' ' + pl + '   Total '+ FormatFloat('R$ 0...,00', CalculaTotalPedido);
end;

procedure TfrmRelatorioVendasView.PreencheListView;
var
  umItem:TListItem;
  i : Integer;
begin
  lvPedidos.Items.BeginUpdate;
  lvPedidos.Clear;
  //umObject List contem uma Lista de Pedidos
  for i := 0 to umObjectList.Count - 1 do
  begin
    umItem := lvPedidos.Items.Add;
    umItem.SubItems.Add(IntToStr(TPedido(umObjectList.Items[i]).ID));
    umItem.SubItems.Add(TPedido(umObjectList.Items[i]).Data);
    umItem.SubItems.Add(TPedido(umObjectList.Items[i]).Cliente.Nome);
    umItem.SubItems.Add(FormatFloat('R$ #....,00',TPedido(umObjectList.Items[i]).ValorTotal));
    umItem.Checked := true;
  end;
  lvPedidos.Items.EndUpdate;
end;
procedure TfrmRelatorioVendasView.ToolButton1Click(Sender: TObject);
var
  umaStringList : TStringList;
  umIniFIle : TIniFile;
begin
  umIniFile := TIniFile.Create(_pathIni);
  umaStringList := MontaStringsImpressao;
  umFormControl := TFormControl.Create;
  try
    if umIniFile.ReadString('printer','device','') <> '' then
      try
        umFormControl.Imprimir(umaStringList, umIniFile.ReadString('printer','device2',''))
      except
      on E : Exception do
        frmShowMessages.showMessage(iError,E.ClassName+ 'Não foi possível imprimir. Erro: '+E.Message);
      end
    else
     frmShowMessages.showMessage(iError, 'É preciso configurar as impressoras em "Configurações"'); 
    umaStringList.SaveToFile('relatorios/' + FormatDateTime('dd.mm.yyyy', dtp1.Date) + '-' + FormatDateTime('dd.mm.yyyy',dtp2.Date) + '-' + FormatDateTime('hh-mm-ss', now) + '.txt');
  finally
    umFormControl.Free;
    umaStringList.Free;
    umIniFIle.Free;
  end;
end;
end.
