unit Halloween.Service.Impl;

interface

uses
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
  end;

implementation

uses
  System.IOUtils,
  Halloween.Utils,
  Halloween.Entities;


{ THalloweenService }

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
