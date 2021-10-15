program HalloweenServer;

uses
  Sparkle.App,
  VCL.Forms,
  Modules.Server in 'Modules.Server.pas' {HalloweenServerModule: TDataModule},
  Halloween.Service in 'Halloween.Service.pas',
  Halloween.Service.Impl in 'Halloween.Service.Impl.pas',
  Halloween.Entities in 'Halloween.Entities.pas',
  Halloween.Utils in 'Halloween.Utils.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THalloweenServerModule, HalloweenServerModule);
  Application.Run;
end.
