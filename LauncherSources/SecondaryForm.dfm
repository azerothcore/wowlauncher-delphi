object Form2: TForm2
  Left = 347
  Top = 230
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Info'
  ClientHeight = 472
  ClientWidth = 635
  Color = cl3DLight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Thanks: TLabel
    Left = 8
    Top = 176
    Width = 35
    Height = 13
    Caption = 'Credits:'
  end
  object TextWnd: TRichEdit
    Left = 12
    Top = 8
    Width = 616
    Height = 153
    Align = alCustom
    Anchors = [akTop, akRight]
    BevelEdges = [beLeft, beRight, beBottom]
    BiDiMode = bdLeftToRight
    BorderStyle = bsNone
    Color = cl3DLight
    ParentBiDiMode = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Ok: TButton
    Left = 504
    Top = 440
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Ok'
    TabOrder = 1
    OnClick = OkClick
  end
  object Credits: TRichEdit
    Left = 8
    Top = 384
    Width = 289
    Height = 81
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object Credits2: TRichEdit
    Left = 8
    Top = 192
    Width = 609
    Height = 145
    Color = cl3DLight
    Lines.Strings = (
      
        '- Giuseppe Ronca (Alias Hw2-Yehonal)'#9#9#9'www.hw2.altervista.org'#9#9'm' +
        'ailto:hw2.eternity@gmail.com'#9#9'[ coder and founder ]'
      
        '- Bruno Carvalho (Alias Athena)'#9#9#9'www.xcla.net'#9#9#9'mailto:athena@x' +
        'cla.net'#9#9#9'[ portuguese translator and beta tester]')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 3
    WordWrap = False
  end
  object VersionPanel: TStaticText
    Left = 8
    Top = 344
    Width = 110
    Height = 17
    Cursor = crHandPoint
    BorderStyle = sbsSunken
    Caption = 'Checking version..'
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 4
    Transparent = False
    OnClick = VersionPanelClick
  end
end
