unit UnPagamento;

interface
type
  TPagamento = class
  private
    FID: Integer;
    FCartao: String;
    FForma: String;
  public
    destructor Destroy; override;
    property Forma : String read FForma write FForma;
    property ID : Integer read FID write FID;
    property Cartao : String read FCartao write FCartao;

end;
implementation

{ TPagamento }

destructor TPagamento.Destroy;
begin
  inherited;
end;

end.
