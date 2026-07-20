program Project1;

uses
  Vcl.Forms,
  FrmProduto in 'Forms\FrmProduto.pas',
  Produto in 'Models\Produto.pas',
  ProdutoDAO in 'DAO\ProdutoDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmProduto, FrmProdutoTela);
  Application.Run;
end.
