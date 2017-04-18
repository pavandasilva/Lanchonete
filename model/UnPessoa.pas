unit UnPessoa;

interface
type
  TPessoa = class

  private
    FBairro: String;
    FId: Integer;
    FNome: String;
    FEndereco: String;
    FTel: String;
    FCel: String;
  public
    property Id : Integer read FId write FId;
    property Nome : String read FNome write FNome;
    property Endereco : String read FEndereco write FEndereco;
    property Bairro : String read FBairro write FBairro;
    property Tel : String read FTel write FTel;
    property Cel : String read FCel write FCel;
  end;
implementation

end.
