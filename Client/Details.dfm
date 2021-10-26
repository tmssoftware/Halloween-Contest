object FrmEntry: TFrmEntry
  Width = 779
  Height = 586
  Caption = 'RADoween Detail'
  Color = clMenuBar
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormContainer = 'body'
  ParentFont = False
  OnCreate = Form4Create
  object WebImageControl1: TWebImageControl
    Left = 20
    Top = 19
    Width = 741
    Height = 406
    ElementID = 'detailImageContainer2'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object NameLabel: TWebLabel
    Left = 20
    Top = 505
    Width = 26
    Height = 14
    Caption = 'name'
    Color = clMenuBar
    ElementID = 'namelabel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object WebImageControl2: TWebImageControl
    Left = 21
    Top = 459
    Width = 40
    Height = 40
    ElementID = 'likebutton'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = WebImageControl2Click
  end
  object DescriptionLabel: TWebLabel
    Left = 20
    Top = 543
    Width = 80
    Height = 14
    Caption = 'DescriptionLabel'
    Color = clMenuBar
    ElementID = 'descriptionDiv'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object VotesLabel: TWebLabel
    Left = 132
    Top = 483
    Width = 54
    Height = 14
    Caption = 'VotesLabel'
    Color = clMenuBar
    ElementID = 'countlabel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    WidthPercent = 100.000000000000000000
  end
  object FromSubmitLabel: TWebLabel
    Left = 336
    Top = 531
    Width = 3
    Height = 14
    Color = clMenuBar
    ElementID = 'alertlabel'
    HeightPercent = 100.000000000000000000
    Visible = False
    WidthPercent = 100.000000000000000000
  end
  object ShareEntryButton: TWebButton
    Left = 67
    Top = 457
    Width = 49
    Height = 40
    ElementID = 'sharesub'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    WidthPercent = 100.000000000000000000
    OnClick = ShareEntryButtonClick
  end
  object NavSubmissionsButton: TWebButton
    Left = 601
    Top = 511
    Width = 160
    Height = 56
    Caption = 'View submissions'
    ElementID = 'overviewnav2'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    WidthPercent = 100.000000000000000000
    OnClick = NavSubmissionsButtonClick
  end
  object NavAboutButton: TWebButton
    Left = 601
    Top = 449
    Width = 160
    Height = 56
    Caption = 'About'
    ElementID = 'aboutnav2'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    WidthPercent = 100.000000000000000000
    OnClick = NavAboutButtonClick
  end
  object NavSubmission2Button: TWebButton
    Left = 280
    Top = 465
    Width = 96
    Height = 25
    ChildOrder = 8
    ElementID = 'overviewnavbutton'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = NavSubmissionsButtonClick
  end
  object WebShare1: TWebShare
    Left = 544
    Top = 458
  end
end