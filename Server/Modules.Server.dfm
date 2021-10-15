object HalloweenServerModule: THalloweenServerModule
  OnCreate = DataModuleCreate
  Height = 201
  Width = 389
  PixelsPerInch = 96
  object XDataServer1: TXDataServer
    BaseUrl = 'http://+:2001/tms/halloween'
    Pool = XDataConnectionPool1
    EntitySetPermissions = <>
    SwaggerOptions.Enabled = True
    SwaggerUIOptions.Enabled = True
    Left = 40
    Top = 24
    object XDataServer1CORS: TSparkleCorsMiddleware
    end
  end
  object XDataConnectionPool1: TXDataConnectionPool
    Connection = AureliusConnection1
    Size = 1
    Left = 184
    Top = 24
  end
  object AureliusConnection1: TAureliusConnection
    DriverName = 'SQLite'
    Params.Strings = (
      'EnableForeignKeys=True')
    Left = 184
    Top = 96
  end
  object AureliusDBSchema1: TAureliusDBSchema
    Connection = AureliusConnection1
    Left = 40
    Top = 96
  end
end
