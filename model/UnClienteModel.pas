unit UnClienteModel;

interface

uses UnFirebirdConn, UnCliente, dialogs, classes, System.SysUtils, Contnrs;
type
  TCLienteModel  = class (TCliente)
  private
    FFirebirdConn : TFirebirdConn;
  public
    function Buscar(Value : String): TObjectList;
    constructor Create;
    destructor Destroy;override;
    function Adicionar : Boolean;
    function Atualizar : Boolean;
    function Deletar(Value : Integer) : Boolean;
end;
implementation
{ TProdutoModel }
function TCLienteModel.Adicionar: Boolean;
begin
  Result := False;
  with FFirebirdConn do
  try
    try
      StartTransaction;
      InsertSQL('INSERT INTO CLIENTES(NOME, TEL, CEL, ENDERECO, BAIRRO, KEYWORDS) '
      + '  VALUES(:pNome, :pTel, :pCel, :pEndereco, :pBairro, :pKeyWords)');
      SQLQuery.ParamByName('pNome').AsString := Nome;
      SQLQuery.ParamByName('pTel').AsString := Tel;
      SQLQuery.ParamByName('pCel').AsString := Cel;
      SQLQuery.ParamByName('pEndereco').AsString := Endereco;
      SQLQuery.ParamByName('pBairro').AsString := Bairro;
      SQLQuery.ParamByName('pKeyWords').AsString := Nome + ' ' + Tel + ' ' +
      Cel + ' ' + Endereco + ' ' + Bairro;
      ExecuteSQL;
      CommitTransaction;
      Result := true;
    except
      RollbackTransaction;
    end;
  finally
     CloseConection;
  end;
end;
function TCLienteModel.Atualizar: Boolean;
begin
  Result := False;
  with FFirebirdConn do
  try
    try
      StartTransaction;
      InsertSQL('update Clientes SET nome = :pNome, tel = :pTel, cel = :pCel, ' +
      ' endereco = :pEndereco, bairro = :pBairro where id = :pId');
      SQLQuery.ParamByName('pId').AsInteger       := Id;
      SQLQuery.ParamByName('pNome').AsString      := Nome;
      SQLQuery.ParamByName('pTel').AsString       := Tel;
      SQLQuery.ParamByName('pCel').AsString       := Cel;
      SQLQuery.ParamByName('pEndereco').AsString  := Endereco;
      SQLQuery.ParamByName('pBairro').AsString    := Bairro;
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
function TCLienteModel.Buscar(Value: String): TObjectList;
var
  umCliente : TCliente;
  SQL : String;
begin
   Result := TObjectList.Create;
   try
    if Value = '' then
      SQL := 'select * from CLientes where Nome <> :pValue'
    else
      SQL := 'Select * from CLIENTES ' +
      ' WHERE  replace(replace(replace(KEYWORDS,' +Quotedstr('-') +','+QuotedStr('')+'),' +
      QuotedStr('(') + ','+ QuotedStr('') + '),' + QuotedStr(')') + ',' + QuotedStr('') + ') CONTAINING :pValue';
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
        umCliente := TCliente.Create;
        umCliente.Id := SQLQuery.FieldByName('ID').AsInteger;
        umCliente.Nome := SQLQuery.FieldByName('NOME').AsString;
        umCliente.Endereco := SQLQuery.FieldByName('ENDERECO').AsString;
        umCliente.Cel := SQLQuery.FieldByName('CEL').AsString;
        umCliente.Tel := SQLQuery.FieldByName('TEL').AsString;
        umCliente.Bairro := SQLQuery.FieldByName('BAIRRO').AsString;
        SQLQuery.Next;
        Result.Add(TCliente(umCliente));
      end;
    end;
    finally
      FFirebirdConn.SQLConn.Close;
    end;
end;
constructor TCLienteModel.Create;
begin
  FFirebirdConn := TFirebirdConn.Create;
end;

function TCLienteModel.Deletar(Value : Integer) : Boolean;
begin
  Result := False;
  with FFirebirdConn do
  try
    try
      StartTransaction;
      InsertSQL('delete from clientes where id = :pID');
      SQLQuery.ParamByName('pID').AsInteger := Value;
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

destructor TCLienteModel.Destroy;
begin
  FFirebirdConn.Free;
  inherited;
end;

end.
