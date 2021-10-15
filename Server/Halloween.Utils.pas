unit Halloween.Utils;

interface

function ImagesFolder: string;
function ImageFile(const Id: string): string;
function DatabaseFile: string;
function ImageUrl(const Id: string): string;

implementation

uses
  System.IOUtils;

function DatabaseFile: string;
begin
  Result := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'halloween.db');
end;

function ImageFile(const Id: string): string;
begin
  Result := TPath.Combine(ImagesFolder, Id + '.img');
end;

function ImagesFolder: string;
const
  ImagesSubFolder = 'Images';
begin
  Result := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), ImagesSubFolder);
end;

function ImageUrl(const Id: string): string;
begin
//  Result := TPath.GetFileName(ImageFile(Id));
  Result := Id;
end;

end.
