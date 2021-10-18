unit Halloween.Service;

interface

uses
  System.Generics.Collections, System.Classes,
  Bcl.Json.Attributes,
  Bcl.Json.NamingStrategies,
  XData.Query,
  XData.Security.Attributes,
  XData.Service.Common;

type
  TEntryData = class
  private
    FName: string;
    FCompany: string;
    FEmail: string;
    FDescription: string;
    FCountry: string;
    FLanguage: string;
    FLanguageInspiration: string;
    FImage: TArray<Byte>;
  public
    property Name: string read FName write FName;
    property Company: string read FCompany write FCompany;
    property Email: string read FEmail write FEmail;
    property Description: string read FDescription write FDescription;
    property Country: string read FCountry write FCountry;
    property Language: string read FLanguage write FLanguage;
    property LanguageInspiration: string read FLanguageInspiration write FLanguageInspiration;
    property Image: TArray<Byte> read FImage write FImage;
  end;

  TEntriesQuery = class
  private
    FOrderBy: string;
    FPer_Page: Integer;
    FPage: Integer;
    FDesc: Boolean;
  public
    property Per_Page: Integer read FPer_Page write FPer_Page;
    property Page: Integer read FPage write FPage;
    property OrderBy: string read FOrderBy write FOrderBy;
    property Desc: Boolean read FDesc write FDesc;
  end;

  [JsonNamingStrategy(TCamelCaseNamingStrategy)]
  TEntryResult = class
  private
    FId: string;
    FName: string;
    FDescription: string;
    FImage: string;
    FVotes: Integer;
    FVoted: Boolean;
  public
    property Id: string read FId write Fid;
    property Name: string read FName write FName;
    property Description: string read FDescription write FDescription;
    property Image: string read FImage write FImage;
    property Votes: Integer read FVotes write FVotes;
    property Voted: Boolean read FVoted write FVoted;
  end;

  TEntryInfo = class(TEntryResult)
  private
    FCompany: string;
    FEmail: string;
    FCountry: string;
    FLanguage: string;
    FLanguageInspiration: string;
  public
    property Company: string read FCompany write FCompany;
    property Email: string read FEmail write FEmail;
    property Country: string read FCountry write FCountry;
    property Language: string read FLanguage write FLanguage;
    property LanguageInspiration: string read FLanguageInspiration write FLanguageInspiration;
  end;

  [ServiceContract]
  [Route('')]
  IHalloweenService = interface(IInvokable)
    ['{92B65735-3D8D-4C9B-A5F7-BB54F018C4E8}']
    function AddEntry(Entry: TEntryData): string;

    [HttpGet] function GetEntries(Query: TEntriesQuery): TStream;

    [HttpGet, Route('entries/{EntryId}')]
    function GetEntry(EntryId: string): TEntryResult;

    [HttpGet] function GetPicture(const Pic: string): TStream;

    procedure AddVote([FromQuery] const Entry: string);

    [Route('entries/{EntryId}/togglevote')]
    function ToggleVote(EntryId: string): TEntryResult;

    [AuthorizeScopes('admin')]
    [HttpDelete] procedure DeleteEntry([FromQuery] const Entry: string);
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IHalloweenService));

end.
