unit UnCartao;

interface
type
  TCartao = class
  private
    FID: Integer;
    FCartao: String;
    FForma: String;
  public
    property Forma : String read FForma write FForma;
    property ID : Integer read FID write FID;
    property Cartao : String read FCartao write FCartao;
end;
implementation

end.
