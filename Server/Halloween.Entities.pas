unit Halloween.Entities;

interface

uses
  System.DateUtils,
  Aurelius.Mapping.Attributes,
  Aurelius.Id.Guid,
  Aurelius.Types.Blob;

type
  [Entity, Automapping]
  [Table('Entries')]
  [Id('FId', TSmartGuid32LowerGenerator)]
  TDBEntry = class
  private
    FId: string;
    [Column('CREATED_ON', [TColumnProp.Required, TColumnProp.NoUpdate])]
    FCreatedOn: TDateTime;
    FName: string;
    FCompany: string;
    FEmail: string;
    FDescription: string;
    FCountry: string;
    FLanguage: string;
    FLanguageInspiration: string;
  public
    constructor Create;
    property Id: string read FId write FId;
    property CreatedOn: TDateTime read FCreatedOn write FCreatedOn;
    property Name: string read FName write FName;
    property Company: string read FCompany write FCompany;
    property Email: string read FEmail write FEmail;
    property Description: string read FDescription write FDescription;
    property Country: string read FCountry write FCountry;
    property Language: string read FLanguage write FLanguage;
    property LanguageInspiration: string read FLanguageInspiration write FLanguageInspiration;
  end;

implementation

{ TDBEntry }

constructor TDBEntry.Create;
begin
  inherited Create;
  FCreatedOn := TDateTime.NowUTC;
end;

end.
