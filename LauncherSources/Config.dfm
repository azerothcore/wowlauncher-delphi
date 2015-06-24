object Form1: TForm1
  Left = 411
  Top = 220
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Configurazioni'
  ClientHeight = 485
  ClientWidth = 582
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poDesktopCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    582
    485)
  PixelsPerInch = 96
  TextHeight = 13
  object ConfTab: TPageControl
    Left = 0
    Top = 0
    Width = 581
    Height = 449
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'General'
      object help2: TSpeedButton
        Left = 248
        Top = 184
        Width = 17
        Height = 17
        Cursor = crHelp
        Glyph.Data = {
          46010000424D460100000000000076000000280000001A0000000D0000000100
          040000000000D0000000120B0000120B00001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333633333
          333333F33333330000003333364633333333338F33333300333333333E643333
          333338F8F333330033333333334633333333333F333333003333333336643333
          33333388F3333300333333333E643333333338F8F3333300333333333E664333
          333338F8F33333003333333333E666333333338338F3330033333334433E6633
          3333F33F33833300333333366433E63333338F38F33333003334333E66666633
          33383388333333003336333333EEEE33333388FFFF833300333E333333333333
          33333388883333003333}
        NumGlyphs = 2
        OnClick = help2Click
      end
      object RealmChose: TRadioGroup
        Left = 16
        Top = 88
        Width = 193
        Height = 73
        Caption = 'Scelta del Reame'
        TabOrder = 4
      end
      object Defaultbtn: TBitBtn
        Left = 440
        Top = 388
        Width = 129
        Height = 25
        Cursor = crHandPoint
        Caption = 'Opzioni Predefinite'
        TabOrder = 0
        WordWrap = True
        OnClick = DefaultbtnClick
      end
      object TrasparenzaLabel: TGroupBox
        Left = 376
        Top = 128
        Width = 169
        Height = 153
        Caption = 'Trasparenza'
        TabOrder = 1
        object IntTraspLabel: TLabel
          Left = 7
          Top = 68
          Width = 98
          Height = 13
          Caption = 'Intensit'#224' trasparenza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object TrasparenzaBox: TCheckBox
          Left = 8
          Top = 32
          Width = 97
          Height = 17
          Cursor = crHandPoint
          Caption = 'Attiva'
          TabOrder = 0
          OnClick = TrasparenzaBoxClick
        end
        object TrackBar1: TTrackBar
          Left = 3
          Top = 92
          Width = 150
          Height = 45
          Cursor = crHandPoint
          Max = 250
          Min = 50
          Position = 250
          SelEnd = 250
          TabOrder = 1
          OnChange = TrackBar1Change
        end
      end
      object Extra: TGroupBox
        Left = 16
        Top = 304
        Width = 361
        Height = 113
        Caption = 'Extra'
        TabOrder = 2
        object CacheLabel: TLabel
          Left = 5
          Top = 20
          Width = 92
          Height = 13
          Caption = 'Pulizia della Cache:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object XTCheckLabel: TLabel
          Left = 147
          Top = 20
          Width = 70
          Height = 13
          Caption = 'Controlli estesi:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object help3: TSpeedButton
          Left = 104
          Top = 40
          Width = 17
          Height = 17
          Cursor = crHelp
          Glyph.Data = {
            46010000424D460100000000000076000000280000001A0000000D0000000100
            040000000000D0000000120B0000120B00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333633333
            333333F33333330000003333364633333333338F33333300333333333E643333
            333338F8F333330033333333334633333333333F333333003333333336643333
            33333388F3333300333333333E643333333338F8F3333300333333333E664333
            333338F8F33333003333333333E666333333338338F3330033333334433E6633
            3333F33F33833300333333366433E63333338F38F33333003334333E66666633
            33383388333333003336333333EEEE33333388FFFF833300333E333333333333
            33333388883333003333}
          NumGlyphs = 2
          OnClick = help3Click
        end
        object help4: TSpeedButton
          Left = 224
          Top = 40
          Width = 17
          Height = 17
          Cursor = crHelp
          Glyph.Data = {
            46010000424D460100000000000076000000280000001A0000000D0000000100
            040000000000D0000000120B0000120B00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333633333
            333333F33333330000003333364633333333338F33333300333333333E643333
            333338F8F333330033333333334633333333333F333333003333333336643333
            33333388F3333300333333333E643333333338F8F3333300333333333E664333
            333338F8F33333003333333333E666333333338338F3330033333334433E6633
            3333F33F33833300333333366433E63333338F38F33333003334333E66666633
            33383388333333003336333333EEEE33333388FFFF833300333E333333333333
            33333388883333003333}
          NumGlyphs = 2
          OnClick = help4Click
        end
        object HamachiLabel: TLabel
          Left = 3
          Top = 68
          Width = 91
          Height = 13
          Caption = 'Supporto Hamachi:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Help6: TSpeedButton
          Left = 104
          Top = 88
          Width = 17
          Height = 17
          Cursor = crHelp
          Glyph.Data = {
            46010000424D460100000000000076000000280000001A0000000D0000000100
            040000000000D0000000120B0000120B00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333633333
            333333F33333330000003333364633333333338F33333300333333333E643333
            333338F8F333330033333333334633333333333F333333003333333336643333
            33333388F3333300333333333E643333333338F8F3333300333333333E664333
            333338F8F33333003333333333E666333333338338F3330033333334433E6633
            3333F33F33833300333333366433E63333338F38F33333003334333E66666633
            33383388333333003336333333EEEE33333388FFFF833300333E333333333333
            33333388883333003333}
          NumGlyphs = 2
          OnClick = help6Click
        end
        object shoutoplabel: TLabel
          Left = 147
          Top = 68
          Width = 89
          Height = 13
          Caption = 'Shoutbox all'#39'avvio:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Help7: TSpeedButton
          Left = 224
          Top = 88
          Width = 17
          Height = 17
          Cursor = crHelp
          Glyph.Data = {
            46010000424D460100000000000076000000280000001A0000000D0000000100
            040000000000D0000000120B0000120B00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333633333
            333333F33333330000003333364633333333338F33333300333333333E643333
            333338F8F333330033333333334633333333333F333333003333333336643333
            33333388F3333300333333333E643333333338F8F3333300333333333E664333
            333338F8F33333003333333333E666333333338338F3330033333334433E6633
            3333F33F33833300333333366433E63333338F38F33333003334333E66666633
            33383388333333003336333333EEEE33333388FFFF833300333E333333333333
            33333388883333003333}
          NumGlyphs = 2
          OnClick = help7Click
        end
        object TimerOp: TLabel
          Left = 275
          Top = 20
          Width = 58
          Height = 13
          Caption = 'Status timer:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Help8: TSpeedButton
          Left = 336
          Top = 40
          Width = 17
          Height = 17
          Cursor = crHelp
          Glyph.Data = {
            46010000424D460100000000000076000000280000001A0000000D0000000100
            040000000000D0000000120B0000120B00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333633333
            333333F33333330000003333364633333333338F33333300333333333E643333
            333338F8F333330033333333334633333333333F333333003333333336643333
            33333388F3333300333333333E643333333338F8F3333300333333333E664333
            333338F8F33333003333333333E666333333338338F3330033333334433E6633
            3333F33F33833300333333366433E63333338F38F33333003334333E66666633
            33383388333333003336333333EEEE33333388FFFF833300333E333333333333
            33333388883333003333}
          NumGlyphs = 2
          OnClick = help8Click
        end
        object CacheBox: TCheckBox
          Left = 8
          Top = 40
          Width = 89
          Height = 17
          Cursor = crHandPoint
          Caption = 'Attiva'
          TabOrder = 0
        end
        object XTCheckBox: TCheckBox
          Left = 144
          Top = 40
          Width = 73
          Height = 17
          Cursor = crHandPoint
          Caption = 'Attiva'
          TabOrder = 1
          OnClick = XTCheckBoxClick
        end
        object HamachiBox: TCheckBox
          Left = 8
          Top = 88
          Width = 73
          Height = 17
          Cursor = crHandPoint
          Caption = 'Attiva'
          TabOrder = 2
        end
        object ShoutOpBox: TCheckBox
          Left = 144
          Top = 88
          Width = 65
          Height = 17
          Caption = 'Attiva'
          TabOrder = 3
        end
        object StTimerBox: TCheckBox
          Left = 272
          Top = 40
          Width = 57
          Height = 17
          Cursor = crHandPoint
          Caption = 'Attiva'
          TabOrder = 4
        end
      end
      object Lingua: TGroupBox
        Left = 376
        Top = 24
        Width = 177
        Height = 89
        Caption = 'Lingua'
        TabOrder = 3
        object Help1: TSpeedButton
          Left = 152
          Top = 8
          Width = 17
          Height = 17
          Cursor = crHelp
          Glyph.Data = {
            46010000424D460100000000000076000000280000001A0000000D0000000100
            040000000000D0000000120B0000120B00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333633333
            333333F33333330000003333364633333333338F33333300333333333E643333
            333338F8F333330033333333334633333333333F333333003333333336643333
            33333388F3333300333333333E643333333338F8F3333300333333333E664333
            333338F8F33333003333333333E666333333338338F3330033333334433E6633
            3333F33F33833300333333366433E63333338F38F33333003334333E66666633
            33383388333333003336333333EEEE33333388FFFF833300333E333333333333
            33333388883333003333}
          NumGlyphs = 2
          OnClick = Help1Click
        end
        object LangBox1: TComboBox
          Left = 8
          Top = 44
          Width = 161
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          OnSelect = LangBox1Select
        end
        object LangBox2: TComboBox
          Left = 104
          Top = 64
          Width = 145
          Height = 21
          ItemHeight = 13
          TabOrder = 1
          Visible = False
        end
      end
      object GeneralSet: TRadioGroup
        Left = 16
        Top = 8
        Width = 297
        Height = 73
        Caption = 'GeneralSet'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'set1'
          'blizzard'
          'set3')
        ParentFont = False
        TabOrder = 5
        OnClick = GeneralSetClick
      end
      object GroupBox1: TGroupBox
        Left = 16
        Top = 176
        Width = 233
        Height = 73
        Caption = 'Realmlist'
        TabOrder = 6
        object Del: TBitBtn
          Left = 8
          Top = 16
          Width = 25
          Height = 17
          Cursor = crHandPoint
          Cancel = True
          ModalResult = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = DelClick
          Glyph.Data = {
            56010000424D560100000000000076000000280000001C0000000E0000000100
            040000000000E0000000120B0000120B00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33333333333333330000333883333333333333F3333333333333339118333118
            33338F3F33388F33333833911183911133338F38F3F338333391333911181111
            33338F338F8333F33391333331111183333333833333F8333339333331111833
            3333333F33338333333333333911183333333338F33833333333333331111833
            333333383338F33333333339118391183333338338F38F333333333918333111
            333338F3838338333339333393333911333338F8333F33F33339333333333333
            3333333333338833333333333333333333333333333333333333}
          NumGlyphs = 2
        end
        object Realmlist: TComboBox
          Left = 8
          Top = 36
          Width = 193
          Height = 21
          AutoDropDown = True
          ItemHeight = 13
          Sorted = True
          TabOrder = 1
          OnChange = RealmlistChange
        end
        object Add: TBitBtn
          Left = 40
          Top = 16
          Width = 25
          Height = 17
          Cursor = crHandPoint
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = AddClick
          Glyph.Data = {
            9E020000424D9E0200000000000036000000280000000E0000000E0000000100
            18000000000068020000120B0000120B00000000000000000000C0C0C0C0C0C0
            C0C0C0D3CCCC456C6C007676009191007E7E4A4C4CC4C4C4C1C1C1C0C0C0C0C0
            C0C0C0C00000C0C0C0C0C0C0C0C0C0D3C6C6458D8D00E2E200FFFF00ECEC0D38
            38898282C9C9C9C0C0C0C0C0C0C0C0C00000C0C0C0C0C0C0C0C0C0D3C6C6458C
            8C00DEDE00FFFF00E8E80F39398B8585C9C9C9C0C0C0C0C0C0C0C0C00000D3CC
            CCD3C6C6D3C6C6E8CECE4C8A8A00DCDC00FFFF00E7E7103333998686DDD0D0D3
            C6C6D3CCCCC6C6C60000456B6B459191459A9A4C8A8A199E9E00F5F500FFFF00
            F6F6055C5C327E7E499898459090456D6DA19F9F0000007C7C00B9B9005C5C00
            DCDC00888800AAAA00D1D1009C9C00BBBB009A9A00878700D9D9008787184D4D
            000000999900EBEB00676700DCDC00AAAA00D4D4009E9E00DADA009D9D00A7A7
            00B5B500FFFF00A4A4004040000000828200CFCF007C7C00D4D400C9C900E3E3
            00C2C200ECEC00B7B700BFBF00848400E2E2009696003C3C00004A4B4B0E3A3A
            0F3E3E103434066464008383008585009797010B0B0B3A3A103E3E0F3A3A0F3E
            3E0F2A2A0000C4C4C48882828B8585988686338383006D6D0063630073730A3D
            3D645959918C8C8B85858B85858B88880000C1C1C1CACACAC9C9C9DDD0D045A1
            A1143838425252016C6C103F3F928C8CD3D3D3C9C9C9C9C9C9C9C9C90000C0C0
            C0C0C0C0C0C0C0D3C5C54398980F8E8E5D8D8D00C6C60F3B3B8B8585C9C9C9C0
            C0C0C0C0C0C0C0C00000C0C0C0C0C0C0C0C0C0D4CCCC426E6E008080088A8A00
            98980F3E3E8B8585C9C9C9C0C0C0C0C0C0C0C0C00000C0C0C0C0C0C0C0C0C0C7
            C6C6A19F9F1A4F4F004545003C3C0F2A2A8B8888C9C9C9C0C0C0C0C0C0C0C0C0
            0000}
        end
        object Edit: TBitBtn
          Left = 72
          Top = 16
          Width = 25
          Height = 17
          Cursor = crHandPoint
          Cancel = True
          ModalResult = 7
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = EditClick
          Glyph.Data = {
            06020000424D0602000000000000760000002800000028000000140000000100
            0400000000009001000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3FFFFFFF333333333333000000733333333333337777777FFF33333333333333
            3700733333333333333337777FFF333333333333330770733333333333333377
            777FFF33333333333377F8707333333333333377F3777FF33333333333308FF8
            7033333333333337FF3377FF3333333333377FF807033333333333377F33777F
            F33333333333088047703333333333337FF77777FF3333333333770BB4770333
            33333333777337777FF33333333330FFBB47703333333333373F337777FF3333
            3333330FFBB47703333333333373F337777F333333333330FFBB477033333333
            33373F3377773333333333330FFBB47733333333333373F33777333333333333
            30FFBB47333333333333373F3377333333333333330FFBB43333333333333373
            F3373333333333333330FFBB33333333333333373F3333333333333333330FFB
            33333333333333337333}
          NumGlyphs = 2
        end
      end
      object Button1: TBitBtn
        Left = 144
        Top = 250
        Width = 57
        Height = 15
        Cursor = crHandPoint
        Caption = 'refresh'
        TabOrder = 7
        OnClick = Button1Click
      end
      object Crealmlist: TLabeledEdit
        Left = 16
        Top = 268
        Width = 185
        Height = 21
        AutoSize = False
        BorderStyle = bsNone
        Color = clBtnFace
        EditLabel.Width = 122
        EditLabel.Height = 13
        EditLabel.Caption = 'Current Default Realmlist: '
        ReadOnly = True
        TabOrder = 8
      end
      object OffyRealmBox: TComboBox
        Left = 24
        Top = 112
        Width = 145
        Height = 22
        Style = csOwnerDrawFixed
        ItemHeight = 16
        ItemIndex = 0
        TabOrder = 9
        Text = 'EU-European'
        Items.Strings = (
          'EU-European'
          'US-American')
      end
      object RealmBox: TComboBox
        Left = 24
        Top = 108
        Width = 145
        Height = 21
        AutoComplete = False
        ItemHeight = 13
        TabOrder = 10
        OnChange = RealmBoxChange
      end
      object Rpatch2: TStaticText
        Left = 24
        Top = 136
        Width = 68
        Height = 17
        Caption = 'Realm Patch:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object Rpatch: TComboBox
        Left = 96
        Top = 136
        Width = 97
        Height = 21
        Style = csSimple
        ItemHeight = 13
        TabOrder = 12
        OnChange = RpatchChange
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Server List'
      ImageIndex = 3
      object NavUrlEditLabel: TLabel
        Left = 8
        Top = 368
        Width = 71
        Height = 13
        Caption = 'Launcher-Web'
      end
      object Label1: TLabel
        Left = 424
        Top = 400
        Width = 130
        Height = 13
        Caption = 'This Pannel is in beta stage'
      end
      object SLinfo: TLabel
        Left = 376
        Top = 360
        Width = 193
        Height = 34
        Cursor = crHandPoint
        Caption = 'Click Here to add your server into the list! '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Arial Black'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        WordWrap = True
        OnClick = SLinfoClick
      end
      object Help11: TSpeedButton
        Left = 136
        Top = 384
        Width = 17
        Height = 17
        Cursor = crHelp
        Glyph.Data = {
          46010000424D460100000000000076000000280000001A0000000D0000000100
          040000000000D0000000120B0000120B00001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333633333
          333333F33333330000003333364633333333338F33333300333333333E643333
          333338F8F333330033333333334633333333333F333333003333333336643333
          33333388F3333300333333333E643333333338F8F3333300333333333E664333
          333338F8F33333003333333333E666333333338338F3330033333334433E6633
          3333F33F33833300333333366433E63333338F38F33333003334333E66666633
          33383388333333003336333333EEEE33333388FFFF833300333E333333333333
          33333388883333003333}
        NumGlyphs = 2
        OnClick = Help11Click
      end
      object NavUrlEdit: TComboBox
        Left = 216
        Top = 384
        Width = 121
        Height = 21
        ItemHeight = 0
        TabOrder = 0
        Visible = False
      end
      object SiteGrid: TStringGrid
        Left = 0
        Top = 16
        Width = 569
        Height = 337
        ColCount = 7
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
        TabOrder = 1
        OnClick = SiteGridClick
        OnMouseUp = SiteGridMouseUp
        ColWidths = (
          135
          129
          122
          113
          136
          145
          64)
      end
      object NavUrlEdit2: TEdit
        Left = 8
        Top = 384
        Width = 121
        Height = 21
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Advanced'
      ImageIndex = 1
      object PathsGroup: TGroupBox
        Left = 280
        Top = 16
        Width = 265
        Height = 337
        Caption = 'Path Conf.'
        TabOrder = 0
        object help10: TSpeedButton
          Left = 232
          Top = 8
          Width = 17
          Height = 17
          Cursor = crHelp
          Glyph.Data = {
            46010000424D460100000000000076000000280000001A0000000D0000000100
            040000000000D0000000120B0000120B00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333633333
            333333F33333330000003333364633333333338F33333300333333333E643333
            333338F8F333330033333333334633333333333F333333003333333336643333
            33333388F3333300333333333E643333333338F8F3333300333333333E664333
            333338F8F33333003333333333E666333333338338F3330033333334433E6633
            3333F33F33833300333333366433E63333338F38F33333003334333E66666633
            33383388333333003336333333EEEE33333388FFFF833300333E333333333333
            33333388883333003333}
          NumGlyphs = 2
          OnClick = help10Click
        end
        object CachePEdit: TLabeledEdit
          Left = 16
          Top = 48
          Width = 121
          Height = 21
          EditLabel.Width = 56
          EditLabel.Height = 13
          EditLabel.Caption = 'Cache Path'
          TabOrder = 0
        end
        object RealmListPEdit: TLabeledEdit
          Left = 16
          Top = 88
          Width = 121
          Height = 21
          EditLabel.Width = 67
          EditLabel.Height = 13
          EditLabel.Caption = 'Realmlist Path'
          TabOrder = 1
        end
        object WoWExePEdit: TLabeledEdit
          Left = 16
          Top = 128
          Width = 121
          Height = 21
          EditLabel.Width = 73
          EditLabel.Height = 13
          EditLabel.Caption = 'WoW exe Path'
          TabOrder = 2
        end
        object WoWDataPEdit: TLabeledEdit
          Left = 16
          Top = 168
          Width = 121
          Height = 21
          EditLabel.Width = 79
          EditLabel.Height = 13
          EditLabel.Caption = 'WoW Data Path'
          TabOrder = 3
        end
        object RepairPEdit: TLabeledEdit
          Left = 16
          Top = 208
          Width = 121
          Height = 21
          EditLabel.Width = 76
          EditLabel.Height = 13
          EditLabel.Caption = 'Repair exe Path'
          TabOrder = 4
        end
        object LauncherPEdit: TLabeledEdit
          Left = 16
          Top = 248
          Width = 121
          Height = 21
          EditLabel.Width = 105
          EditLabel.Height = 13
          EditLabel.Caption = 'Official Launcher Path'
          TabOrder = 5
        end
        object ConfWtfPEdit: TLabeledEdit
          Left = 16
          Top = 288
          Width = 121
          Height = 21
          EditLabel.Width = 72
          EditLabel.Height = 13
          EditLabel.Caption = 'Config.wtf Path'
          TabOrder = 6
        end
        object pbox1: TCheckBox
          Left = 160
          Top = 48
          Width = 17
          Height = 17
          TabOrder = 7
          OnClick = pbox1Click
        end
        object pbox2: TCheckBox
          Left = 160
          Top = 88
          Width = 17
          Height = 17
          TabOrder = 8
          OnClick = pbox1Click
        end
        object pbox3: TCheckBox
          Left = 160
          Top = 128
          Width = 17
          Height = 17
          TabOrder = 9
          OnClick = pbox1Click
        end
        object pbox4: TCheckBox
          Left = 160
          Top = 168
          Width = 17
          Height = 17
          TabOrder = 10
          OnClick = pbox1Click
        end
        object pbox5: TCheckBox
          Left = 160
          Top = 208
          Width = 17
          Height = 17
          TabOrder = 11
          OnClick = pbox1Click
        end
        object pbox6: TCheckBox
          Left = 160
          Top = 248
          Width = 17
          Height = 17
          TabOrder = 12
          OnClick = pbox1Click
        end
        object pbox7: TCheckBox
          Left = 160
          Top = 288
          Width = 17
          Height = 17
          TabOrder = 13
          OnClick = pbox1Click
        end
      end
      object ConnGroup: TGroupBox
        Left = 16
        Top = 16
        Width = 201
        Height = 153
        Caption = 'Connection Conf.'
        TabOrder = 1
        object help9: TSpeedButton
          Left = 176
          Top = 8
          Width = 17
          Height = 17
          Cursor = crHelp
          Glyph.Data = {
            46010000424D460100000000000076000000280000001A0000000D0000000100
            040000000000D0000000120B0000120B00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333633333
            333333F33333330000003333364633333333338F33333300333333333E643333
            333338F8F333330033333333334633333333333F333333003333333336643333
            33333388F3333300333333333E643333333338F8F3333300333333333E664333
            333338F8F33333003333333333E666333333338338F3330033333334433E6633
            3333F33F33833300333333366433E63333338F38F33333003334333E66666633
            33383388333333003336333333EEEE33333388FFFF833300333E333333333333
            33333388883333003333}
          NumGlyphs = 2
          OnClick = help9Click
        end
        object ConnDelayEdit: TLabeledEdit
          Left = 16
          Top = 48
          Width = 121
          Height = 21
          EditLabel.Width = 108
          EditLabel.Height = 13
          EditLabel.Caption = 'TCP Connection Delay'
          TabOrder = 0
        end
        object StatusDelay: TLabeledEdit
          Left = 16
          Top = 104
          Width = 121
          Height = 21
          EditLabel.Width = 89
          EditLabel.Height = 13
          EditLabel.Caption = 'Status Timer Delay'
          TabOrder = 1
        end
      end
      object DefaultBtn2: TBitBtn
        Left = 16
        Top = 384
        Width = 137
        Height = 25
        Cursor = crHandPoint
        Caption = 'DefaultBtn2'
        TabOrder = 2
        OnClick = DefaultBtn2Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Game'
      ImageIndex = 2
      object GraphicBox: TGroupBox
        Left = 16
        Top = 24
        Width = 217
        Height = 169
        Caption = 'Graphic Preferences'
        TabOrder = 0
        object graphic_windowmode: TCheckBox
          Left = 16
          Top = 32
          Width = 193
          Height = 17
          Caption = 'Window Mode'
          TabOrder = 0
        end
        object graphic_HighLights: TCheckBox
          Left = 16
          Top = 56
          Width = 193
          Height = 17
          Caption = 'Terrain HighLights'
          TabOrder = 1
        end
        object graphic_trilinearFilter: TCheckBox
          Left = 16
          Top = 80
          Width = 193
          Height = 17
          Caption = 'Trilinear Filtering'
          TabOrder = 2
        end
        object graphic_resolution: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 50
          EditLabel.Height = 13
          EditLabel.Caption = 'Resolution'
          TabOrder = 3
        end
      end
      object SoundBox: TGroupBox
        Left = 16
        Top = 216
        Width = 217
        Height = 169
        Caption = 'Sound Preferences'
        TabOrder = 1
        object Sound_ChannelLabel: TLabel
          Left = 16
          Top = 96
          Width = 81
          Height = 13
          Caption = 'Sound Channels:'
        end
        object sound_enable: TCheckBox
          Left = 16
          Top = 32
          Width = 193
          Height = 17
          Caption = 'Enable all Sound'
          TabOrder = 0
        end
        object sound_hdAcceleration: TCheckBox
          Left = 16
          Top = 64
          Width = 193
          Height = 17
          Caption = 'Hardware Acceleration'
          TabOrder = 1
        end
        object sound_channels: TTrackBar
          Left = 8
          Top = 112
          Width = 153
          Height = 25
          Cursor = crHandPoint
          Max = 64
          Min = 1
          Position = 1
          TabOrder = 2
          ThumbLength = 15
          TickStyle = tsNone
        end
      end
      object Game_Restore: TBitBtn
        Left = 376
        Top = 352
        Width = 185
        Height = 25
        Cursor = crHandPoint
        Caption = 'Restore latest definition'
        TabOrder = 2
        OnClick = Game_RestoreClick
        Kind = bkRetry
      end
    end
  end
  object Okbtn: TBitBtn
    Left = 392
    Top = 455
    Width = 89
    Height = 25
    Cursor = crHandPoint
    Caption = 'Applica'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
    OnClick = OkbtnClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object Annullabtn: TBitBtn
    Left = 488
    Top = 455
    Width = 83
    Height = 25
    Cursor = crHandPoint
    TabOrder = 2
    Visible = False
    OnClick = AnnullabtnClick
    Kind = bkAbort
  end
end
