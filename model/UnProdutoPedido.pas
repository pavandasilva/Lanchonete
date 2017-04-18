unit UnProdutoPedido;
interface
uses UnProduto;
type
  TProdutoPedido = class
  private
    FProduto : TProduto;
    FQuantidade: Integer;
    FObservacao : String;
    function getTotal: Real;
    procedure setProduto(const Value: TProduto);
  public
    destructor Destroy; override;
    property Quantidade : Integer read FQuantidade write FQuantidade;
    property Observação : String read FObservacao write FObservacao;
    property Total : Real read getTotal;
    property Produto : TProduto read FProduto write setProduto;
    constructor Create;
  end;
implementation
{ TProdutoPedido }
constructor TProdutoPedido.Create;
begin

end;
destructor TProdutoPedido.Destroy;
var
  I : Integer;
begin
  FProduto.Free;
  inherited;
end;

function TProdutoPedido.getTotal: Real;
begin
  Result := Quantidade * Produto.Valor;
end;
procedure TProdutoPedido.setProduto(const Value: TProduto);
begin
  FProduto := Value;
end;

end.
