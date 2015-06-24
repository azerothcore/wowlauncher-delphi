object Form3: TForm3
  Left = 640
  Top = 118
  Width = 390
  Height = 251
  BorderIcons = [biSystemMenu]
  Caption = 'RealmList Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 362
    Height = 202
    Caption = 'Realmlist'
    TabOrder = 0
    object realmlabel: TLabel
      Left = 8
      Top = 24
      Width = 56
      Height = 13
      Caption = 'Set realmlist'
    end
    object Label1: TLabel
      Left = 8
      Top = 80
      Width = 56
      Height = 13
      Caption = 'Description:'
    end
    object Label2: TLabel
      Left = 8
      Top = 128
      Width = 21
      Height = 13
      Caption = 'Site:'
    end
    object Save: TBitBtn
      Left = 272
      Top = 168
      Width = 49
      Height = 25
      Cursor = crHandPoint
      Caption = '&OK'
      TabOrder = 0
      OnClick = SaveClick
      Kind = bkOK
    end
    object Realmlist: TEdit
      Left = 8
      Top = 40
      Width = 193
      Height = 21
      TabOrder = 1
      OnChange = RealmlistChange
    end
    object Description: TEdit
      Left = 8
      Top = 96
      Width = 193
      Height = 21
      TabOrder = 2
    end
    object Site: TEdit
      Left = 8
      Top = 144
      Width = 193
      Height = 21
      TabOrder = 3
    end
  end
end
