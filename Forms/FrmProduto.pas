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
  dmConexao,
  ProdutoDAO,
  Produto, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFrmProduto = class(TForm)
    edtNome: TEdit;
    edtPreco: TEdit;
    edtQuantidade: TEdit;
    btnCadastrar: TButton;
    lblNome: TLabel;
    lblPreco: TLabel;
    lblQuantidade: TLabel;
    btnEditar: TButton;
    btnExcluir: TButton;
    dbgProdutos: TDBGrid;
    edtPesquisa: TEdit;
    btnPesquisar: TButton;


    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbgProdutosCellClick(Column: TColumn);
    procedure btnPesquisarClick(Sender: TObject);

  private
    FProdutosDAO: TProdutosDAO;
    FProdutoSelecionado: Integer;

    procedure AtualizarLista;
    procedure CadastrarProduto;
    procedure LimparCampos;
    procedure PesquisarProduto;


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

  procedure TFrmProduto.dbgProdutosCellClick(Column: TColumn);
    begin
      FProdutoSelecionado :=
        DataModule1.FDQuery1.FieldByName('ID').AsInteger;

      edtNome.Text :=
        DataModule1.FDQuery1.FieldByName('NOME').AsString;

      edtPreco.Text :=
        DataModule1.FDQuery1.FieldByName('PRECO').AsString;

      edtQuantidade.Text :=
        DataModule1.FDQuery1.FieldByName('QUANTIDADE').AsString;
    end;

  procedure TFrmProduto.AtualizarLista;
    begin
      FProdutosDAO.Listar;
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

        AtualizarLista;
        LimparCampos;

        ShowMessage('Produto atualizado com sucesso!');

      finally
        Produto.Free;
      end;
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

        ShowMessage('Produto removido com sucesso!');
      end;
    end;





procedure TFrmProduto.LimparCampos;
  begin
    edtNome.Clear;
    edtPreco.Clear;
    edtQuantidade.Clear;

    FProdutoSelecionado := -1;

  end;

procedure TFrmProduto.PesquisarProduto;
    begin

    FProdutosDAO.Pesquisar(edtPesquisa.Text);

    end;

procedure TFrmProduto.btnPesquisarClick(Sender: TObject);
  begin
    PesquisarProduto;
  end;

end.
