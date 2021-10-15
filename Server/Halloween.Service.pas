unit Halloween.Service;

interface

uses
  System.Generics.Collections,
  Bcl.Json.Attributes,
  Bcl.Json.NamingStrategies,
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

  [JsonNamingStrategy(TCamelCaseNamingStrategy)]
  TEntryResult = class
  private
    FId: string;
    FName: string;
    FDescription: string;
    FImage: string;
    FVotes: Integer;
  public
    property Id: string read FId write Fid;
    property Name: string read FName write FName;
    property Description: string read FDescription write FDescription;
    property Image: string read FImage write FImage;
    property Votes: Integer read FVotes write FVotes;
  end;

  [ServiceContract]
  [Route('')]
  IHalloweenService = interface(IInvokable)
    ['{92B65735-3D8D-4C9B-A5F7-BB54F018C4E8}']
    function AddEntry(Entry: TEntryData): string;

    [HttpGet] function GetEntries([XDefault(0)] Per_Page: Integer = 0;
      [XDefault(0)] Page: Integer = 0): TStream;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IHalloweenService));

end.
