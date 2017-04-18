unit UnProdutoModel;

interface

uses UnFirebirdConn, UnProduto, dialogs, classes, UnCategoriaProduto, Contnrs,SqlExpr,
  UnUnidadeProduto, sysuTils;
type
  TProdutoModel = class
  private
    FFirebirdConn: TFirebirdConn;
    FProduto : TProduto;
  public
    constructor Create;
    destructor Destroy; override;
    function Buscar(Value: String): TObjectList;
    function BuscarPorId(Value : Integer) : TProduto;
    function Deletar(Value : Integer):Boolean;
    function Inserir: Boolean;
    function Atualizar: Boolean;
    function GetGategorias: TObjectList;
    function GetUnidades: TObjectList;
    property Produto : TProduto read FProduto write FProduto;
    function GerarId: Integer;
 end;
implementation
{ TProdutoModel }
function TProdutoModel.Inserir: Boolean;
var
  GenId: Integer;
  ID : Integer;
begin
  Result := False;
  ID := GerarId;
  with FFirebirdConn do
  begin
    StartTransaction;
    try
      try
      InsertSQL('INSERT INTO PRODUTOS(ID, DESCRICAO, VALOR, KEYWORDS) ' +
      ' VALUES(:pId, :pDescricao, :pValor, :pKeyWords)');
      SQLQuery.ParamByName('pId').AsInteger := ID;
      SQLQuery.ParamByName('pDescricao').AsString := Produto.Descricao;
      SQLQuery.ParamByName('pValor').AsFloat := Produto.Valor;
      SQLQuery.ParamByName('pKeyWords').AsString := Produto.Descricao + ' '
      +' '+ Produto.Categoria +' '+ Produto.Unidade + IntTostr(ID);
      ExecuteSQL;
      InsertSQL('INSERT INTO PRODUTOS_UNIDADE_CATEGORIA(unidade_id__, categoria_id__, produtos_id__) '
      + 'VALUES (:pUnidade_id, :pCategoria_id, :pProduto_id)');
      SQLQuery.ParamByName('pUnidade_id').AsInteger := Produto.UnidadeID;
      SQLQuery.ParamByName('pCategoria_id').AsInteger := Produto.CategoriaID;
      SQLQuery.ParamByName('pProduto_id').AsInteger := ID;
      ExecuteSQL;
      CommitTransaction;
      Result := True;
      except
        RollbackTransaction;
      end
    finally
      CloseConection;
    end;
  end;
end;
function TProdutoModel.Buscar(Value: String): TObjectList;
var
  umProduto: TProduto;
  SQL: String;
begin
  Result := TObjectList.Create;
  try
    if Value = '' then
      SQL := 'SELECT produtos.id, produtos.descricao, PRODUTOS.valor, unidadeprodutos.id as UnidadeID, unidadeprodutos.unidade, unidadeprodutos.abreviacao, categoriaprodutos.id as CategoriaId, categoriaprodutos.categoria '
        + ' from produtos ' +
        ' inner join produtos_unidade_categoria on produtos.id = produtos_unidade_categoria.produtos_id__ '
        + ' inner join categoriaprodutos on produtos_unidade_categoria.categoria_id__ = categoriaprodutos.id '
        + ' inner join unidadeprodutos on produtos_unidade_categoria.unidade_id__ = unidadeprodutos.id '
        + ' where produtos.descricao <> :pValue '
    else
      SQL := 'SELECT produtos.id , produtos.descricao, PRODUTOS.valor, unidadeprodutos.id as UnidadeID, unidadeprodutos.unidade, unidadeprodutos.abreviacao, categoriaprodutos.id as CategoriaId, categoriaprodutos.categoria '
        + ' from produtos ' +
        ' inner join produtos_unidade_categoria on produtos.id = produtos_unidade_categoria.produtos_id__ '
        + ' inner join categoriaprodutos on produtos_unidade_categoria.categoria_id__ = categoriaprodutos.id '
        + ' inner join unidadeprodutos on produtos_unidade_categoria.unidade_id__ = unidadeprodutos.id '
        + ' where produtos.descricao containing :pValue or categoriaprodutos.categoria containing :pValue ';
    with FFirebirdConn do
    begin
      SQLConn.Close;
      SQLQuery.Close;
      SQLQuery.SQL.Clear;
      SQLQuery.SQL.Append(SQL);
      SQLQuery.ParamByName('pValue').AsString := Value;
      SQLQuery.Open;
      SQLQuery.First;
      while not SQLQuery.Eof do
      begin
        umProduto := TProduto.Create;
        umProduto.ID := SQLQuery.FieldByName('id').AsInteger;
        umProduto.Descricao := SQLQuery.FieldByName('descricao').AsString;
        umProduto.Valor := SQLQuery.FieldByName('valor').AsFloat;
        umProduto.UnidadeID := SQLQuery.FieldByName('UnidadeId').AsInteger;
        umProduto.CategoriaID := SQLQuery.FieldByName('CategoriaId').AsInteger;
        umProduto.Unidade := SQLQuery.FieldByName('unidade').AsString;
        umProduto.Categoria := SQLQuery.FieldByName('categoria').AsString;
        umProduto.UnidadeAbreviacao:= SQLQuery.FieldByName('abreviacao').AsString;
        SQLQuery.Next;
        Result.Add(umProduto);
      end;
    end;
  finally
    FFirebirdConn.SQLConn.Close;
  end;
end;
function TProdutoModel.BuscarPorId(Value: Integer): TProduto;
begin
  Result := TProduto.Create;
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
      SQLQuery.ParamByName('pValue').AsInteger :=Value;
      SQLQuery.Open;
      SQLQuery.First;
      While not SQLQuery.Eof do
      begin
        Result.ID := SQLQuery.FieldByName('id').AsInteger;
        Result.Descricao := SQLQuery.FieldByName('descricao').AsString;
        Result.Valor := SQLQuery.FieldByName('valor').AsFloat;
        Result.UnidadeID := SQLQuery.FieldByName('UnidadeId').AsInteger;
        Result.CategoriaID := SQLQuery.FieldByName('CategoriaId').AsInteger;
        Result.Unidade := SQLQuery.FieldByName('unidade').AsString;
        Result.Categoria := SQLQuery.FieldByName('categoria').AsString;
        Result.UnidadeAbreviacao:= SQLQuery.FieldByName('abreviacao').AsString;
        SQLQuery.Next;
      end;
    end;
  finally
    FFirebirdConn.SQLConn.Close;
  end;
end;
constructor TProdutoModel.Create;
begin
  FFirebirdConn := TFirebirdConn.Create;
  FProduto := TProduto.Create;
end;

function TProdutoModel.Deletar(Value: Integer): Boolean;
begin
  Result := False;
  with FFirebirdConn do
  try
    try
      StartTransaction;
      InsertSQL('delete from PRODUTOS_UNIDADE_CATEGORIA where produtos_id__ = :pValue');
      SQLQuery.ParamByName('pValue').AsInteger := Value;
      ExecuteSQL;
      InsertSQL('delete from PRODUTOS_UNIDADE_CATEGORIA where produtos_id__ = :pValue');
      SQLQuery.ParamByName('pValue').AsInteger := Value;
      ExecuteSQL;
      InsertSQL('delete from produtos where id = :pValue');
      SQLQuery.ParamByName('pValue').AsInteger := Value;
      SQLQuery.ParamByName('pValue').AsInteger := Value;
      ExecuteSQL;
      CommitTransaction;
      Result := True;
      except
        RollbackTransaction;
      end;
  finally
    CloseConection;
  end;
end;
destructor TProdutoModel.Destroy;
begin
  FFirebirdConn.Free;
  FProduto.Free;
  inherited;
end;
function TProdutoModel.Atualizar: Boolean;
begin
  Result := False;
  with FFirebirdConn do
  try
    try
      StartTransaction;
      InsertSQL('UPDATE produtos_unidade_categoria ' +
      ' SET unidade_ID__ = :pUnidadeID, categoria_id__ = :pCategoriaID '+
      ' WHERE produtos_id__ = :pProdutosID');
      SQLQuery.ParamByName('pUnidadeID').AsInteger := Produto.UnidadeID;
      SQLQuery.ParamByName('pCategoriaID').AsInteger := Produto.CategoriaID;
      SQLQuery.ParamByName('pProdutosID').AsInteger := Produto.ID;
      ExecuteSQL;
      InsertSQL('UPDATE produtos  SET descricao = :pDescricao, valor = :pValor, keywords = :pKeywords where id = :pProdutosID');
      SQLQuery.ParamByName('pDescricao').AsString := Produto.Descricao;
      SQLQuery.ParamByName('pValor').AsFloat := Produto.Valor;
      SQLQuery.ParamByName('pKeywords').AsString := Produto.Descricao + ' ' + ' ' + Produto.Categoria + ' ' + Produto.Unidade;
      SQLQuery.ParamByName('pProdutosID').AsInteger := Produto.ID;
      ExecuteSQL;
      CommitTransaction;
      Result := True;
    except
      RollbackTransaction;
    end;
  finally
    CloseConection;
  end;
end;
function TProdutoModel.GetUnidades: TObjectList;
var
  umaUnidadeProduto: TUnidadeProduto;
begin
  Result := TObjectList.Create;
  Result.Clear;
  with FFirebirdConn do
  begin
    try
      SQLConn.Close;
      SQLQuery.Close;
      SQLQuery.SQL.Clear;
      SQLQuery.SQL.Append('select * from unidadeprodutos order by unidade');
      SQLQuery.Open;
      SQLQuery.First;
      while not SQLQuery.Eof do
      begin
        umaUnidadeProduto := TUnidadeProduto.Create;
        umaUnidadeProduto.ID := SQLQuery.FieldByName('ID').AsInteger;
        umaUnidadeProduto.Unidade := SQLQuery.FieldByName('Unidade').AsString;
        umaUnidadeProduto.Abreviacao := SQLQuery.FieldByName('Abreviacao').AsString;
        Result.Add(umaUnidadeProduto);
        SQLQuery.Next;
      end;
    finally
      SQLConn.Close;
    end;
  end;
end;

function TProdutoModel.GerarId: Integer;
begin
  with FFirebirdConn do
  begin
    ClearQuery;
    SQLQuery.SQL.Append('select max (ID) + 1 as GenId from produtos');
    SQLQuery.Open;
    SQLQuery.First;
    if SQLQuery.RecordCount > 0 then
      Result :=  SQLQuery.FieldByName('GenId').AsInteger
    else
      Result := 1;
   end;
end;
function TProdutoModel.GetGategorias: TObjectList;
var
  umaCategoriaProduto: TCategoriaProduto;
begin
  Result := TObjectList.Create;
  Result.Clear;
  with FFirebirdConn do
  begin
    try
      SQLConn.Close;
      SQLQuery.Close;
      SQLQuery.SQL.Clear;
      SQLQuery.SQL.Append('select * from categoriaprodutos order by Categoria');
      SQLQuery.Open;
      SQLQuery.First;
      while not SQLQuery.Eof do
      begin
        umaCategoriaProduto := TCategoriaProduto.Create;
        umaCategoriaProduto.ID := SQLQuery.FieldByName('ID').AsInteger;
        umaCategoriaProduto.Categoria :=
          SQLQuery.FieldByName('Categoria').AsString;
        Result.Add(umaCategoriaProduto);
        SQLQuery.Next;
      end;
    finally
      SQLConn.Close;
    end;
  end;

end;

end.
