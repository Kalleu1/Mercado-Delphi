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
var
  Query: TFDQuery;
begin

  Query := TFDQuery.Create(nil);

  try

    Query.Connection := DataModule1.FDConnection1;

    Query.SQL.Text :=
      'INSERT INTO PRODUTOS ' +
      '(NOME, PRECO, QUANTIDADE, ATIVO) ' +
      'VALUES ' +
      '(:NOME, :PRECO, :QUANTIDADE, :ATIVO)';


    Query.ParamByName('NOME').AsString :=
      AProduto.Nome;

    Query.ParamByName('PRECO').AsFloat :=
      AProduto.Preco;

    Query.ParamByName('QUANTIDADE').AsInteger :=
      AProduto.Quantidade;

    Query.ParamByName('ATIVO').AsInteger :=
      Ord(AProduto.Ativo);


    Query.ExecSQL;


  finally

    Query.Free;

  end;

end;



procedure TProdutosDAO.Atualizar(AProduto: TProduto);
var
  Query: TFDQuery;
begin

  Query := TFDQuery.Create(nil);

  try

    Query.Connection := DataModule1.FDConnection1;


    Query.SQL.Text :=
      'UPDATE PRODUTOS SET ' +
      'NOME = :NOME, ' +
      'PRECO = :PRECO, ' +
      'QUANTIDADE = :QUANTIDADE, ' +
      'ATIVO = :ATIVO ' +
      'WHERE ID = :ID';


    Query.ParamByName('ID').AsInteger :=
      AProduto.Id;

    Query.ParamByName('NOME').AsString :=
      AProduto.Nome;

    Query.ParamByName('PRECO').AsFloat :=
      AProduto.Preco;

    Query.ParamByName('QUANTIDADE').AsInteger :=
      AProduto.Quantidade;

    Query.ParamByName('ATIVO').AsInteger :=
      Ord(AProduto.Ativo);


    Query.ExecSQL;


  finally

    Query.Free;

  end;

end;



procedure TProdutosDAO.Remover(AId: Integer);
var
  Query: TFDQuery;
begin

  Query := TFDQuery.Create(nil);

  try

    Query.Connection :=
      DataModule1.FDConnection1;


    Query.SQL.Text :=
      'DELETE FROM PRODUTOS ' +
      'WHERE ID = :ID';


    Query.ParamByName('ID').AsInteger :=
      AId;


    Query.ExecSQL;


  finally

    Query.Free;

  end;

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
