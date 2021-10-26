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

unit About;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.Menus, WEBLib.StdCtrls, Vcl.Controls,
  Vcl.StdCtrls, common;

type
  TFrmAbout = class(TWebForm)
    CloseButton1: TWebButton;
    CloseButton2: TWebButton;
    procedure CloseButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAbout: TFrmAbout;

implementation

uses
  Details, Overview, SubmitPictureForm;

{$R *.dfm}

procedure TFrmAbout.CloseButton1Click(Sender: TObject);
begin
  case FormNavigateFrom of
    fnSubmit: Application.CreateForm(TFrmSubmit, FrmSubmit);
    fnOverview: APplication.CreateForm(TFrmOverview, FrmOverview);
    fnDetail: Application.CreateForm(TFrmEntry, FrmEntry);
  end;
end;

end.