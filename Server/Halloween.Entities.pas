unit Halloween.Entities;

interface

uses
  System.DateUtils, System.Generics.Collections,
  Aurelius.Mapping.Attributes,
  Aurelius.Id.Guid,
  Aurelius.Types.Blob,
  Aurelius.Types.Proxy;

type
  TDBVote = class;

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
    [ManyValuedAssociation([TAssociationProp.Lazy], CascadeTypeAllRemoveOrphan, 'FEntry')]
    FVotes: Proxy<TList<TDBVote>>;
    function GetVotes: TList<TDBVote>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: string read FId write FId;
    property CreatedOn: TDateTime read FCreatedOn write FCreatedOn;
    property Name: string read FName write FName;
    property Company: string read FCompany write FCompany;
    property Email: string read FEmail write FEmail;
    property Description: string read FDescription write FDescription;
    property Country: string read FCountry write FCountry;
    property Language: string read FLanguage write FLanguage;
    property LanguageInspiration: string read FLanguageInspiration write FLanguageInspiration;
    property Votes: TList<TDBVote> read GetVotes;
  end;

  [Entity, Automapping]
  [Table('Votes')]
  [UniqueKey('ENTRY_ID,IP_ADDRESS')]
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
  FVotes.SetInitialValue(TList<TDBVote>.Create);
  FCreatedOn := TDateTime.NowUTC;
end;

destructor TDBEntry.Destroy;
begin
  FVotes.DestroyValue;
  inherited;
end;

function TDBEntry.GetVotes: TList<TDBVote>;
begin
  Result := FVotes.Value;
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
