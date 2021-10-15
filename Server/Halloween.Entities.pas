unit Halloween.Entities;

interface

uses
  System.DateUtils,
  Aurelius.Mapping.Attributes,
  Aurelius.Id.Guid,
  Aurelius.Types.Blob,
  Aurelius.Types.Proxy;

type
  [Entity, Automapping]
  [Table('Entries')]
  [Id('FId', TSmartGuid32LowerGenerator)]
  TDBEntry = class
  strict private
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

  [Entity, Automapping]
  [Table('Votes')]
  [UniqueKey('IP_ADDRESS')]
  TDBVote = class
  private
    FId: Integer;
    FIpAddress: string;
    [Association([TAssociationProp.Lazy], CascadeTypeAllButRemove - [TCascadeType.Flush])]
    FEntry: Proxy<TDBEntry>;
    function GetEntry: TDBEntry;
    procedure SetEntry(const Value: TDBEntry);
  public
    property Id: Integer read FId write FId;
    property IpAddress: string read FIpAddress write FIpAddress;
    property Entry: TDBEntry read GetEntry write SetEntry;
  end;

implementation

{ TDBEntry }

constructor TDBEntry.Create;
begin
  inherited Create;
  FCreatedOn := TDateTime.NowUTC;
end;

{ TDBVote }

function TDBVote.GetEntry: TDBEntry;
begin
  Result := FEntry.Value;
end;

procedure TDBVote.SetEntry(const Value: TDBEntry);
begin
  FEntry.Value := Value;
end;

end.
