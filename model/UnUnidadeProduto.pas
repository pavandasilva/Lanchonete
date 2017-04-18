unit UnUnidadeProduto;

interface
type
  TUnidadeProduto = class
  private
    FID: Integer;
    FUnidade: String;
    FAbreviacao: String;
  public
    property ID : Integer read FID write FID;
    property Unidade : String read FUnidade write FUnidade;
    property Abreviacao : String read FAbreviacao write FAbreviacao;
  end;

implementation

end.
