unit UnProdutoPedidoModel;
interface
uses UnProdutoPedido, UnFirebirdConn;
type
  TProdutoPedidoModel = class
  private
    FFirebirdConn: TFirebirdConn;
  public
    function BuscarProduto(AID : Integer) : TProdutoPedido;
    constructor Create;
    destructor Destroy; override;

  end;
implementation
{ TProdutoPedidoModel }
function TProdutoPedidoModel.BuscarProduto(AID: Integer): TProdutoPedido;
begin
  Result := TProdutoPedido.Create;
  try
  with FFirebirdConn do
    begin
      SQLConn.Close;
      SQLQuery.Close;
      SQLQuery.SQL.Clear;
      SQLQuery.SQL.Append('SELECT produtos.id, produtos.descricao, PRODUTOS.valor, unidadeprodutos.id as UnidadeID, unidadeprodutos.unidade, unidadeprodutos.abreviacao, categoriaprodutos.id as CategoriaId, categoriaprodutos.categoria '
        + ' from produtos ' +
        ' inner join produtos_unidade_categoria on produtos.id = produtos_unidade_categoria.produtos_id__ '
        + ' inner join categoriaprodutos on produtos_unidade_categoria.categoria_id__ = categoriaprodutos.id '
        + ' inner join unidadeprodutos on produtos_unidade_categoria.unidade_id__ = unidadeprodutos.id '
        + ' where produtos.id = :pValue ');
      SQLQuery.ParamByName('pValue').AsInteger := AID;
      SQLQuery.Open;
      SQLQuery.First;
      While not SQLQuery.Eof do
      begin
        Result.Produto.ID := SQLQuery.FieldByName('id').AsInteger;
        Result.PRoduto.Descricao := SQLQuery.FieldByName('descricao').AsString;
        Result.Produto.Valor := SQLQuery.FieldByName('valor').AsFloat;
        Result.Produto.UnidadeID := SQLQuery.FieldByName('UnidadeId').AsInteger;
        Result.Produto.CategoriaID := SQLQuery.FieldByName('CategoriaId').AsInteger;
        Result.Produto.Unidade := SQLQuery.FieldByName('unidade').AsString;
        Result.Produto.Categoria := SQLQuery.FieldByName('categoria').AsString;
        Result.Produto.UnidadeAbreviacao:= SQLQuery.FieldByName('abreviacao').AsString;
        SQLQuery.Next;
      end;
    end;
  finally
    FFirebirdConn.SQLConn.Close;
  end;
end;

constructor TProdutoPedidoModel.Create;
begin
  FFirebirdConn := TFirebirdConn.Create;

end;

destructor TProdutoPedidoModel.Destroy;
begin
  FFirebirdConn.Free;
  inherited;
end;

end.
