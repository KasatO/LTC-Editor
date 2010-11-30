object frmMain: TfrmMain
  Left = 200
  Top = 126
  Caption = 'LTC Editor'
  ClientHeight = 439
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 321
    Width = 602
    Height = 2
    Cursor = crVSplit
    Align = alTop
    AutoSnap = False
    Beveled = True
    MinSize = 100
    OnMoved = Splitter1Moved
    ExplicitWidth = 610
  end
  object pnlTrans: TPanel
    Left = 0
    Top = 323
    Width = 602
    Height = 116
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      602
      116)
    object memEng: TRichEdit
      Left = 8
      Top = 4
      Width = 579
      Height = 52
      Anchors = [akLeft, akTop, akRight]
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = False
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
    end
    object memTrans: TRichEdit
      Left = 8
      Top = 60
      Width = 579
      Height = 52
      Anchors = [akLeft, akTop, akRight]
      BevelKind = bkFlat
      BorderStyle = bsNone
      Ctl3D = False
      Enabled = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
      WantReturns = False
      OnExit = memTransExit
      OnKeyDown = memTransKeyDown
      OnKeyPress = memTransKeyPress
      OnKeyUp = memTransKeyUp
      OnMouseUp = memTransMouseUp
    end
  end
  object pnlControl: TPanel
    Left = 0
    Top = 0
    Width = 602
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      602
      62)
    object lblSearch: TLabel
      Left = 8
      Top = 24
      Width = 33
      Height = 14
      Caption = #1055#1086#1080#1089#1082':'
    end
    object lblCaption: TLabel
      Left = 352
      Top = 20
      Width = 235
      Height = 13
      Anchors = [akTop, akRight]
      AutoSize = False
    end
    object lblVersion: TLabel
      Left = 267
      Top = 4
      Width = 3
      Height = 14
      Hint = #1042#1077#1088#1089#1080#1103' '#1092#1072#1081#1083#1072' '#1087#1077#1088#1077#1074#1086#1076#1072
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object txtLangName: TEdit
      Left = 8
      Top = 2
      Width = 252
      Height = 20
      Hint = #1053#1072#1079#1074#1072#1085#1080#1077' ('#1103#1079#1099#1082') '#1087#1077#1088#1077#1074#1086#1076#1072
      Anchors = [akLeft, akTop, akRight]
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      OnKeyUp = txtIndexKeyUp
    end
    object txtIndex: TEdit
      Left = 8
      Top = 40
      Width = 49
      Height = 20
      Hint = #1055#1086#1080#1089#1082' '#1087#1086' '#1080#1085#1076#1077#1082#1089#1091' '#1089#1090#1088#1086#1082#1080
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      OnKeyUp = txtIndexKeyUp
    end
    object txtSearch: TEdit
      Left = 58
      Top = 40
      Width = 202
      Height = 20
      Hint = #1055#1086#1080#1089#1082' '#1090#1077#1082#1089#1090#1072' '#1080' '#1074' '#1086#1088#1080#1075#1080#1085#1072#1083#1077', '#1080' '#1074' '#1087#1077#1088#1077#1074#1086#1076#1077
      Anchors = [akLeft, akTop, akRight]
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      OnKeyUp = txtSearchKeyUp
    end
    object prgMain: TProgressBar
      Left = 352
      Top = 3
      Width = 235
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 5
    end
    object chkCaseSens: TCheckBox
      Left = 361
      Top = 40
      Width = 105
      Height = 17
      Hint = #1042#1082#1083'/'#1074#1099#1082#1083' '#1091#1095#1077#1090' '#1088#1077#1075#1080#1089#1090#1088#1072' '#1074#1074#1077#1076#1077#1085#1085#1099#1093' '#1089#1080#1084#1074#1086#1083#1086#1074
      Anchors = [akTop, akRight]
      Caption = #1056#1077#1075#1080#1089#1090#1088
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 4
    end
    object chkAutoSearch: TCheckBox
      Left = 265
      Top = 40
      Width = 89
      Height = 17
      Hint = #1042#1082#1083'/'#1074#1099#1082#1083' '#1072#1074#1090#1086#1087#1086#1080#1089#1082' '#1087#1086' '#1084#1077#1088#1077' '#1085#1072#1073#1086#1088#1072' '#1090#1077#1082#1089#1090#1072
      Anchors = [akTop, akRight]
      Caption = #1040#1074#1090#1086#1087#1086#1080#1089#1082
      Checked = True
      Ctl3D = False
      ParentCtl3D = False
      State = cbChecked
      TabOrder = 3
    end
    object btnSearchReplace: TButton
      Left = 488
      Top = 39
      Width = 97
      Height = 21
      Anchors = [akTop, akRight]
      Caption = #1055#1086#1080#1089#1082' '#1080' '#1079#1072#1084#1077#1085#1072
      TabOrder = 6
      OnClick = btnSearchReplaceClick
    end
    object btnGenders: TButton
      Left = 488
      Top = 22
      Width = 97
      Height = 18
      Anchors = [akTop, akRight]
      Caption = #1057#1082#1083#1086#1085#1077#1085#1080#1077
      TabOrder = 7
      OnClick = btnGendersClick
    end
  end
  object pnlList: TPanel
    Left = 0
    Top = 62
    Width = 602
    Height = 259
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      602
      259)
    object lblPrevEng: TLabel
      Left = 590
      Top = 24
      Width = 9
      Height = 18
      Cursor = crHandPoint
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1085#1077#1087#1077#1088#1077#1074#1077#1076#1077#1085#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Anchors = [akTop, akRight]
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SearchColor
    end
    object lblPrevChange: TLabel
      Left = 590
      Top = 40
      Width = 9
      Height = 18
      Cursor = crHandPoint
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1080#1079#1084#1077#1085#1077#1085#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Anchors = [akTop, akRight]
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SearchColor
    end
    object lblPrevAdd: TLabel
      Left = 590
      Top = 56
      Width = 9
      Height = 18
      Cursor = crHandPoint
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Anchors = [akTop, akRight]
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SearchColor
    end
    object lblNextEng: TLabel
      Left = 590
      Top = 120
      Width = 9
      Height = 18
      Cursor = crHandPoint
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1085#1077#1087#1077#1088#1077#1074#1077#1076#1077#1085#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Anchors = [akTop, akRight]
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SearchColor
    end
    object lblNextChange: TLabel
      Left = 590
      Top = 136
      Width = 9
      Height = 18
      Cursor = crHandPoint
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1080#1079#1084#1077#1085#1077#1085#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Anchors = [akTop, akRight]
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SearchColor
    end
    object lblNextAdd: TLabel
      Left = 590
      Top = 152
      Width = 9
      Height = 18
      Cursor = crHandPoint
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Anchors = [akTop, akRight]
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SearchColor
    end
    object lblPrevErr: TLabel
      Left = 590
      Top = 88
      Width = 9
      Height = 18
      Cursor = crHandPoint
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1086#1096#1080#1073#1086#1095#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Anchors = [akTop, akRight]
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SearchColor
    end
    object lblPrevRem: TLabel
      Left = 590
      Top = 72
      Width = 9
      Height = 18
      Cursor = crHandPoint
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1091#1076#1072#1083#1077#1085#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Anchors = [akTop, akRight]
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SearchColor
    end
    object lblNextErr: TLabel
      Left = 590
      Top = 184
      Width = 9
      Height = 18
      Cursor = crHandPoint
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1086#1096#1080#1073#1086#1095#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Anchors = [akTop, akRight]
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SearchColor
    end
    object lblNextRem: TLabel
      Left = 590
      Top = 168
      Width = 9
      Height = 18
      Cursor = crHandPoint
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1091#1076#1072#1083#1077#1085#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Anchors = [akTop, akRight]
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SearchColor
    end
    object lblCounts: TLabel
      Left = 361
      Top = 244
      Width = 217
      Height = 14
      Hint = 
        #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1088#1086#1082' '#1074' '#1092#1072#1081#1083#1077': '#1080#1079#1084#1077#1085#1077#1085#1085#1099#1093', '#1076#1086#1073#1072#1074#1083#1077#1085#1085#1099#1093', '#1091#1076#1072#1083#1077#1085#1085#1099#1093', '#1085#1077 +
        #1087#1077#1088#1077#1074#1077#1076#1077#1085#1085#1099#1093', '#1086#1096#1080#1073#1086#1095#1085#1099#1093
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
    end
    object lblStatus: TLabel
      Left = 8
      Top = 244
      Width = 348
      Height = 14
      Hint = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1089#1090#1088#1086#1082#1080' '#1087#1086#1076' '#1082#1091#1088#1089#1086#1088#1086#1084
      Anchors = [akLeft, akRight, akBottom]
      AutoSize = False
      OnClick = lblStatusClick
    end
    object lstFile: TListView
      Left = 8
      Top = 4
      Width = 577
      Height = 238
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = 'Index'
        end
        item
          Caption = 'English'
          Width = 200
        end
        item
          Caption = 'Translation'
          Width = 200
        end>
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial Unicode MS'
      Font.Style = []
      FlatScrollBars = True
      HideSelection = False
      MultiSelect = True
      OwnerData = True
      ReadOnly = True
      RowSelect = True
      ParentFont = False
      PopupMenu = popList
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = lstFileClick
      OnCustomDrawItem = lstFileCustomDrawItem
      OnData = lstFileData
      OnKeyUp = txtSearchKeyUp
      OnMouseLeave = lstFileMouseLeave
      OnMouseMove = lstFileMouseMove
      OnSelectItem = lstFileSelectItem
    end
  end
  object dlgOpen: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 384
    Top = 104
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'ltc'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 416
    Top = 104
  end
  object mnuMain: TMainMenu
    AutoHotkeys = maManual
    Left = 448
    Top = 104
    object mnuMFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object mnuMFOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        ShortCut = 16463
        OnClick = mnuMFOpenClick
      end
      object mnuMFLoadChanges: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1080#1079'...'
        Enabled = False
        OnClick = mnuMFLoadChangesClick
      end
      object mnuMFLoadChangesSlow: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1080#1079' ('#1084#1077#1076#1083#1077#1085#1085#1086')...'
        Enabled = False
        OnClick = mnuMFLoadChangesClick
      end
      object mnuMFLoadAdding: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1077#1084'...'
        Enabled = False
        OnClick = mnuMFLoadAddingClick
      end
      object mnuMFOpenEnglish: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1072#1085#1075#1083#1080#1081#1089#1082#1080#1081'...'
        OnClick = mnuMFOpenEnglishClick
      end
      object mnuMFLine1: TMenuItem
        Caption = '-'
      end
      object mnuMFSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = mnuMFSaveClick
      end
      object mnuMFSaveAs: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
        Enabled = False
        ShortCut = 24659
        OnClick = mnuMFSaveAsClick
      end
      object mnuMFSaveOnly: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1086#1083#1100#1082#1086'...'
        Enabled = False
        ShortCut = 49235
        OnClick = mnuMFSaveOnlyClick
      end
      object mnuMFLine2: TMenuItem
        Caption = '-'
      end
      object mnuMFLoadWork: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1088#1072#1073#1086#1090#1091'...'
        ShortCut = 16471
        OnClick = mnuMFLoadWorkClick
      end
      object mnuMFSaveWork: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1088#1072#1073#1086#1090#1091'...'
        Enabled = False
        OnClick = mnuMFSaveWorkClick
      end
      object mnuMFLine3: TMenuItem
        Caption = '-'
      end
      object mnuMFImport: TMenuItem
        Caption = #1048#1084#1087#1086#1088#1090' '#1080#1079
        object mnuMFILTF: TMenuItem
          Caption = 'LTF...'
          OnClick = mnuMFILTFClick
        end
      end
      object mnuMFExport: TMenuItem
        Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074
        Enabled = False
        object mnuMFEVer3: TMenuItem
          Caption = 'LTC ver. 3...'
          Enabled = False
          OnClick = mnuMFEVer3Click
        end
        object mnuMFEVer4: TMenuItem
          Caption = 'LTC ver. 4...'
          Enabled = False
          OnClick = mnuMFEVer4Click
        end
        object mnuMFEVer5: TMenuItem
          Caption = 'LTC ver. 5...'
          Enabled = False
          OnClick = mnuMFEVer5Click
        end
        object mnuMFELTF: TMenuItem
          Tag = 3
          Caption = 'LTF...'
          OnClick = mnuMFELTFClick
        end
        object mnuMFELTFVer2: TMenuItem
          Tag = 5
          Caption = 'LTF ver. 2...'
          OnClick = mnuMFELTFClick
        end
        object mnuMFELTFVer2Full: TMenuItem
          Tag = 5
          Caption = 'LTF ver. 2 ('#1073#1077#1079' '#1089#1086#1082#1088#1072#1097#1077#1085#1080#1081')...'
          OnClick = mnuMFELTFClick
        end
      end
      object mnuMFSplit: TMenuItem
        Caption = #1056#1072#1079#1073#1080#1090#1100' '#1085#1072' '#1076#1074#1072'...'
        Visible = False
        OnClick = mnuMFSplitClick
      end
      object mnuMFSplitNum: TMenuItem
        Caption = #1056#1072#1079#1073#1080#1090#1100' '#1085#1072' '#1076#1074#1072' '#1089' '#1085#1091#1084#1077#1088#1072#1094#1080#1077#1081'...'
        Visible = False
        OnClick = mnuMFSplitClick
      end
      object mnuMFLine4: TMenuItem
        Caption = '-'
      end
      object mnuMFRecent: TMenuItem
        Caption = #1053#1077#1076#1072#1074#1085#1080#1077
      end
      object mnuMFLine5: TMenuItem
        Caption = '-'
      end
      object mnuMFExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        ShortCut = 32883
        OnClick = mnuMFExitClick
      end
    end
    object mnuMLang: TMenuItem
      Caption = 'Language'
      object mnuMLSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        GroupIndex = 1
        Visible = False
        OnClick = mnuMLSaveClick
      end
      object mnuMLLine1: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
    end
    object mnuOptions: TMenuItem
      Caption = #1057#1077#1088#1074#1080#1089
      object mnuMSCheck: TMenuItem
        AutoCheck = True
        Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1086#1088#1092#1086#1075#1088#1072#1092#1080#1080
        Enabled = False
      end
      object mnuMSLine2: TMenuItem
        Caption = '-'
      end
      object mnuMORegister: TMenuItem
        Caption = #1047#1072#1088#1077#1075#1077#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' '#1082#1072#1082' '#1088#1077#1076#1072#1082#1090#1086#1088' *.ltc, *.ltf '#1080' *.lew'
        OnClick = mnuMORegisterClick
      end
      object mnuMOUnRegister: TMenuItem
        Caption = #1059#1073#1088#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1102' *.ltf, *.ltc '#1080' *.lew'
        OnClick = mnuMOUnRegisterClick
      end
    end
    object mnuMAbout: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object mnuMHAbout: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
        OnClick = mnuMHAboutClick
      end
    end
  end
  object popList: TPopupMenu
    OnPopup = popListPopup
    Left = 480
    Top = 104
    object popRemove: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = popRemoveClick
    end
    object popRestore: TMenuItem
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      OnClick = popRestoreClick
    end
    object popLine1: TMenuItem
      Caption = '-'
    end
    object popInsert: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1082#1086#1087#1080#1102
      OnClick = popInsertClick
    end
    object popLine2: TMenuItem
      Caption = '-'
    end
    object popSave: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      OnClick = popSaveClick
    end
  end
  object dlgOpenWork: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 384
    Top = 136
  end
  object dlgSaveWork: TSaveDialog
    DefaultExt = 'ltc'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 416
    Top = 136
  end
  object popMemo: TPopupMenu
    Left = 480
    Top = 134
  end
end
