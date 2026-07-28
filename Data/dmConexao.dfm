object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=SYSDBA'
      'Password=kl33cpoj'
      'CharacterSet=UTF8'
      'DriverID=FB')
    LoginPrompt = False
    Left = 288
    Top = 224
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 408
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 416
    Top = 264
  end
end
