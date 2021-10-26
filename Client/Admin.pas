{***************************************************************************}
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright (c)  2021                                            }
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

unit Admin;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.StdCtrls, WEBLib.Forms, WEBLib.Dialogs, WEBLib.ContinuousScroll, Common,
  WEBLib.JSON, WEBLib.ExtCtrls, WEBLib.Login, WEBLib.Storage, Vcl.StdCtrls,
  Vcl.Controls;

type
  TFrmAdmin = class(TWebForm)
    WebContinuousScroll1: TWebContinuousScroll;
    WebPanel1: TWebPanel;
    Username: TWebEdit;
    Password: TWebEdit;
    procedure Form3Create(Sender: TObject);
    procedure WebContinuousScroll1GetListItem(Sender: TObject; AElementControl: TControl; AObject: TJSONObject; AIndex: Integer; AElement: TJSHTMLElementRecord);
    procedure WebContinuousScroll1FetchNextPage(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
    procedure UsernameExit(Sender: TObject);
    procedure PasswordExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    [async]
    procedure DelClick(Sender: TObject);
    [async]
    procedure DeleteItem(id: string; el: TJSElement);
  end;

var
  FrmAdmin: TFrmAdmin;

implementation

uses
  WEBLib.REST, WEBLib.Utils;

{$R *.dfm}

procedure TFrmAdmin.PasswordExit(Sender: TObject);
begin
  TWebLocalStorage.SetValue('password', Password.Text);
end;

procedure TFrmAdmin.UsernameExit(Sender: TObject);
begin
  TWebLocalStorage.SetValue('username', Username.Text);
end;

procedure TFrmAdmin.WebContinuousScroll1FetchNextPage(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
begin  
  AURL := BASEURL + 'getentries?page=' + APageNumber.ToString + '&per_page=' + APageSize.ToString;
end;

procedure TFrmAdmin.WebContinuousScroll1GetListItem(Sender: TObject; AElementControl: TControl; AObject: TJSONObject; AIndex: Integer; AElement: TJSHTMLElementRecord);
var
  img : TWebImageControl;
begin
  img := TWebImageControl.Create(AElementControl);
  img.Parent := AElementControl;
  img.ElementID := 'Post' + AObject.GetJSONValue('id');
  img.onClick := DelClick;
  img.URL := 'img/trash.png';  
end;

procedure TFrmAdmin.Form3Create(Sender: TObject);
begin
  WebContinuousScroll1.ItemTemplate := '<div style="border:  1px solid rgba(var(--b6a,219,219,219),1); margin:5px"> <div style="padding: 10px; display: flex;align-items: center;justify-content: center;">   '+
       '<img src="'+ BASEURL+ 'getpicture?pic=(%image%)" style="height: 350px;"> </div> <div style="display: flex;flex-direction: row;justify-content: space-between;">   '+
       '<p style="font-size:12pt; padding: 10px; margin: 0px"><img style="width: 50px;" id="Post(%id%)"></p> '+
       '<p id="fav_count(%message_number%)"     style="text-align: left;padding: 0px 10px 10px 5px; margin: 0px; display: inline-block;"> (%name%)</p>  </div> '+
       ' <p style="text-overflow: ellipsis; padding: 10px; margin: 0px;"><b>Description:</b><br> (%description%)</p> </div>'; 

  Username.Text := TWebLocalStorage.GetValue('username');
  Password.Text := TWebLocalStorage.GetValue('password');  
end;

procedure TFrmAdmin.DelClick(Sender: TObject);
var
  id: string;
  el: TJSElement;
begin
  id := (Sender as TWebImageControl).ElementID;
  Delete(id,1,4);
  el := (Sender as TWebImageControl).ElementHandle;
  //              P           -> DIV       -> DIV     -> CHILD
  el := el.parentElement.parentElement.parentElement.parentElement;
  DeleteItem(id,el);
end;
procedure TFrmAdmin.DeleteItem(id: string; el: TJSElement);
var
  ARequest: TWebHttpRequest;
  AResponse: TJSXMLHttpRequest;
begin
  ARequest := TWebHTTPRequest.Create(Self);
  ARequest.URL := BASEURL +  'DeleteEntry?Entry=' + id;
  ARequest.Command := httpDELETE;
  
  ARequest.User := Username.Text.Trim;
  ARequest.Password := Password.Text.Trim;
  AResponse := await(TJSXMLHttpRequest, ARequest.Perform);

  if AResponse.Status = 204 then
  begin
    // remove HTML element from list
    el.parentElement.removeChild(el);
    ShowMessage('Item deleted');
  end; 
end;

end.            