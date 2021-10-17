unit Halloween.Service.Impl;

interface

uses
  System.Generics.Collections, System.Classes, System.SysUtils,
  Aurelius.Engine.ObjectManager,
  XData.Query,
  XData.Server.Module,
  XData.Service.Common,
  Halloween.Service;

const
  MaximumImageSize = 1024 * 1024; // 1 MB

type
  [ServiceImplementation]
  THalloweenService = class(TInterfacedObject, IHalloweenService)
  strict protected
    function Manager: TObjectManager;
    function Context: TXDataOperationContext;
  public
    function AddEntry(Entry: TEntryData): string;
    function GetEntries(Query: TEntriesQuery): TStream;
    function GetPicture(const Pic: string): TStream;
    procedure AddVote(const Entry: string);
    function ToggleVote(EntryId: string): Boolean;
    procedure DeleteEntry(const Entry: string);
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

procedure THalloweenService.AddVote(const Entry: string);
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

procedure THalloweenService.DeleteEntry(const Entry: string);
var
  DBEntry: TDBEntry;
begin
  DBEntry := Manager.Find<TDBEntry>(Entry);
  if DBEntry = nil then
    raise EXDataHttpException.CreateFmt(400, 'Entry "%s" does not exist', [Entry]);

  Manager.Remove(DBEntry);
end;

function THalloweenService.GetEntries(Query: TEntriesQuery): TStream;
var
  Entries: TObjectList<TEntryResult>;
  DBEntries: TList<TCriteriaResult>;
begin
  Entries := TObjectList<TEntryResult>.Create;
  Context.Handler.ManagedObjects.Add(Entries);
  Context.Response.ContentType := 'application/json; charset=utf-8';

  if Query.Per_Page <= 0 then
    Query.Per_Page := 50;
  if Query.Page < 0 then
    Query.Page := 0;
  if Query.OrderBy = '' then
  begin
    Query.OrderBy := 'CreatedOn';
    Query.Desc := True;
  end;

  DBEntries := Manager.Find<TDBEntry>
    .Select(TProjections.ProjectionList
      .Add(Linq['Id'].Group.As_('Id'))
      .Add(Linq['Name'].As_('Name'))
      .Add(Linq['Description'].As_('Description'))
      .Add(Linq['Votes.Id'].Count.As_('Votes'))
      .Add(TProjections.Sql<Boolean>(
        Format(
          'exists(select v.id from votes v where v.entry_id = {Id} and v.ip_address = ''%s'')',
        [Context.Request.RemoteIp])).As_('Voted'))
    )
    .Take(Query.Per_Page).Skip(Query.Page * Query.Per_Page)
    .OrderBy(Query.OrderBy, not Query.Desc)
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
      EntryResult.Voted := DBEntry['Voted'];
    end;
  finally
    DBEntries.Free;
  end;
  Result := TStringStream.Create(TJson.Serialize(Entries), TEncoding.UTF8);
end;

function THalloweenService.GetPicture(const Pic: string): TStream;
var
  FileName: string;
begin
  FileName := ImageFile(Pic);
  if not TFile.Exists(FileName) then
    raise EXDataHttpException.CreateFmt(404, 'Image "%s" not found', [Pic]);

  Context.Response.ContentType := 'image/jpeg';
  Result := TFileStream.Create(FileName, fmOpenRead + fmShareDenyNone);
end;

function THalloweenService.Manager: TObjectManager;
begin
  Result := TXDataOperationContext.Current.GetManager;
end;

function THalloweenService.ToggleVote(EntryId: string): Boolean;
var
  DBEntry: TDBEntry;
  IPAddress: string;
  DBVote: TDBVote;
begin
  DBEntry := Manager.Find<TDBEntry>(EntryId);
  if DBEntry = nil then
    raise EXDataHttpException.CreateFmt(404, 'Entry "%s" does not exist', [EntryId]);

  IPAddress := Context.Request.RemoteIp;
  DBVote := Manager.Find<TDBVote>.Where(
    (Linq['IPAddress'] = IPAddress) and (Linq['Entry.Id'] = EntryId)).UniqueResult;
  if DBVote = nil then
  begin
    DBVote := TDBVote.Create;
    Manager.AddOwnership(DBVote);
    DBVote.Entry := DBEntry;
    DBVote.IPAddress := IPAddress;
    Manager.Save(DBVote);
    Result := True;
  end
  else
  begin
    Manager.Remove(DBVote);
    Result := False;
  end;
end;

function THalloweenService.AddEntry(Entry: TEntryData): string;
var
  DBEntry: TDBEntry;
begin
  if Length(Entry.Image) > MaximumImageSize then
    raise EXDataHttpException.CreateFmt(400,
      'Image size cannot exceed %f MB', [MaximumImageSize / 1024 / 1024]);

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
