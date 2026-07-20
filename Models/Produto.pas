unit Produto;

interface

type
  TProduto = class
  private
    FId: Integer;
    FNome: string;
    FPreco: Double;
    FQuantidade: Integer;
    FAtivo: Boolean;

  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Preco: Double read FPreco write FPreco;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property Ativo: Boolean read FAtivo write FAtivo;
  end;

implementation

end.
