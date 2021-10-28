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

unit Overview;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.ContinuousScroll, WEBLib.JSON, WEBLib.ExtCtrls, WEBLib.REST, Common, WEBLib.Menus,
  WEBLib.StdCtrls, WEBLib.Buttons, WEBLib.WebCtrls, Vcl.StdCtrls,
  Vcl.Controls;

type
  TEntrySort = (esID, esName, esVotes);

  TJSONButton = class(TWebButton)
  private
    FJSON: TJSONObject;
  public
    property JSON: TJSONObject read FJSON write FJSON;
  end;

  TFrmOverview = class(TWebForm)
    WebContinuousScroll1: TWebContinuousScroll;
    WebShare1: TWebShare;
    NavAboutButton: TWebButton;
    NavSubmitButton: TWebButton;
    SortByTimeButton: TWebButton;
    SortUpDownButton: TWebButton;
    SortByAlphaButton: TWebButton;
    SortByVotesButton: TWebButton;
    procedure FetchNextPageByVotesDesc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
    procedure FetchNextPageByNameDesc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
    procedure FetchNextPageByIDDesc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
    procedure FetchNextPageByIDAsc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
    procedure FetchNextPageByVotesAsc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
    procedure FetchNextPageByNameAsc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);

    procedure WebContinuousScroll1GetListItem(Sender: TObject; AElementControl: TControl; AObject: TJSONObject; AIndex: Integer; AElement: TJSHTMLElementRecord);
    procedure LikeClick(Sender: TObject);
    procedure Form2Create(Sender: TObject);
    procedure WebBitBtn1Click(Sender: TObject);
    procedure ShareClick(Sender: TObject);
    [async]
    procedure NavAboutButtonClick(Sender: TOBject);
    procedure SortByTimeButtonClick(Sender: TObject);
    procedure SortUpDownButtonClick(Sender: TObject);
    procedure SortByAlphaButtonClick(Sender: TObject);
    procedure SortByVotesButtonClick(Sender: TObject);
  private
    FAscend: boolean;
    FSort: TEntrySort;
    [async]
    procedure SetLike(id: string);
    procedure SortBy(ASort: TEntrySort);
    function GetEntriesURL(ASort: string; Asc: boolean; PageNumber, PageSize: integer): string;
  end;

var
  FrmOverview: TFrmOverview;

implementation

{$R *.dfm}

uses
  SubmitPictureForm, About;

procedure TFrmOverview.WebBitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmSubmit, FrmSubmit);
end;

procedure TFrmOverview.Form2Create(Sender: TObject);
var
  IsMobile : boolean;
begin
  FAscend := false;
  FSort := esID;
  IsMobile := false;

  SortByTimeButton.ElementHandle.style.setProperty('background-color','#a6430159');
  SortUpDownButton.ElementHandle.innerHTML := '<span class="material-icons" style="font-size:25px" title="Descending">expand_less</span>';
  SortUpDownButton.Hint := 'Descending';

   asm
     if (/Mobi|Android/i.test(navigator.userAgent)) {
       IsMobile = true;
     }
   end;

   if IsMobile then
   begin
      WebContinuousScroll1.ItemTemplate := '<div style="background:rgba(0,0,0,0.45);border-radius:5px;margin-bottom:5px;width:100%;" id="(%id%)Entry"> <div style="display: flex;align-items: center;justify-content: center;" >   '+
       '<img src="'+ BASEURL+ 'getpicture?pic=(%image%)" id="Like(%id%)" style="width: 100%;object-fit:contain;max-height:500px;"> </div> <div style="display: flex;flex-direction: row;justify-content: space-between;align-items:center;margin-right:5px;margin-left:5px;">   '+
       '<p style="font-size:12pt;margin: 0px"><img style="width: 50px;cursor:pointer" id="Post(%id%)" title="Vote on this entry"><b id="Vote(%id%)"> (%votes%) </b></p>   '+
       '<span id="fav_count(%message_number%)"     style="text-align: center;padding: 5px 10px 10px 5px; margin: 0px; display: inline-block;word-wrap:break-word;width:65%"><xmp style="width:100%; word-wrap:break-word; margin: 5px 0px;white-space:pre-wrap;text-align-center"> (%language%)</xmp></span>'+
       ' <button id="share(%id%)" class="btn btn-halloween"><span class="material-icons" title="Share this entry">share</span></button>' +
       '  </div> '+
       ' <span style="text-overflow: ellipsis; margin: 0px;width:100%; word-wrap:break-word;"><b style="padding: 10px;">Description:</b> <xmp style="width:100%; word-wrap:break-word;white-space:pre-wrap;padding:0px 10px ; margin: 10px 0px;">(%description%)</xmp>'
        +'<xmp style="padding:10px; font-size:15px; font-style: italic">-(%name%)</xmp></span> </div>';
   end
   else
   begin
     WebContinuousScroll1.ItemTemplate := '<div style="background:rgba(0,0,0,0.45);border-radius:5px;margin-bottom:5px;width:100%;" id="(%id%)Entry"> <div style="display: flex;align-items: center;justify-content: center;" >   '+
       '<img src="'+ BASEURL+ 'getpicture?pic=(%image%)" id="Like(%id%)" style="width: 100%;object-fit:contain;height:500px;"> </div> <div style="display: flex;flex-direction: row;justify-content: space-between;align-items:center;margin-right:5px;margin-left:5px;">   '+
       '<p style="font-size:12pt;margin: 0px"><img style="width: 50px;cursor:pointer" id="Post(%id%)" title="Vote on this entry"><b id="Vote(%id%)"> (%votes%) </b></p>   '+
       '<span id="fav_count(%message_number%)"     style="text-align: center;padding: 5px 10px 10px 5px; margin: 0px; display: inline-block;word-wrap:break-word;width:65%"><xmp style="width:100%; word-wrap:break-word; margin: 5px 0px;white-space:pre-wrap;text-align-center"> (%language%)</xmp></span>'+
       ' <button id="share(%id%)" class="btn btn-halloween"><span class="material-icons" title="Share this entry">share</span></button>' +
       '  </div> '+
      ' <span style="text-overflow: ellipsis; margin: 0px;width:100%; word-wrap:break-word;"><b style="padding: 10px;">Description:</b> <xmp style="width:100%; word-wrap:break-word;white-space:pre-wrap;padding:0px 10px ; margin: 10px 0px;">(%description%)</xmp>'
        +'<xmp style="padding:0px 10px; font-size: 15px; font-style: italic">-(%name%)</xmp></span> </div>';
   end;
end;

procedure TFrmOverview.WebContinuousScroll1GetListItem(Sender: TObject; AElementControl: TControl; AObject: TJSONObject; AIndex: Integer; AElement: TJSHTMLElementRecord);
var
  AImg, ASubmittedImg: TWebImageControl;
  AButton: TJSONButton;
begin
  AImg := TWebImageControl.create(AElementControl);
  AImg.Parent := AElementControl;
  AImg.ElementID := 'Post' + AObject.GetJSONValue('id');
  AImg.onClick := LikeClick;

  ASubmittedImg := TWebImageControl.create(AElementControl);
  ASubmittedImg.Parent := AElementControl;
  ASubmittedImg.ElementID := 'Like' + AObject.GetJSONValue('id') ;
  ASubmittedImg.onDblClick := LikeClick;

  if StrToBool(AObject.GetJSONValue('voted')) = false then
    AImg.URL := 'img/pumpkin.svg'
  else
    AImg.URL := 'img/pumpkin-smile.svg';

  AButton := TJSONButton.Create(Self);
  AButton.Parent := AElementControl;
  AButton.ElementID := 'share' + AObject.GetJSONValue('id');
  AButton.OnClick := ShareClick;
  AButton.JSON := AObject;
end;

function TFrmOverview.GetEntriesURL(ASort: string; Asc: boolean; PageNumber, PageSize: integer): string;
var
  OrdStr: string;
begin
  if Asc then
    OrdStr := 'Desc=true'
  else
    OrdStr := 'Desc=false';

  Result := BASEURL + 'getentries?OrderBy=' + ASort + '&' + OrdStr + '&page=' + PageNumber.ToString + '&per_page=' + PageSize.ToString;
end;

procedure TFrmOverview.FetchNextPageByVotesDesc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
begin
  AURL := GetEntriesURL('votes',true,APageNumber,APageSize);
end;

procedure TFrmOverview.FetchNextPageByVotesAsc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
begin
  AURL := GetEntriesURL('votes',false,APageNumber,APageSize);
end;

procedure TFrmOverview.FetchNextPageByNameDesc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
begin
  AURL := GetEntriesURL('name',true,APageNumber,APageSize);
end;

procedure TFrmOverview.FetchNextPageByNameAsc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
begin
  AURL := GetEntriesURL('name',false,APageNumber,APageSize);
end;

procedure TFrmOverview.FetchNextPageByIdAsc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
begin
  AURL := GetEntriesURL('id',false,APageNumber,APageSize);
end;

procedure TFrmOverview.FetchNextPageByIdDesc(Sender: TObject; APageSize: Integer; APageNumber: Integer; var AURL: string);
begin
  AURL := GetEntriesURL('id',true,APageNumber,APageSize);
end;

procedure TFrmOverview.LikeClick(Sender: TObject);
var
  AId: string;
begin
  AId := (Sender as TWebImageControl).ElementID;
  // cut off prefix
  Delete(AId,1,4);
  SetLike(AId);
end;

procedure TFrmOverview.SetLike(id: string);
var
  ARequest: TWebHttpRequest;
  AResponse: TJSXMLHttpRequest;
  O: TJSONObject;
  JSON : TJSON;
begin
  ARequest := TWebHTTPRequest.Create(Self);
  ARequest.URL := BASEURL +  '/entries/' + id+'/togglevote';
  ARequest.Command := httpPOST;
  AResponse := await(TJSXMLHttpRequest, Arequest.Perform);

  if AResponse.Status = 200 then
  begin
    JSON := TJSON.Create;
    try
      O := JSON.Parse(AResponse.ResponseText);

      if StrTobool(O.GetJSONValue('voted')) then
      begin
        Document.getElementById('Post' +  O.GetJSONValue('id')).setAttribute('src', 'img/pumpkin-smile.svg');
      end
      else
      begin
        Document.getElementById('Post' +  O.GetJSONValue('id')).setAttribute('src', 'img/pumpkin.svg');
      end;
      Document.getElementById('Vote' + O.GetJSONValue('id')).innerHTML := O.GetJSONValue('votes');
    finally
      O.Free;
    end;
  end;
end;

procedure TFrmOverview.ShareClick(Sender: TObject);
var
  AId, ALink: string;
  O: TJSONObject;
begin
  O := (Sender as TJSONButton).JSON;
  AId := O.GetJSONValue('id');
  ALink := window.location.protocol + '//' + window.location.host + window.location.pathname + '?id='+AId;
  WebShare1.Share('Halloween', O.GetJSONValue('description'), ALink);
end;

procedure TFrmOverview.SortBy(ASort: TEntrySort);
begin
  WebContinuousScroll1.AutoLoadFirstPage := false;
  WebContinuousScroll1.Clear;
  WebContinuousScroll1.AutoLoadFirstPage := true;
  WebContinuousScroll1.PageNumber := 0;
  WebContinuousScroll1.BeginUpdate;
  FSort := ASort;

  case ASort of
    esID:
    begin
      SortByTimeButton.ElementHandle.style.setProperty('background-color','#a6430159');
      SortByAlphaButton.ElementHandle.style.removeProperty('background-color');
      SortByVotesButton.ElementHandle.style.removeProperty('background-color');
      if FAscend then
      begin
        WebContinuousScroll1.OnFetchNextPage := FetchNextPageByIdAsc;
        SortUpDownButton.ElementHandle.innerHTML := '<span class="material-icons" style="font-size:25px" title="Ascending">expand_more</span>';
        SortUpDownButton.Hint := 'Ascending';
      end
      else
      begin
        WebContinuousScroll1.OnFetchNextPage := FetchNextPageByIdDesc;
        SortUpDownButton.ElementHandle.innerHTML := '<span class="material-icons" style="font-size:25px" title="Descending">expand_less</span>';
        SortUpDownButton.Hint := 'Descending';
      end;
    end;
    esName:
    begin
      SortByTimeButton.ElementHandle.style.removeProperty('background-color');
      SortByAlphaButton.ElementHandle.style.setProperty('background-color','#a6430159');
      SortByVotesButton.ElementHandle.style.removeProperty('background-color');
      if FAscend then
      begin
        WebContinuousScroll1.OnFetchNextPage := FetchNextPageByNameAsc;
        SortUpDownButton.ElementHandle.innerHTML := '<span class="material-icons" style="font-size:30px" title="Ascending">expand_more</span>';
        SortUpDownButton.Hint := 'Ascending';
      end
      else
      begin
        WebContinuousScroll1.OnFetchNextPage := FetchNextPageByNameDesc;
        SortUpDownButton.ElementHandle.innerHTML := '<span class="material-icons" style="font-size:25px" title="Descending">expand_less</span>';
        SortUpDownButton.Hint := 'Descending';
      end;
    end;
    esVotes:
    begin
      SortByTimeButton.ElementHandle.style.removeProperty('background-color');
      SortByAlphaButton.ElementHandle.style.removeProperty('background-color');
      SortByVotesButton.ElementHandle.style.setProperty('background-color','#a6430159');
      if FAscend then
      begin
        WebContinuousScroll1.OnFetchNextPage := FetchNextPageByVotesAsc;
        SortUpDownButton.ElementHandle.innerHTML := '<span class="material-icons" style="font-size:25px" title="Ascending">expand_more</span>';
        SortUpDownButton.Hint := 'Ascending';
      end
      else
      begin
        WebContinuousScroll1.OnFetchNextPage := FetchNextPageByVotesDesc;
        SortUpDownButton.ElementHandle.innerHTML := '<span class="material-icons" style="font-size:25px" title="Descending">expand_less</span>';
        SortUpDownButton.Hint := 'Descending';
      end;
    end;
  end;

  WebContinuousScroll1.EndUpdate;
end;

procedure TFrmOverview.SortByAlphaButtonClick(Sender: TObject);
begin
  SortBy(esName);
end;

procedure TFrmOverview.SortByVotesButtonClick(Sender: TObject);
begin
  SortBy(esVotes);
end;

procedure TFrmOverview.SortByTimeButtonClick(Sender: TObject);
begin
  SortBy(esID);
end;

procedure TFrmOverview.SortUpDownButtonClick(Sender: TObject);
begin
  // reverse sort order
  FAscend := not FAscend;
  SortBy(FSort);
end;

procedure TFrmOverview.NavAboutButtonClick(Sender: TOBject);
begin
  FormNavigateFrom := fnOverview;
  Application.CreateForm(TFrmAbout, FrmAbout);
end;

end.
