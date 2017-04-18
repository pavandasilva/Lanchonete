unit UnCliente;

interface
uses UnPessoa, classes, System.SysUtils;
type
  TCliente = class(TPessoa)
  private
    FFieldsView : TStringList;
    function GetClienteId: Integer;
    procedure SetClienteId(const Value: Integer);
    function GetFieldsView: TStringList;
    const
      ArrayFieldsView : array [0..5] of  string =
      ('Código','Nome', 'Telefone', 'Celular', 'Endereço', 'Bairro');
  public

    destructor Destroy; override;
    property  FieldsView : TStringList read GetFieldsView;
    property ClienteID : Integer read GetClienteId write SetClienteId;
    constructor Create;

  end;
implementation

{ TCliente }
constructor TCliente.Create;
begin
  FFieldsView := TStringList.Create;
end;

destructor TCliente.Destroy;
begin
   FreeAndNil(FFieldsView);
   inherited;
end;
function TCliente.GetClienteId: Integer;
begin
  Result := id;
end;
function TCliente.GetFieldsView: TStringList;
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

procedure TCliente.SetClienteId(const Value: Integer);
begin
  Id := Value;
end;

end.
