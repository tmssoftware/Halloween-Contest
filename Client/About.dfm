object FrmAbout: TFrmAbout
  Width = 131
  Height = 98
  Caption = 'RADoween About'
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  FormStyle = fsStayOnTop
  FormContainer = 'body'
  ParentFont = False
  object CloseButton1: TWebButton
    Left = 8
    Top = 8
    Width = 100
    Height = 25
    ElementID = 'aboutclose'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HeightPercent = 100.000000000000000000
    ParentFont = False
    Role = 'button'
    WidthPercent = 100.000000000000000000
    OnClick = CloseButton1Click
  end
  object CloseButton2: TWebButton
    Left = 8
    Top = 39
    Width = 100
    Height = 25
    ChildOrder = 1
    ElementID = 'aboutclose2'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = CloseButton1Click
  end
end
