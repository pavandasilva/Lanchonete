unit UnPedidoModel;

interface
uses
  Contnrs, UnPagamento, UnPedido, UnFirebirdConn, SysUtils, UnProdutoPedido, Vcl.Printers,
  UnProduto;
  type
    TPedidoModel = class
    private
    FPedido : TPedido;
      function getListaPagamento: TObjectList;//retorna uma lista de de objetos com todas as formas de pagamento
    public
      constructor Create; overload;
      constructor Create(APedido : TPedido);overload;
      destructor Destroy; override;
      property ListaPagamento : TObjectList read getListaPagamento;
      function Inserir: Boolean;
      property Pedido : TPedido read FPedido write FPedido;
      function getListaPedido(AData1: TDate; AData2 : TDate): TObjectList;
  end;
implementation
var
  umFireBirdConn : TFirebirdConn;
{ TPedidoModel }

constructor TPedidoModel.Create;
begin
  umFireBirdConn := TFirebirdConn.Create;
end;

constructor TPedidoModel.Create(APedido: TPedido);
begin
  umFireBirdConn := TFirebirdConn.Create;
  Pedido := APedido;
end;

destructor TPedidoModel.Destroy;
begin
  FreeAndNil(umFireBirdConn);
  inherited;
end;
function TPedidoModel.getListaPagamento: TObjectList;
var
  umPagamento : TPagamento;
begin
  Result := TObjectList.Create;
  try
    with umFireBirdConn do
    begin
      SQLConn.Close;
      SQLQuery.Close;
      SQLQuery.SQL.Clear;
      SQLQuery.SQL.Append('select pagamento__.id, pagamento_forma.forma, pagamento_cartoes.nome as cartao'
      +' from pagamento__'
      +' inner join pagamento_forma on pagamento__.pagamento_forma_id__ = pagamento_forma.id  '
      +' left join pagamento_cartoes on pagamento__.pagamento_cartoes_id__ = pagamento_cartoes.id '
      +' order by pagamento_cartoes.nome');
      SQLQuery.Open;
      SQLQuery.First;
    while not SQLQuery.Eof do
    begin
      umPagamento := TPagamento.Create;
      umPagamento.ID := SQLQuery.FieldByName('id').AsInteger;
      umPagamento.Forma := SQLQuery.FieldByName('forma').AsString;
      umPagamento.Cartao := SQLQuery.FieldByName('cartao').AsString;
      Result.Add(umPagamento);
      SQLQuery.Next;
    end;
  end;
  finally
    umFireBirdConn.SQLConn.Close;
  end;
end;
function TPedidoModel.getListaPedido(AData1, AData2 : TDate): TObjectList;
var
  umPedido : TPedido;
begin
  Result := TObjectList.Create;
  with umFireBirdConn do
  try
    InsertSQL('select pagamento_forma.forma, pagamento_cartoes.nome as cartao, pedidos.id as pedido_id, pedidos.valor, pedidos.data,'  +
    ' clientes.id as cliente_ID, clientes.nome from pagamento__' +
    ' inner join pagamento_forma on pagamento__.pagamento_forma_id__ = pagamento_forma.id' +
    ' left join pagamento_cartoes on pagamento__.pagamento_cartoes_id__ = pagamento_cartoes.id'  +
    ' inner join pedidos on pagamento__.id = pedidos.pagamento__id__' +
    ' inner join clientes on pedidos.clientes_id__ = clientes.id' +
    ' where pedidos.data between :p1 and :p2 order by data desc ');
    SQLQuery.ParamByName('p1').AsDate := AData1;
    SQLQuery.ParamByName('p2').AsDate := AData2;
    OpenSQL;
    SQLQuery.First;
    while not SQLQuery.Eof do
    begin
      umPedido := TPedido.Create;
      umPedido.ValorTotal := SQLQuery.FieldByName('valor').AsFloat;
      umPedido.Data := SQLQuery.FieldByName('data').AsString;
      umPedido.ID := SQLQuery.FieldByName('pedido_id').AsInteger;
      umPedido.Cliente.Id := SQLQuery.FieldByName('cliente_ID').AsInteger;
      umPedido.Cliente.Nome := SQLQuery.FieldByName('nome').Asstring;
      umPedido.Pagamento.Cartao := SQLQuery.FieldByName('cartao').AsString;
      umPedido.Pagamento.Forma := SQLQuery.FieldByName('forma').AsString;
      Result.Add(umPedido);
      SQLQuery.Next;
    end;
  finally
    CloseConection;
  end;
end;
function TPedidoModel.Inserir:Boolean;
var
 I : integer;
begin
  with umFireBirdConn do
  begin
    try
      try
        InsertSQL('select max(id) + 1 as GenId from Pedidos');
        OpenSQL; //abre a query
        SQLQuery.First;
        if not SQLQuery.Eof then
          FPedido.ID := SQLQuery.FieldByName('GenId').AsInteger //gera um id valido
        else
          Exit;
        StartTransaction;
        InsertSQL('insert into Pedidos (id, data, obs, valor, pagamento__id__, CLIENTES_ID__, TAXA_ENTREGA, valor_liquido) values (:pId, :pData, :pobs, :ptotal, :pPagamentoID, :pClienteID, :pTaxaEntrega, :pValorLiq)');
        SQLQuery.ParamByName('pData').AsDate := Now;
        SQLQuery.ParamByName('pObs').AsString := FPedido.Obs  ;
        SQLQuery.ParamByName('ptotal').AsFloat := FPedido.Total;
        SQLQuery.ParamByName('pId').AsInteger := FPedido.ID;
        SQLQuery.ParamByName('pPagamentoID').AsInteger := FPedido.Pagamento.ID;
        SQLQuery.ParamByName('pClienteID').AsInteger := FPedido.Cliente.Id;
        SQLQuery.ParamByName('pTaxaEntrega').AsFloat:= FPedido.TaxaEntrega;
        SQLQuery.ParamByName('pValorLiq').AsFloat:= FPedido.TotalLiquido;
        ExecuteSQL;
        for I := 0 to FPedido.ListaProduto.Count -1 do
        begin
          InsertSQL('insert into Pedidos__(pedidos_id__, PRODUTO_ID__, VALOR, QTDE) '
          + ' values (:pPedidoID, :pProdutoId, :pValor, :pQTDE)');
          SQLQuery.ParamByName('pPedidoID').AsInteger := FPedido.ID;
          SQLQuery.ParamByName('pProdutoId').AsInteger := TProdutoPedido(FPedido.ListaProduto.Items[I]).Produto.ID;
          SQLQuery.ParamByName('pValor').AsFloat := TProdutoPedido(FPedido.ListaProduto.Items[I]).Total;
          SQLQuery.ParamByName('pQTDE').AsInteger  := TProdutoPedido(FPedido.ListaProduto.Items[I]).Quantidade;
          ExecuteSQL; //executa o sql
        end;
        CommitTransaction; //faz commit
        Result := true;
      except
        RollbackTransaction; //faz rolback
        Result := false;
        Exit;
      end;
    finally
      CloseConection; //fecha a conexao
    end;
  end;
end;
end.
