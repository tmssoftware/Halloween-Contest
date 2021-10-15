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
  public
    function AddEntry(Entry: TEntryData): string;
    function GetEntries(Per_Page: Integer = 0; Page: Integer = 0): TStream;
  end;

implementation

uses
  Bcl.Json,
  System.IOUtils,
  Aurelius.Linq,
  Halloween.Utils,
  Halloween.Entities;

{ THalloweenService }

function THalloweenService.GetEntries(Per_Page: Integer = 0; Page: Integer = 0): TStream;
var
  Entries: TObjectList<TEntryResult>;
begin
  Entries := TObjectList<TEntryResult>.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Entries);
  TXDataOperationContext.Current.Response.ContentType := 'application/json; charset=utf-8';

  if Per_Page <= 0 then
    Per_Page := 50;
  if Page < 0 then
    Page := 0;

  for var DBEntry in Manager.Find<TDBEntry>
    .Take(Per_Page).Skip(Page * Per_Page)
    .OrderBy('CreatedOn')
    .Open do
  begin
    var EntryResult := TEntryResult.Create;
    Entries.Add(EntryResult);
    EntryResult.Id := DBEntry.Id;
    EntryResult.Name := DBEntry.Name;
    EntryResult.Description := DBEntry.Description;
    EntryResult.Image := ImageUrl(DBEntry.Id);
    EntryResult.Votes := Random(5);
  end;
  Result := TStringStream.Create(TJson.Serialize(Entries), TEncoding.UTF8);
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
