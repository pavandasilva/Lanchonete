unit UnCategoriaProduto;

interface
type
  TCategoriaProduto = class
  private
    FID: Integer;
    FCategoria: String;
  public
    property ID : Integer read FID write FID;
    property Categoria : String read FCategoria write FCategoria;
  end;


implementation

end.
