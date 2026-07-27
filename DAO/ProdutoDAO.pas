unit ProdutoDAO;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  Produto,
  dmConexao;

type
  TProdutosDAO = class
  public
    procedure Adicionar(AProduto: TProduto);
    procedure Atualizar(AProduto: TProduto);
    procedure Remover(AId: Integer);
    function Listar: TFDQuery;
  end;

 implementation

 procedure TProdutosDAO.Adicionar(AProduto: TProduto);
  begin
    DataModule1.FDQuery1.Close;
    DataModule1.FDQuery1.SQL.Clear;

    DataModule1.FDQuery1.SQL.Add(
      'INSERT INTO PRODUTOS (NOME, PRECO, QUANTIDADE, ATIVO) ' +
      'VALUES (:NOME, :PRECO, :QUANTIDADE, :ATIVO)');

    DataModule1.FDQuery1.ParamByName('NOME').AsString := AProduto.Nome;
    DataModule1.FDQuery1.ParamByName('PRECO').AsFloat := AProduto.Preco;
    DataModule1.FDQuery1.ParamByName('QUANTIDADE').AsInteger := AProduto.Quantidade;
    DataModule1.FDQuery1.ParamByName('ATIVO').AsInteger := Ord(AProduto.Ativo);

    DataModule1.FDQuery1.ExecSQL;
  end;

 procedure TProdutosDAO.Atualizar(AProduto: TProduto);
  begin
    DataModule1.FDQuery1.Close;
    DataModule1.FDQuery1.SQL.Clear;

    DataModule1.FDQuery1.SQL.Add(
      'UPDATE PRODUTOS ' +
      'SET NOME = :NOME, ' +
      'PRECO = :PRECO, ' +
      'QUANTIDADE = :QUANTIDADE, ' +
      'ATIVO = :ATIVO ' +
      'WHERE ID = :ID');

    DataModule1.FDQuery1.ParamByName('ID').AsInteger := AProduto.Id;
    DataModule1.FDQuery1.ParamByName('NOME').AsString := AProduto.Nome;
    DataModule1.FDQuery1.ParamByName('PRECO').AsFloat := AProduto.Preco;
    DataModule1.FDQuery1.ParamByName('QUANTIDADE').AsInteger := AProduto.Quantidade;
    DataModule1.FDQuery1.ParamByName('ATIVO').AsInteger := Ord(AProduto.Ativo);

    DataModule1.FDQuery1.ExecSQL;
  end;

 procedure TProdutosDAO.Remover(AId: Integer);
  begin
    DataModule1.FDQuery1.Close;
    DataModule1.FDQuery1.SQL.Clear;

    DataModule1.FDQuery1.SQL.Add(
      'DELETE FROM PRODUTOS WHERE ID = :ID');

    DataModule1.FDQuery1.ParamByName('ID').AsInteger := AId;

    DataModule1.FDQuery1.ExecSQL;
  end;

 function TProdutosDAO.Listar: TFDQuery;
  begin
    DataModule1.FDQuery1.Close;
    DataModule1.FDQuery1.SQL.Clear;

    DataModule1.FDQuery1.SQL.Add(
      'SELECT * FROM PRODUTOS ORDER BY ID');

    DataModule1.FDQuery1.Open;

    Result := DataModule1.FDQuery1;
  end;

end.
