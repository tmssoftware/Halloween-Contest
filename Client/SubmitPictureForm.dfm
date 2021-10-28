object FrmSubmit: TFrmSubmit
  Width = 947
  Height = 856
  Caption = 'RADoween Submit'
  ElementPosition = epRelative
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormContainer = 'body'
  ParentFont = False
  OnCreate = Form1Create
  object PictureValidation: TWebLabel
    Left = 5
    Top = 5
    Width = 3
    Height = 14
    ElementID = 'picturevalidationlabel'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object ImagePreview: TWebImageControl
    Left = 6
    Top = 36
    Width = 0
    Height = 392
    ElementID = 'detailImageContainer'
    HeightStyle = ssPercent
    WidthStyle = ssPercent
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    ElementPosition = epRelative
    URL = 'img/photo.svg'
  end
  object NameValidation: TWebLabel
    Left = 7
    Top = 294
    Width = 3
    Height = 14
    ElementID = 'namelabelelement'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object EmailValidation: TWebLabel
    Left = 8
    Top = 350
    Width = 3
    Height = 14
    ElementID = 'emaillabelelement'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object CountryValidation: TWebLabel
    Left = 8
    Top = 453
    Width = 3
    Height = 14
    ElementID = 'countrylabelelement'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object TitleValidation: TWebLabel
    Left = 8
    Top = 511
    Width = 3
    Height = 14
    ElementID = 'titlevalidationlabel'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object WebHTMLDiv1: TWebHTMLDiv
    Left = 8
    Top = 511
    Width = 865
    Height = 64
    ElementID = 'picuplaod'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    ElementPosition = epRelative
    Role = 'null'
    object WebFileUpload1: TWebFileUpload
      Left = 448
      Top = 491
      Width = 492
      Height = 56
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      Accept = '.jpg, .png, .jpeg, .gif, .bmp'
      Caption = 'Choose a file'
      Color = 892671
      DragCaption = 'or drag it here'
      DragColor = 28087
      FontHoverColor = clBlack
      OnDroppedFiles = WebFileUpload1DroppedFiles
      OnGetFileAsBase64 = ImagePickerGetFileAsBase64
      OnGetFileAsDataURL = WebFilePicker1GetFileAsDataURL
    end
  end
  object CountrySelect: TWebComboBox
    Left = 0
    Top = 0
    Width = 23
    Height = 22
    ElementID = 'countryselectelement'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'combobox'
    Text = '-- select a country --'
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
    ItemIndex = 0
    Items.Strings = (
      '-- select a country --'
      'Afghanistan'
      'Albania'
      'Algeria'
      'Andorra'
      'Angola'
      'Antigua & Deps'
      'Argentina'
      'Armenia'
      'Australia'
      'Austria'
      'Azerbaijan'
      'Bahamas'
      'Bahrain'
      'Bangladesh'
      'Barbados'
      'Belarus'
      'Belgium'
      'Belize'
      'Benin'
      'Bhutan'
      'Bolivia'
      'Bosnia Herzegovina'
      'Botswana'
      'Brazil'
      'Brunei'
      'Bulgaria'
      'Burkina'
      'Burundi'
      'Cambodia'
      'Cameroon'
      'Canada'
      'Cape Verde'
      'Central African Rep'
      'Chad'
      'Chile'
      'China'
      'Colombia'
      'Comoros'
      'Congo'
      'Congo {Democratic Rep}'
      'Costa Rica'
      'Croatia'
      'Cuba'
      'Cyprus'
      'Czech Republic'
      'Denmark'
      'Djibouti'
      'Dominica'
      'Dominican Republic'
      'East Timor'
      'Ecuador'
      'Egypt'
      'El Salvador'
      'Equatorial Guinea'
      'Eritrea'
      'Estonia'
      'Ethiopia'
      'Fiji'
      'Finland'
      'France'
      'Gabon'
      'Gambia'
      'Georgia'
      'Germany'
      'Ghana'
      'Greece'
      'Grenada'
      'Guatemala'
      'Guinea'
      'Guinea-Bissau'
      'Guyana'
      'Haiti'
      'Honduras'
      'Hungary'
      'Iceland'
      'India'
      'Indonesia'
      'Iran'
      'Iraq'
      'Ireland {Republic}'
      'Israel'
      'Italy'
      'Ivory Coast'
      'Jamaica'
      'Japan'
      'Jordan'
      'Kazakhstan'
      'Kenya'
      'Kiribati'
      'Korea North'
      'Korea South'
      'Kosovo'
      'Kuwait'
      'Kyrgyzstan'
      'Laos'
      'Latvia'
      'Lebanon'
      'Lesotho'
      'Liberia'
      'Libya'
      'Liechtenstein'
      'Lithuania'
      'Luxembourg'
      'Macedonia'
      'Madagascar'
      'Malawi'
      'Malaysia'
      'Maldives'
      'Mali'
      'Malta'
      'Marshall Islands'
      'Mauritania'
      'Mauritius'
      'Mexico'
      'Micronesia'
      'Moldova'
      'Monaco'
      'Mongolia'
      'Montenegro'
      'Morocco'
      'Mozambique'
      'Myanmar, {Burma}'
      'Namibia'
      'Nauru'
      'Nepal'
      'Netherlands'
      'New Zealand'
      'Nicaragua'
      'Niger'
      'Nigeria'
      'Norway'
      'Oman'
      'Pakistan'
      'Palau'
      'Panama'
      'Papua New Guinea'
      'Paraguay'
      'Peru'
      'Philippines'
      'Poland'
      'Portugal'
      'Qatar'
      'Romania'
      'Russian Federation'
      'Rwanda'
      'St Kitts & Nevis'
      'St Lucia'
      'Saint Vincent & the Grenadines'
      'Samoa'
      'San Marino'
      'Sao Tome & Principe'
      'Saudi Arabia'
      'Senegal'
      'Serbia'
      'Seychelles'
      'Sierra Leone'
      'Singapore'
      'Slovakia'
      'Slovenia'
      'Solomon Islands'
      'Somalia'
      'South Africa'
      'South Sudan'
      'Spain'
      'Sri Lanka'
      'Sudan'
      'Suriname'
      'Swaziland'
      'Sweden'
      'Switzerland'
      'Syria'
      'Taiwan'
      'Tajikistan'
      'Tanzania'
      'Thailand'
      'Togo'
      'Tonga'
      'Trinidad & Tobago'
      'Tunisia'
      'Turkey'
      'Turkmenistan'
      'Tuvalu'
      'Uganda'
      'Ukraine'
      'United Arab Emirates'
      'United Kingdom'
      'United States'
      'Uruguay'
      'Uzbekistan'
      'Vanuatu'
      'Vatican City'
      'Venezuela'
      'Vietnam'
      'Yemen'
      'Zambia'
      'Zimbabwe')
  end
  object StartCamButton: TWebButton
    Left = 425
    Top = 782
    Width = 104
    Height = 40
    Caption = 'StartCamButton'
    ElementID = 'startCamera'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    WidthPercent = 100.000000000000000000
    OnClick = WebBitBtn1Click
  end
  object ChangeCamButton: TWebButton
    Left = 0
    Top = 0
    Width = 101
    Height = 48
    Caption = 'ChangeCamButton'
    ElementID = 'ToggleCamera'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    Visible = False
    WidthPercent = 100.000000000000000000
    OnClick = ChangeCamButtonClick
  end
  object NameEdit: TWebEdit
    Left = 8
    Top = 314
    Width = 865
    Height = 30
    ElementID = 'nameinputelement'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    HideSelection = False
    MaxLength = 100
    ParentFont = False
    Required = True
    WidthPercent = 100.000000000000000000
  end
  object CompanyEdit: TWebEdit
    Left = 8
    Top = 423
    Width = 865
    Height = 24
    ElementID = 'companyinputelement'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    HideSelection = False
    MaxLength = 100
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object EmailEdit: TWebEdit
    Left = 8
    Top = 370
    Width = 865
    Height = 23
    ElementID = 'emailinputelement'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    HideSelection = False
    MaxLength = 200
    ParentFont = False
    Pattern = '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{ 0 }$'
    Required = True
    WidthPercent = 100.000000000000000000
  end
  object PictureDescription: TWebMemo
    Left = 8
    Top = 581
    Width = 865
    Height = 95
    AutoSize = False
    ElementID = 'descriptionelement'
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'null'
    SelLength = 0
    SelStart = 0
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
  end
  object WebHTMLDiv2: TWebHTMLDiv
    Left = 8
    Top = 263
    Width = 865
    Height = 25
    ElementID = 'cameraelement'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    ElementPosition = epRelative
    Role = 'null'
    object WebCamera1: TWebCamera
      Left = 710
      Top = 16
      Width = 68
      Height = 500
      HeightStyle = ssPercent
      WidthStyle = ssPercent
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      CameraType = ctSelected
      Visible = False
      OnCameraDevicesInitialized = WebCamera1CameraDevicesInitialized
      OnCameraStreamPlay = WebCamera1CameraStreamPlay
    end
  end
  object SubmitButton: TWebButton
    Left = 564
    Top = 783
    Width = 109
    Height = 38
    ButtonType = 'button'
    Caption = 'Submit new'
    ElementID = 'submitbutton'
    ElementFont = efCSS
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    WidthPercent = 100.000000000000000000
    OnClick = SubmitButtonClick
  end
  object ViewSubmissionsButton: TWebButton
    Left = 96
    Top = 783
    Width = 158
    Height = 38
    Caption = 'View submissions'
    ElementID = 'overviewnav'
    ElementFont = efCSS
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    WidthPercent = 100.000000000000000000
    OnClick = WebButton1Click
  end
  object AboutButton: TWebButton
    Left = 280
    Top = 789
    Width = 104
    Height = 27
    Caption = 'About'
    ElementID = 'aboutnav'
    ElementFont = efCSS
    ElementPosition = epRelative
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    WidthPercent = 100.000000000000000000
    OnClick = AboutButtonClick
  end
  object CloseVideoButton: TWebButton
    Left = 0
    Top = 54
    Width = 96
    Height = 25
    ChildOrder = 20
    ElementID = 'closeButton'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    Visible = False
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
    OnClick = CloseVideoButtonClick
  end
  object TitleEdit: TWebEdit
    Left = 456
    Top = 144
    Width = 121
    Height = 22
    ChildOrder = 19
    ElementID = 'titleinputelement'
    ElementFont = efCSS
    ElementPosition = epIgnore
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthStyle = ssAuto
    WidthPercent = 100.000000000000000000
  end
end
