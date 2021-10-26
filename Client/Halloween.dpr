{***************************************************************************}
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright ©  2021                                              }
{            Email : info@tmssoftware.com                                   }
{            Web : https://www.tmssoftware.com                              }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

program halloween;
{$R *.dres}
uses
  Vcl.Forms,
  Web,
  WEBLib.Forms,
  WEBLib.WebTools,
  SubmitPictureForm in 'SubmitPictureForm.pas' {FrmSubmit: TWebForm} {*.html},
  Overview in 'Overview.pas' {FrmOverview: TWebForm} {*.html},
  Admin in 'Admin.pas' {FrmAdmin: TWebForm} {*.html},
  Common in 'Common.pas',
  Details in 'Details.pas' {FrmEntry: TWebForm} {*.html},
  About in 'About.pas' {FrmAbout: TWebForm} {*.html};

{$R *.res}
var
  s: string;
begin
  Application.Initialize;
  Application.ErrorType := aeSilent;
  Application.MainFormOnTaskbar := True;
  s := Window.LocationString;
  if HasQueryParam('results',s) then
    Application.CreateForm(TFrmOverview, FrmOverview)
  else if HasQueryParam('admin',s) then
    Application.CreateForm(TFrmAdmin, FrmAdmin)
  else if HasQueryParam('id',s) then
    Application.CreateForm(TFrmEntry, FrmEntry)
  else
    Application.CreateForm(TFrmSubmit, FrmSubmit);
  Application.Run;
end.