object FrmOverview: TFrmOverview
  Width = 540
  Height = 1018
  Caption = 'RADoween Overview'
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -19
  Font.Name = 'Arial'
  Font.Style = []
  FormContainer = 'overviewcontainer'
  ParentFont = False
  OnCreate = Form2Create
  object WebContinuousScroll1: TWebContinuousScroll
    Left = 0
    Top = 0
    Width = 540
    Height = 1018
    HeightStyle = ssAuto
    WidthStyle = ssPercent
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    Align = alClient
    TabOrder = 0
    ElementPosition = epRelative
    ElementButtonClassName = 'end-0'
    LoadType = ltScroll
    PageNumber = 0
    LoadScrollPercent = 100
    OnFetchNextPage = FetchNextPageByIDDesc
    OnGetListItem = WebContinuousScroll1GetListItem
  end
  object NavAboutButton: TWebButton
    Left = 392
    Top = 109
    Width = 104
    Height = 28
    Caption = 'About'
    ElementID = 'aboutnav'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    WidthPercent = 100.000000000000000000
    OnClick = NavAboutButtonClick
  end
  object NavSubmitButton: TWebButton
    Left = 392
    Top = 8
    Width = 104
    Height = 36
    Caption = 'Submit picture'
    ChildOrder = 3
    ElementID = 'overviewnav'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = WebBitBtn1Click
  end
  object SortByTimeButton: TWebButton
    Left = 392
    Top = 50
    Width = 50
    Height = 53
    ChildOrder = 4
    ElementID = 'sortbutton'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = SortByTimeButtonClick
  end
  object SortUpDownButton: TWebButton
    Left = 448
    Top = 50
    Width = 48
    Height = 53
    ChildOrder = 5
    ElementID = 'directionbutton'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = SortUpDownButtonClick
  end
  object SortByAlphaButton: TWebButton
    Left = 392
    Top = 143
    Width = 104
    Height = 34
    ChildOrder = 5
    ElementID = 'sortbutton2'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = SortByAlphaButtonClick
  end
  object SortByVotesButton: TWebButton
    Left = 392
    Top = 183
    Width = 104
    Height = 34
    ChildOrder = 6
    ElementID = 'sortbutton3'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = SortByVotesButtonClick
  end
  object WebShare1: TWebShare
    Left = 4
    Top = 47
  end
end
