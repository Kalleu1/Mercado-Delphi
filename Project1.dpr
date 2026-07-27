program Project1;

uses
  Vcl.Forms,
  FrmProduto in 'Forms\FrmProduto.pas',
  Produto in 'Models\Produto.pas',
  ProdutoDAO in 'DAO\ProdutoDAO.pas',
  dmConexao in 'Data\dmConexao.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrmProduto, FrmProdutoTela);
  Application.Run;
end.
