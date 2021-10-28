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


unit SubmitPictureForm;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, WEBLib.Menus, WEBLib.StdCtrls, WEBLib.WebCtrls,
  WEBLib.ExtCtrls, WEBLib.JSON, WEBLib.RegularExpressions,
  WEBLib.REST, Common, WEBLib.Devices, WEBLib.Buttons, Vcl.StdCtrls,
  Vcl.Controls;

type
  TFrmSubmit = class(TWebForm)
    ImagePreview: TWebImageControl;
    NameEdit: TWebEdit;
    CompanyEdit: TWebEdit;
    PictureDescription: TWebMemo;
    CountrySelect: TWebComboBox;
    EmailEdit: TWebEdit;
    NameValidation: TWebLabel;
    EmailValidation: TWebLabel;
    CountryValidation: TWebLabel;
    TitleValidation: TWebLabel;
    PictureValidation: TWebLabel;
    SubmitButton: TWebButton;
    ViewSubmissionsButton: TWebButton;
    StartCamButton: TWebButton;
    ChangeCamButton: TWebButton;
    AboutButton: TWebButton;
    WebHTMLDiv1: TWebHTMLDiv;
    WebHTMLDiv2: TWebHTMLDiv;
    WebFileUpload1: TWebFileUpload;
    WebCamera1: TWebCamera;
    CloseVideoButton: TWebButton;
    TitleEdit: TWebEdit;
    procedure WebFilePicker1GetFileAsDataURL(Sender: TObject; AFileIndex: Integer; AURL: string);
    procedure ImagePickerGetFileAsBase64(Sender: TObject; AFileIndex: Integer; ABase64: string);
    [async]
    procedure WebButton1Click(Sender: TObject);
    procedure WebBitBtn1Click(Sender: TObject);
    procedure Form1Create(Sender: TObject);
    procedure SubmitButtonClick(Sender: TObject);
    procedure WebFileUpload1DroppedFiles(Sender: TObject; AFileList: TStringList);
    procedure ChangeCamButtonClick(Sender: TObject);
    procedure AboutButtonClick(Sender: TObject);
    procedure WebCamera1CameraStreamPlay(Sender: TObject;
      ACamera: TCameraDevice);
    procedure CloseVideoButtonClick(Sender: TObject);
    procedure WebCamera1CameraDevicesInitialized(Sender: TObject);
  private
    FCamDeviceCounter: Integer;
    FBase64Image: String;
    procedure CameraDevicesInitialized(Sender: TObject);
    function CheckValidity: Boolean;
    [async]
    procedure FormSubmit;
  end;

var
  FrmSubmit: TFrmSubmit;

implementation

{$R *.dfm}

uses
  Details, About, Overview, WEBLib.Utils;

procedure TFrmSubmit.ChangeCamButtonClick(Sender: TObject);
var
  ACamDevice: TCameraDevice;
  i: Integer;
begin
  FCamDeviceCounter := FCamDeviceCounter + 1;
  i := FCamDeviceCounter mod WebCamera1.CameraDevices.Count;
  ACamDevice := WebCamera1.CameraDevices.Items[i];
  WebCamera1.Stop;
  WebCamera1.SetSelectedCameraDevice(ACamDevice);
  WebCamera1.Start;
end;

procedure TFrmSubmit.WebFileUpload1DroppedFiles(Sender: TObject; AFileList: TStringList);
begin
  if (WebFileUpload1.Files.Count > 0) then
  begin
    WebFileUpload1.Files[0].GetFileAsDataURL;
    WebFileUpload1.Files[0].GetFileAsBase64;
  end;
end;

procedure TFrmSubmit.SubmitButtonClick(Sender: TObject);
begin
  FormSubmit;
end;

procedure TFrmSubmit.AboutButtonClick(Sender: TObject);
begin
  FormNavigateFrom := fnSubmit;
  Application.CreateForm(TFrmAbout, FrmAbout);
end;

procedure TFrmSubmit.CameraDevicesInitialized(Sender: TObject);
begin
  if WebCamera1.CameraDevices.Count > 1 then
    ChangeCamButton.Visible := True;
end;

procedure TFrmSubmit.WebCamera1CameraDevicesInitialized(Sender: TObject);
begin
  if WebCamera1.CameraDevices.Count > 0 then
    StartCamButton.Visible := true
  else
    StartCamButton.visible := false;
end;

procedure TFrmSubmit.WebCamera1CameraStreamPlay(Sender: TObject;
  ACamera: TCameraDevice);
begin
  WebCamera1.OnCameraDevicesInitialized := CameraDevicesInitialized;
  WebCamera1.ReInitializeDevices;
end;

procedure TFrmSubmit.Form1Create(Sender: TObject);
begin
  WebFileUpload1.WidthStyle := ssPercent;
  WebFileUpload1.HeightStyle := ssPercent;
  WebFileUpload1.ElementPosition := epRelative;
  WebCamera1.ElementPosition := epRelative;
  FCamDeviceCounter := 0;
  WebCamera1.CameraType := ctSelected;
  TJSHTMLElement(webfileupload1.ElementHandle.childNodes[0].childNodes[0]).style.setProperty('display','none');
end;

procedure TFrmSubmit.WebBitBtn1Click(Sender: TObject);
begin
  if not WebCamera1.Visible then
  begin
    asm
      if (/Mobi|Android/i.test(navigator.userAgent)) {
        var element = document.getElementById('picture-control');
        if (element.requestFullscreen) {
          element.requestFullscreen();
        } else if (element.mozRequestFullScreen) {
          element.mozRequestFullScreen();
        } else if (element.webkitRequestFullscreen) {
          element.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
        } else if (element.msRequestFullscreen) {
          element.msRequestFullscreen();
        }
      }
    end;
    CloseVideoButton.visible := true;
    WebCamera1.Visible := true;
    WebCamera1.Start;
  end
  else
  begin
    CloseVideoButton.visible := false;
    FBase64Image := WebCamera1.SnapShotAsBase64;
    WebCamera1.Visible := false;
    ImagePreview.URL := FBase64Image;
    Delete(FBase64Image, 1, 23);
    ChangeCamButton.Visible := False;
    WebCamera1.Stop;
    asm
      if (/Mobi|Android/i.test(navigator.userAgent)) {
        if (document.exitFullscreen) {
          document.exitFullscreen();
        } else if (document.mozCancelFullScreen) {
          document.mozCancelFullScreen();
        } else if (document.webkitExitFullscreen) {
          document.webkitExitFullscreen();
        } else if (document.msExitFullscreen) {
          document.msExitFullscreen();
        }
      }
    end;
  end;
end;

procedure TFrmSubmit.WebButton1Click(Sender: TObject);
begin
  Application.CreateForm(TFrmOverview, FrmOverview);
end;

procedure TFrmSubmit.FormSubmit;
var
  O: TJSONObject;
  JSON : TJSON;
  IsValid: Boolean;
  AResponse : TJSXMLHttpRequest;
  ARequest: TWebHTTPRequest;
  AName, ADescription: String;
begin
  IsValid := CheckValidity;

  If IsValid then
  begin
    O := TJSONObject.Create;

    try
      AName := StringReplace(NameEdit.text,'<','&lt;', [rfReplaceAll]);
      AName := StringReplace(AName, '>','&gt;',[rfReplaceAll]);
      ADescription := StringReplace(PictureDescription.text,'<','&lt;', [rfReplaceAll]);
      ADescription := StringReplace(ADescription, '>','&gt;',[rfReplaceAll]);

      O.AddPair('Name',NameEdit.Text);
      O.AddPair('Company', CompanyEdit.Text);
      O.AddPair('Email', EmailEdit.Text);
      O.AddPair('Description', PictureDescription.Text);
      O.AddPair('Country', CountrySelect.Items[CountrySelect.ItemIndex]);
      O.AddPair('Language', TitleEdit.Text);

      // reduce image size client-side when larger than 1MB
      if (length(FBase64Image) > 1000000) then
      begin
        ImagePreview.ResizeImage(720,405,true);
        FBase64Image := ImagePreview.URL;
        Delete(FBase64Image, 1, 22);
      end;

      O.AddPair('Image', FBase64Image);

      ARequest := TWebHTTPRequest.Create(Self);
      ARequest.Command := httpPOST;
      ARequest.Headers.AddPair('Content-Type','application/json');
      ARequest.URL := BASEURL + 'AddEntry';
      ARequest.PostData := O.ToJSON;
      AResponse := await(TJSXMLHttpRequest, ARequest.Perform);

      if AResponse.Status = 200 then
      begin
        JSON := TJSON.Create;
        try
          O := JSON.Parse(AResponse.ResponseText);
          FromSubmit := true;
          SubmitId := O.GetJSONValue('value');
          Application.CreateForm(TFrmEntry, FrmEntry);
        finally
          JSON.Free;
        end;
      end;
    finally
      O.Free;
    end;
  end;
end;

procedure TFrmSubmit.WebFilePicker1GetFileAsDataURL(Sender: TObject; AFileIndex: Integer; AURL: string);
begin
  ImagePreview.URL := AURL;
end;

function TFrmSubmit.CheckValidity: Boolean;
begin
  Result := true;
  if NameEdit.Text.Trim = '' then
  begin
    Result := False;
    NameValidation.Caption := '* Name Required';
  end
  else
  begin
    document.getElementById('namelabelelement').innerHTML := '';
    NameValidation.Caption := '';
  end;

  if (EmailEdit.Text.Trim = '') then
  begin
    Result := False;
    EmailValidation.Caption := '* Email Required';
  end
  else if (TRegEx.isMatch(LowerCase(EmailEdit.Text), '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$') = False) then
  begin
    Result := False;
    EmailValidation.Caption := '* Please enter a valid Email';
  end
  else
  begin
    document.getElementById('emaillabelelement').innerHTML := '';
    EmailValidation.Caption := '';
  end;

  if CountrySelect.ItemIndex = 0 then
  begin
    Result := False;
    CountryValidation.Caption := '* Please select a country';
  end
  else
  begin
    document.getElementById('countrylabelelement').innerHTML := '';
    CountryValidation.Caption := '';
  end;

  if TitleEdit.Text.Trim = '' then
  begin
    Result := False;
    TitleValidation.Caption := '* Please insert a title for your submission';
  end
  else
  begin
    document.getElementById('titlevalidationlabel').innerHTML := '';
    TitleValidation.caption := '';
  end;
  
  if (WebFileUpload1.Files.Count = 0) and (FBase64Image = '') then
  begin
    Result := False;
    PictureValidation.Caption := '* Please upload or take a picture';
  end
  else
  begin
    document.getElementById('picturevalidationlabel').innerHTML := '';
    PictureValidation.Caption := '';
  end;
end;

procedure TFrmSubmit.CloseVideoButtonClick(Sender: TObject);
begin
  WebCamera1.Visible := false;
  ChangeCamButton.Visible := False;
  WebCamera1.Stop;

  asm
    if (/Mobi|Android/i.test(navigator.userAgent)) {
      if (document.exitFullscreen) {
        document.exitFullscreen();
      } else if (document.mozCancelFullScreen) {
        document.mozCancelFullScreen();
      } else if (document.webkitExitFullscreen) {
        document.webkitExitFullscreen();
      } else if (document.msExitFullscreen) {
        document.msExitFullscreen();
      }
    }
  end;

  CloseVideoButton.visible := false;
end;

procedure TFrmSubmit.ImagePickerGetFileAsBase64(Sender: TObject; AFileIndex: Integer; ABase64: string);
begin
  FBase64Image := ABase64;
end;

end.                                                                                     