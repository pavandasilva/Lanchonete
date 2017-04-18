unit UnProduto;

interface
uses classes;
type
  TProduto = class
  private
    FValor: Real;
    FDescricao: String;
    FFieldsView : TStringList;
    FCategoria: String;
    FUnidade: String;
    FID: Integer;
    FUnidadeID: Integer;
    FCategoriaID: Integer;
    FUnidadeAbreviacao: String;
    function GetFieldsView: TStringList;
    const
      ArrayFieldsView : array [0..4] of  string =
      ('Código', 'Produto', 'Categoria', 'Unidade', 'Preço');
  public
    destructor Destroy; override;
    constructor Create;
    property ID : Integer read FID write FID;
    property Descricao : String read FDescricao write FDescricao;
    property Valor : Real read FValor write FValor;
    property Categoria : String read FCategoria write FCategoria;
    property CategoriaID : Integer read FCategoriaID write FCategoriaID;
    property Unidade : String read FUnidade write FUnidade;
    property UnidadeID : Integer read FUnidadeID write FUnidadeID;
    property FieldsView : TStringList read GetFieldsView;
    property UnidadeAbreviacao : String read FUnidadeAbreviacao write FUNidadeAbreviacao;
  end;
implementation

{ TProduto }

constructor TProduto.Create;
begin
  FFieldsView := TStringList.Create;
  inherited;

end;

destructor TProduto.Destroy;
begin
  FFieldsView.Free;
  inherited;
end;

function TProduto.GetFieldsView: TStringList;
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


end.
