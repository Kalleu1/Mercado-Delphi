unit dmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, Vcl.Dialogs,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  try
    FDConnection1.Params.Database :=
      'D:\Minha Pasta(Kalleu)\Kalleu\Codigos\Delphi\Mercado Delphi\Banco\Produtos.fdb';

    FDConnection1.Connected := True;

    FDQuery1.SQL.Text := 'SELECT * FROM PRODUTOS';
    FDQuery1.Open;

    ShowMessage('Quantidade de registros: ' +
      IntToStr(FDQuery1.RecordCount));

  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

end;

end.
