unit Modules.Server;

interface

uses
  System.SysUtils, System.Classes, Sparkle.HttpServer.Module,
  Sparkle.HttpServer.Context, XData.Server.Module, Sparkle.Comp.Server,
  XData.Comp.Server, Aurelius.Drivers.Interfaces,
  Aurelius.Engine.DatabaseManager, Aurelius.Comp.DBSchema,
  Aurelius.Comp.Connection, XData.Comp.ConnectionPool, Aurelius.Drivers.SQLite,
  Aurelius.Sql.SQLite,
  Sparkle.Comp.CorsMiddleware, Sparkle.Comp.BasicAuthMiddleware;

type
  THalloweenServerModule = class(TDataModule)
    XDataServer1: TXDataServer;
    XDataConnectionPool1: TXDataConnectionPool;
    AureliusConnection1: TAureliusConnection;
    AureliusDBSchema1: TAureliusDBSchema;
    XDataServer1CORS: TSparkleCorsMiddleware;
    XDataServer1Basicauth: TSparkleBasicAuthMiddleware;
    procedure DataModuleCreate(Sender: TObject);
    procedure XDataServer1BasicauthAuthenticate(Sender: TObject; const UserName,
      Password: string; var User: IUserIdentity);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HalloweenServerModule: THalloweenServerModule;

implementation

uses
  Aurelius.Sql.Register,
  Halloween.Utils,
  System.IOUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure THalloweenServerModule.DataModuleCreate(Sender: TObject);
begin
  (TSQLGeneratorRegister.GetInstance.GetGenerator('SQLite')
    as TSQLiteSQLGenerator).DateType := TSQLiteSQLGenerator.TDateType.Text;
  ForceDirectories(ImagesFolder);
  AureliusConnection1.Params.Values['Database'] := DatabaseFile;
  AureliusDBSchema1.UpdateDatabase;
end;

procedure THalloweenServerModule.XDataServer1BasicauthAuthenticate(
  Sender: TObject; const UserName, Password: string; var User: IUserIdentity);
var
  AdminUserName: string;
  AdminPassword: string;
begin
  AdminUserName := GetEnvironmentVariable('HALLOWEEN_ADMIN_USER');
  AdminPassword := GetEnvironmentVariable('HALLOWEEN_ADMIN_PASSWORD');
  if (AdminUserName <> '') and (AdminPassword <> '')
    and (UserName = AdminUserName) and (Password = AdminPassword) then
  begin
    User := TUserIdentity.Create;
    User.Claims.AddOrSet('scope', 'admin')
  end;
end;

end.
