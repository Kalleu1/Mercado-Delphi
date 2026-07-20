unit FrmProduto;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  ProdutoDAO,
  Produto;

type
  TFrmProduto = class(TForm)
    edtNome: TEdit;
    edtPreco: TEdit;
    edtQuantidade: TEdit;
    btnCadastrar: TButton;
    lstProdutos: TListBox;
    lblNome: TLabel;
    lblPreco: TLabel;
    lblQuantidade: TLabel;
    btnEditar: TButton;
    btnExcluir: TButton;


    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure lstProdutosClick(Sender: TObject);

  private
    FProdutosDAO: TProdutosDAO;
    FProdutoSelecionado: Integer;

    procedure AtualizarLista;
    procedure CadastrarProduto;
    procedure LimparCampos;


  public

  end;

var
  FrmProdutoTela: TFrmProduto;

implementation

{$R *.dfm}


  procedure TFrmProduto.FormCreate(Sender: TObject);
  begin
    FProdutosDAO := TProdutosDAO.Create;
    FProdutoSelecionado := -1;
  end;


  procedure TFrmProduto.FormDestroy(Sender: TObject);
  begin
    FProdutosDAO.Free;
  end;


  procedure TFrmProduto.btnCadastrarClick(Sender: TObject);
  begin
    CadastrarProduto;
  end;


  procedure TFrmProduto.CadastrarProduto;
var
  NovoProduto: TProduto;
  Preco: Double;
  Quantidade: Integer;

begin

  if edtNome.Text = '' then
  begin
    ShowMessage('Informe o nome do produto.');
    Exit;
  end;


  if not TryStrToFloat(edtPreco.Text, Preco) then
  begin
    ShowMessage('Informe um preço válido.');
    Exit;
  end;


  if not TryStrToInt(edtQuantidade.Text, Quantidade) then
  begin
    ShowMessage('Informe uma quantidade válida.');
    Exit;
  end;


  NovoProduto := TProduto.Create;


  NovoProduto.Nome :=
    edtNome.Text;

  NovoProduto.Preco :=
    Preco;

  NovoProduto.Quantidade :=
    Quantidade;

  NovoProduto.Ativo :=
    True;


  FProdutosDAO.Adicionar(NovoProduto);


  AtualizarLista;


  LimparCampos;


  ShowMessage('Produto cadastrado com sucesso!');

end;

  procedure TFrmProduto.AtualizarLista;
var
  Item: TProduto;

begin

  lstProdutos.Clear;


  for Item in FProdutosDAO.Listar do
  begin
    lstProdutos.Items.AddObject(
      IntToStr(Item.Id) +
      ' - ' +
      Item.Nome +
      ' | R$ ' +
      FloatToStr(Item.Preco) +
      ' | Qtd: ' +
      IntToStr(Item.Quantidade),
      TObject(Item.Id)
    );
  end;

end;

  procedure TFrmProduto.lstProdutosClick(Sender: TObject);
var
  Produto: TProduto;
  IdSelecionado: Integer;

begin

  if lstProdutos.ItemIndex = -1 then
    Exit;


  IdSelecionado :=
    Integer(lstProdutos.Items.Objects[lstProdutos.ItemIndex]);


  FProdutoSelecionado := IdSelecionado;


  for Produto in FProdutosDAO.Listar do
  begin

    if Produto.Id = IdSelecionado then
    begin

      edtNome.Text :=
        Produto.Nome;

      edtPreco.Text :=
        FloatToStr(Produto.Preco);

      edtQuantidade.Text :=
        IntToStr(Produto.Quantidade);

      Break;

    end;

  end;

end;

procedure TFrmProduto.btnEditarClick(Sender: TObject);
var
  Produto: TProduto;
  Preco: Double;
  Quantidade: Integer;

begin

  if FProdutoSelecionado = -1 then
  begin
    ShowMessage('Selecione um produto.');
    Exit;
  end;


  for Produto in FProdutosDAO.Listar do
  begin

    if Produto.Id = FProdutoSelecionado then
    begin

      Produto.Nome :=
        edtNome.Text;

       if not TryStrToFloat(edtPreco.Text, Preco) then
        begin
          ShowMessage('Preço inválido.');
          Exit;
        end;


        if not TryStrToInt(edtQuantidade.Text, Quantidade) then
        begin
          ShowMessage('Quantidade inválida.');
          Exit;
        end;


      FProdutosDAO.Atualizar(Produto);

      Break;

    end;

  end;


  AtualizarLista;
  LimparCampos;

  ShowMessage('Produto atualizado!');

end;


procedure TFrmProduto.btnExcluirClick(Sender: TObject);
begin

  if FProdutoSelecionado = -1 then
  begin
    ShowMessage('Selecione um produto.');
    Exit;
  end;


  if MessageDlg(
    'Deseja realmente excluir este produto?',
    mtConfirmation,
    [mbYes, mbNo],
    0
  ) = mrYes then
  begin

    FProdutosDAO.Remover(FProdutoSelecionado);

  end
  else
  begin
    Exit;
  end;


  AtualizarLista;


  FProdutoSelecionado := -1;


  ShowMessage('Produto removido!');

end;

procedure TFrmProduto.LimparCampos;
begin
  edtNome.Clear;
  edtPreco.Clear;
  edtQuantidade.Clear;

  FProdutoSelecionado := -1;

  lstProdutos.ItemIndex := -1;
end;

end.
