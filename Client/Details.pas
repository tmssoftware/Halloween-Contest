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

unit Details;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.JSON, WEBLib.WebTools, WEBLib.Forms, WEBLib.Dialogs, WEBLib.GoogleChart,
  WEBLib.Menus, WEBLib.ExtCtrls, WEBLib.StdCtrls, WEBLib.WebCtrls, WEBLib.REST,
  Common, Vcl.Controls, Vcl.StdCtrls;

type
  TFrmEntry = class(TWebForm)
    WebImageControl1: TWebImageControl;
    NameLabel: TWebLabel;
    WebImageControl2: TWebImageControl;
    WebShare1: TWebShare;
    ShareEntryButton: TWebButton;
    DescriptionLabel: TWebLabel;
    NavSubmissionsButton: TWebButton;
    VotesLabel: TWebLabel;
    NavAboutButton: TWebButton;
    NavSubmission2Button: TWebButton;
    FromSubmitLabel: TWebLabel;
    TitleLabel: TWebLabel;
    procedure NavSubmissionsButtonClick(Sender: TObject);
    procedure Form4Create(Sender: TOBject);
    procedure WebImageControl2Click(Sender: TObject);
    procedure ShareEntryButtonClick(Sender: TObject);
    procedure NavAboutButtonClick(Sender: TObject);
  private
    [async]
    procedure LoadDetails;
    [async]
    procedure SetLike(id: string);
  public
  end;

var
  FrmEntry: TFrmEntry;

implementation

{$R *.dfm}

uses
  Overview, About;

procedure TFrmEntry.NavAboutButtonClick(Sender: TObject);
begin
  FormNavigateFrom := fnDetail;
  Application.CreateForm(TFrmAbout, FrmAbout);
end;

procedure TFrmEntry.ShareEntryButtonClick(Sender: TObject);
var
  link: string;
begin
  link := window.location.protocol + '//' + window.location.host + window.location.pathname + '?id=' + SubmitID;
  WebShare1.Share('RADoween','test', link);
end;

procedure TFrmEntry.WebImageControl2Click(Sender: TObject);
begin
  SetLike(SubmitId);
end;

procedure TFrmEntry.NavSubmissionsButtonClick(Sender: TObject);
begin
  Application.CreateForm(TFrmOverview, FrmOverview);
end;

procedure TFrmEntry.Form4Create(Sender: TOBject);
begin
  if (FromSubmit = false) then
    SubmitId := GetQueryParam('id')
  else
  begin
    FromSubmitLabel.Caption := 'Submission Succesfull!';
    FromSubmitLabel.Visible := true;
  end;

  LoadDetails;  
end;


procedure TFrmEntry.LoadDetails;
var
  ARequest: TWebHttpRequest;
  AResponse: TJSXMLHttpRequest;
  O: TJSONObject;
  JSON: TJSON;
begin
  ARequest := TWebHttpRequest.Create(Self);
  ARequest.Command := httpGET;
  ARequest.URL := BASEURL + 'entries/' + SubmitId;
  AResponse := await(TJSXMLHttpRequest, ARequest.Perform);

  if AResponse.status = 200 then
  begin
    JSON := TJSON.Create;
    try
      O := JSON.Parse(AResponse.ResponseText);
      DescriptionLabel.Caption := O.GetJSONValue('description');
      NameLabel.Caption :='-' + O.GetJSONValue('name');
      TitleLabel.Caption := O.GetJSONValue('language');
      VotesLabel.Caption := O.GetJSONValue('votes');
      WebImageControl1.URL := BASEURL + 'getPicture?pic=' + O.GetJSONValue('image');

      if StrToBool(O.GetJSONValue('voted')) then
        WebImageControl2.URL := 'img/pumpkin-smile.svg'
      else
        WebImageControl2.URL := 'img/pumpkin.svg';
    finally
      O.Free;
    end;
  end;
end;

procedure TFrmEntry.SetLike(id: string);
var
  ARequest: TWebHttpRequest;
  AResponse: TJSXMLHttpRequest;
  O: TJSONObject;
  JSON : TJSON;
begin
  ARequest := TWebHTTPRequest.Create(Self);
  ARequest.URL := BASEURL + '/entries/' + id + '/togglevote';
  ARequest.Command := httpPOST;
  AResponse := await(TJSXMLHttpRequest, ARequest.Perform);

  if AResponse.Status = 200 then
  begin
    JSON := TJSON.Create;
    try
      O := JSON.Parse(AResponse.ResponseText);

      if StrTobool(O.GetJSONValue('voted')) then
      begin
        WebImageControl2.URL := 'img/pumpkin-smile.svg';
      end
      else
      begin
        WebImageControl2.URL := 'img/pumpkin.svg';
      end;

      VotesLabel.Caption := O.GetJSONValue('votes');
    finally
      JSON.Free;
    end;
  end;
end;

end.    