object FrmProduto: TFrmProduto
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object lblNome: TLabel
    Left = 32
    Top = 16
    Width = 33
    Height = 15
    Caption = 'Nome'
  end
  object lblPreco: TLabel
    Left = 32
    Top = 66
    Width = 30
    Height = 15
    Caption = 'Pre'#231'o'
  end
  object lblQuantidade: TLabel
    Left = 32
    Top = 116
    Width = 62
    Height = 15
    Caption = 'Quantidade'
  end
  object edtNome: TEdit
    Left = 32
    Top = 37
    Width = 121
    Height = 23
    TabOrder = 0
  end
  object edtPreco: TEdit
    Left = 32
    Top = 87
    Width = 53
    Height = 23
    TabOrder = 1
  end
  object edtQuantidade: TEdit
    Left = 32
    Top = 137
    Width = 53
    Height = 23
    TabOrder = 2
  end
  object btnCadastrar: TButton
    Left = 224
    Top = 36
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 3
    OnClick = btnCadastrarClick
  end
  object btnEditar: TButton
    Left = 224
    Top = 135
    Width = 75
    Height = 25
    Caption = 'Editar'
    TabOrder = 4
    OnClick = btnEditarClick
  end
  object btnExcluir: TButton
    Left = 224
    Top = 86
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 5
    OnClick = btnExcluirClick
  end
  object dbgProdutos: TDBGrid
    Left = 32
    Top = 192
    Width = 553
    Height = 185
    DataSource = DataModule1.DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = dbgProdutosCellClick
  end
end
