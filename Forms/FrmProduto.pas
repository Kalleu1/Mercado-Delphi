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
  FireDAC.Comp.Client,
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

    AtualizarLista;
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
    Query: TFDQuery;
  begin
    lstProdutos.Clear;

    Query := FProdutosDAO.Listar;

    Query.First;

    while not Query.Eof do
    begin
      lstProdutos.Items.AddObject(
        Query.FieldByName('ID').AsString +
        ' - ' +
        Query.FieldByName('NOME').AsString +
        ' | R$ ' +
        FormatFloat('0.00', Query.FieldByName('PRECO').AsFloat) +
        ' | Qtd: ' +
        Query.FieldByName('QUANTIDADE').AsString,

        TObject(NativeInt(Query.FieldByName('ID').AsInteger))
      );

      Query.Next;
    end;
  end;

procedure TFrmProduto.lstProdutosClick(Sender: TObject);
var
  Query: TFDQuery;
begin
  if lstProdutos.ItemIndex = -1 then
    Exit;

  FProdutoSelecionado :=
    NativeInt(lstProdutos.Items.Objects[lstProdutos.ItemIndex]);

  Query := FProdutosDAO.Listar;

  Query.First;

  while not Query.Eof do
  begin
    if Query.FieldByName('ID').AsInteger = FProdutoSelecionado then
    begin
      edtNome.Text := Query.FieldByName('NOME').AsString;
      edtPreco.Text := Query.FieldByName('PRECO').AsString;
      edtQuantidade.Text := Query.FieldByName('QUANTIDADE').AsString;
      Exit;
    end;

    Query.Next;
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

  Produto := TProduto.Create;
  try
    Produto.Id := FProdutoSelecionado;
    Produto.Nome := edtNome.Text;
    Produto.Preco := Preco;
    Produto.Quantidade := Quantidade;
    Produto.Ativo := True;

    FProdutosDAO.Atualizar(Produto);

  finally
    Produto.Free;
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
      0) = mrYes then
  begin
    FProdutosDAO.Remover(FProdutoSelecionado);

    AtualizarLista;
    LimparCampos;

    ShowMessage('Produto removido!');
  end;
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
