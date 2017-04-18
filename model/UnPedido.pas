unit UnPedido;

interface

uses UnCliente, Contnrs, UnProdutoPedido, sysutils, classes, UnPagamento;
type
  TPedido = class
  private
    FID: Integer;
    FObs: String;
    FValorTotal: Real;

    FValorPago : Real;
    FProdutoPedido : TProdutoPedido;
    FData: String;
    FCliente : TCliente;
    FListaProduto : TObjectList;
    FFieldsView : TStringList;
    FFieldsViewRelatorio : TStringList;
    FPagamento: TPagamento;
    FTroco : Real;
    FTaxaEntrega: Real;
    FTotalLiquido: Real;
    function GetFieldsView: TStringList;
    function GetFieldsViewRelatorio: TStringList;
    function GetTotal: Real;
    function GetTotalLiquido: Real;
    const
      ArrayFieldsView : array [0..4] of  string =('Quantidade', 'Produto',  'Valor', 'Total', 'Observação');
      ArrayFieldsViewRelatorio : array [0..3] of String = ('Código', 'Data', 'Cliente', 'Total');
  public
    constructor Create;
    destructor Destroy; override;
    property ID : Integer read FID write FID;
    property Data : String read FData write FData;
    property Obs : String read FObs write FObs;
    property ValorTotal : Real read FValorTotal write FValorTotal;
    property Cliente : TCliente read FCliente write FCliente;
    property ListaProduto : TObjectList read FListaProduto;
    property FieldsView : TStringList read GetFieldsView;
    property FieldsViewRelatorio : TStringList read GetFieldsViewRelatorio;
    procedure SetListaProduto(Value : TProdutoPedido);
    property Total : Real read GetTotal;
    property ValorPago : Real read FValorPago  write FValorPago;
    property TaxaEntrega : Real read FTaxaEntrega  write FTaxaEntrega;
    property Pagamento : TPagamento read FPagamento write FPagamento;
    property TotalLiquido : Real read GetTotalLiquido write FTotalLiquido;
  end;
implementation

{ TPedido }
constructor TPedido.Create;
begin
  FCliente := TCliente.Create;
  FPagamento := TPagamento.Create;
  FListaProduto := TObjectList.Create;
  FFieldsView := TStringList.Create;
  FFieldsViewRelatorio := TStringList.Create;
end;
destructor TPedido.Destroy;
begin
  FreeAndNil(FFieldsViewRelatorio);
  FreeAndNil(FFieldsView);
  FreeAndNil(FListaProduto);
  FreeAndNil(FPagamento);
  FreeAndNil(FCliente);
  inherited;
end;

function TPedido.GetFieldsView: TStringList;
var
  i : Integer;
begin
   FFieldsView.Clear;
   for   i := 0 to Length(ArrayFieldsView) -1 do
   begin
      FFieldsView.Add(ArrayFieldsView[i]);
   end;
  Result := FFieldsView;
end;

function TPedido.GetFieldsViewRelatorio: TStringList;
var
  i : Integer;
begin
    FFieldsViewRelatorio.Clear;
   for   i := 0 to Length(ArrayFieldsViewRelatorio) -1 do
   begin
      FFieldsViewRelatorio.Add(ArrayFieldsViewRelatorio[i]);
   end;
  Result := FFieldsViewRelatorio;
end;

function TPedido.GetTotal: Real;
begin
  Result := GetTotalLiquido + FTaxaEntrega;
end;
function TPedido.GetTotalLiquido: Real;
  var
  I : Integer;
begin
  Result := 0;
  for I := 0 to ListaProduto.Count - 1 do
  begin
    Result := Result + TProdutoPedido(ListaProduto.Items[I]).Total;
  end;


end;

procedure TPedido.SetListaProduto(Value: TProdutoPedido);
begin
  FListaProduto.Add(Value);
end;


{ TPedido }


end.
