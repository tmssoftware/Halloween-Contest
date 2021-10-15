unit Halloween.Service.Impl;

interface

uses
  System.Generics.Collections, System.Classes, System.SysUtils,
  XData.Server.Module,
  XData.Service.Common,
  Aurelius.Engine.ObjectManager,
  Halloween.Service;

type
  [ServiceImplementation]
  THalloweenService = class(TInterfacedObject, IHalloweenService)
  strict protected
    function Manager: TObjectManager;
    function Context: TXDataOperationContext;
  public
    function AddEntry(Entry: TEntryData): string;
    function GetEntries(Per_Page: Integer = 0; Page: Integer = 0): TStream;
    function GetPicture(Pic: string): TStream;
    procedure AddVote(Entry: string);
  end;

implementation

uses
  System.IOUtils,
  Bcl.Json,
  Aurelius.Linq,
  XData.Sys.Exceptions,
  Halloween.Utils,
  Halloween.Entities;

{ THalloweenService }

procedure THalloweenService.AddVote(Entry: string);
var
  DBEntry: TDBEntry;
  IPAddress: string;
  DBVote: TDBVote;
begin
  DBEntry := Manager.Find<TDBEntry>(Entry);
  if DBEntry = nil then
    raise EXDataHttpException.CreateFmt(400, 'Entry "%s" does not exist', [Entry]);

  IPAddress := Context.Request.RemoteIp;
  DBVote := Manager.Find<TDBVote>.Where(Linq['IPAddress'] = IPAddress).UniqueResult;
  if DBVote <> nil then
    raise EXDataHttpException.Create(400, 'You have already voted');

  DBVote := TDBVote.Create;
  Manager.AddOwnership(DBVote);
  DBVote.Entry := DBEntry;
  DBVote.IPAddress := IPAddress;
  Manager.Save(DBVote);
end;

function THalloweenService.Context: TXDataOperationContext;
begin
  Result := TXDataOperationContext.Current;
end;

function THalloweenService.GetEntries(Per_Page: Integer = 0; Page: Integer = 0): TStream;
var
  Entries: TObjectList<TEntryResult>;
  DBEntries: TList<TCriteriaResult>;
begin
  Entries := TObjectList<TEntryResult>.Create;
  Context.Handler.ManagedObjects.Add(Entries);
  Context.Response.ContentType := 'application/json; charset=utf-8';

  if Per_Page <= 0 then
    Per_Page := 50;
  if Page < 0 then
    Page := 0;

  DBEntries := Manager.Find<TDBEntry>
    .Select(TProjections.ProjectionList
      .Add(Linq['Id'].Group.As_('Id'))
      .Add(Linq['Name'].As_('Name'))
      .Add(Linq['Description'].As_('Description'))
      .Add(Linq['Votes.Id'].Count.As_('Votes'))
    )
    .Take(Per_Page).Skip(Page * Per_Page)
    .OrderBy('Votes', False)
    .ListValues;
  try
    for var DBEntry in DBEntries do
    begin
      var EntryResult := TEntryResult.Create;
      Entries.Add(EntryResult);
      EntryResult.Id := DBEntry['Id'];
      EntryResult.Name := DBEntry['Name'];
      EntryResult.Description := DBEntry['Description'];
      EntryResult.Image := ImageUrl(DBEntry['Id']);
      EntryResult.Votes := DBEntry['Votes'];
    end;
  finally
    DBEntries.Free;
  end;
  Result := TStringStream.Create(TJson.Serialize(Entries), TEncoding.UTF8);
end;

function THalloweenService.GetPicture(Pic: string): TStream;
var
  FileName: string;
begin
  FileName := ImageFile(Pic);
  if not TFile.Exists(FileName) then
    raise EXDataHttpException.Create(404, 'Image ' + Pic + ' not found');

  Context.Response.ContentType := 'image/jpeg';
  Result := TFileStream.Create(FileName, fmOpenRead + fmShareDenyNone);
end;

function THalloweenService.Manager: TObjectManager;
begin
  Result := TXDataOperationContext.Current.GetManager;
end;

{ THalloweenService }

function THalloweenService.AddEntry(Entry: TEntryData): string;
var
  DBEntry: TDBEntry;
begin
  DBEntry := TDBEntry.Create;
  Manager.AddOwnership(DBEntry);
  DBEntry.Name := Entry.Name;
  DBEntry.Company := Entry.Company;
  DBEntry.Email := Entry.Email;
  DBEntry.Description := Entry.Description;
  DBEntry.Country := Entry.Country;
  DBEntry.Language := Entry.Language;
  DBEntry.LanguageInspiration := Entry.LanguageInspiration;
  Manager.Save(DBEntry);
  TFile.WriteAllBytes(ImageFile(DBEntry.Id), Entry.Image);
  Result := DBEntry.Id;
end;

initialization
  RegisterServiceType(THalloweenService);

end.
