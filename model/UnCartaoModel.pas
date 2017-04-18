unit UnCartaoModel;

interface
uses
  Contnrs, UnFirebirdConn, UnPagamento;
type
  TCartaoModel = class
  private
    FBandeira: String;
    FTipo: String;
    function GetBandeira: String;
    function GetTipo: String;
    function GetLista: TObjectList;
  public
    destructor Destroy; override;
    property Bandeira: String read GetBandeira write FBandeira;
    property Tipo: String read GetTipo write FTipo;
    property Lista : TObjectList read GetLista;
    constructor Create;

  end;

implementation

{ TCartaoModel }
var
  umFireBirdConn: TFirebirdConn;
constructor TCartaoModel.Create;
begin
  umFireBirdConn := TFirebirdConn.Create;
end;

destructor TCartaoModel.Destroy;
begin
  umFireBirdConn.Free;
  inherited;
end;

function TCartaoModel.GetBandeira: String;
begin
  Result := FBandeira;
end;

function TCartaoModel.GetLista: TObjectList;
var
  SQL : String;
  umPagamento : TPagamento;
begin
  Result := TObjectList.Create;

  try
    with umFireBirdConn do
    begin
      SQLConn.Close;
      SQLQuery.Close;
      SQLQuery.SQL.Clear;
      SQLQuery.SQL.Append('select pagamento__.id, pagamento_forma.forma, pagamento_cartoes.nome '
      +' from pagamento__'
      +' inner join pagamento_forma on pagamento__.pagamento_forma_id__ = pagamento_forma.id  '
      +' left join pagamento_cartoes on pagamento__.pagamento_cartoes_id__ = pagamento_cartoes.id');
      SQLQuery.Open;
      SQLQuery.First;
    while not SQLQuery.Eof do
    begin
      umCartao := TCartao.Create;
      umCartao.ID := SQLQuery.FieldByName('id').AsInteger;
      umCartao.Bandeira := SQLQuery.FieldByName('bandeira').AsString;
      umCartao.Tipo := SQLQuery.FieldByName('tipo').AsString;
      Result.Add(umCartao);
      SQLQuery.Next;
    end;
  end;
  finally
    umFireBirdConn.SQLConn.Close;
  end;



end;

function TCartaoModel.GetTipo: String;
begin
  Result := FTipo;
end;

end.
