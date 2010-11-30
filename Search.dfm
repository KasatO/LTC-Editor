object frmSearch: TfrmSearch
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082' '#1080' '#1079#1072#1084#1077#1085#1072
  ClientHeight = 338
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object grpSearch: TGroupBox
    Left = 8
    Top = 8
    Width = 361
    Height = 210
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 0
    object lblEng: TLabel
      Left = 16
      Top = 20
      Width = 49
      Height = 13
      Caption = #1054#1088#1080#1075#1080#1085#1072#1083
    end
    object lblTrans: TLabel
      Left = 16
      Top = 64
      Width = 44
      Height = 13
      Caption = #1055#1077#1088#1077#1074#1086#1076
    end
    object txtEng: TEdit
      Left = 16
      Top = 39
      Width = 329
      Height = 19
      Hint = #1048#1089#1082#1086#1084#1086#1077' '#1089#1083#1086#1074#1086' '#1074' '#1089#1090#1088#1086#1082#1077' '#1072#1085#1075#1083#1080#1081#1089#1082#1086#1075#1086' '#1103#1079#1099#1082#1072
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      OnChange = txtEngChange
    end
    object txtTrans: TEdit
      Left = 16
      Top = 83
      Width = 329
      Height = 19
      Hint = #1048#1089#1082#1086#1084#1086#1077' '#1089#1083#1086#1074#1086' '#1074' '#1089#1090#1088#1086#1082#1077' '#1087#1077#1088#1077#1074#1086#1076#1072
      Ctl3D = False
      Enabled = False
      ParentCtl3D = False
      TabOrder = 1
      OnChange = txtEngChange
    end
    object chkTransAsEng: TCheckBox
      Left = 248
      Top = 64
      Width = 97
      Height = 17
      Hint = #1048#1089#1082#1072#1090#1100' '#1086#1076#1085#1086' '#1080' '#1090#1086' '#1078#1077' '#1074' '#1072#1085#1075#1083#1080#1081#1089#1082#1086#1084' '#1103#1079#1099#1082#1077' '#1080' '#1087#1077#1088#1077#1074#1086#1076#1077
      Caption = #1050#1072#1082' '#1086#1088#1080#1075#1080#1085#1072#1083
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = chkTransAsEngClick
    end
    object chkFAll: TCheckBox
      Left = 16
      Top = 135
      Width = 97
      Height = 17
      Hint = #1048#1089#1082#1072#1090#1100' '#1074#1086' '#1074#1089#1077#1093' '#1089#1090#1088#1086#1082#1072#1093', '#1083#1080#1073#1086' '#1087#1086' '#1092#1080#1083#1100#1090#1088#1091
      Caption = #1051#1102#1073#1099#1077' '#1092#1083#1072#1075#1080
      Checked = True
      Ctl3D = True
      ParentCtl3D = False
      State = cbChecked
      TabOrder = 3
      OnClick = chkFAllClick
    end
    object chkFNotTranslated: TCheckBox
      Left = 32
      Top = 159
      Width = 114
      Height = 17
      Hint = #1048#1089#1082#1072#1090#1100' '#1074' '#1085#1077#1087#1077#1088#1077#1074#1077#1076#1077#1085#1085#1099#1093' '#1089#1090#1088#1086#1082#1072#1093
      Caption = #1053#1077#1087#1077#1088#1077#1074#1077#1076#1077#1085#1085#1099#1077
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 4
    end
    object chkFChanged: TCheckBox
      Left = 32
      Top = 182
      Width = 97
      Height = 17
      Hint = #1048#1089#1082#1072#1090#1100' '#1074' '#1080#1079#1084#1077#1085#1077#1085#1085#1099#1093' '#1089#1090#1088#1086#1082#1072#1093
      Caption = #1048#1079#1084#1077#1085#1077#1085#1085#1099#1077
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 5
    end
    object chkFAdded: TCheckBox
      Left = 152
      Top = 160
      Width = 97
      Height = 17
      Hint = #1048#1089#1082#1072#1090#1100' '#1074' '#1076#1086#1073#1072#1074#1083#1077#1085#1085#1099#1093' '#1089#1090#1088#1086#1082#1072#1093
      Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1085#1099#1077
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 6
    end
    object chkFRemoved: TCheckBox
      Left = 152
      Top = 183
      Width = 97
      Height = 17
      Hint = #1048#1089#1082#1072#1090#1100' '#1074' '#1091#1076#1072#1083#1077#1085#1085#1099#1093' '#1089#1090#1088#1086#1082#1072#1093
      Caption = #1059#1076#1072#1083#1077#1085#1085#1099#1077
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 7
    end
    object chkFErroneous: TCheckBox
      Left = 264
      Top = 160
      Width = 81
      Height = 17
      Hint = #1048#1089#1082#1072#1090#1100' '#1074' '#1086#1096#1080#1073#1086#1095#1085#1099#1093' '#1089#1090#1088#1086#1082#1072#1093
      Caption = #1054#1096#1080#1073#1086#1095#1085#1099#1077
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 8
    end
    object chkCaseSens: TCheckBox
      Left = 16
      Top = 112
      Width = 97
      Height = 17
      Hint = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1088#1077#1075#1080#1089#1090' '#1089#1083#1086#1074
      Caption = #1056#1077#1075#1080#1089#1090#1088
      TabOrder = 9
    end
  end
  object grpReplace: TGroupBox
    Left = 8
    Top = 224
    Width = 361
    Height = 73
    Caption = #1047#1072#1084#1077#1085#1072
    TabOrder = 1
    object txtReplace: TEdit
      Left = 16
      Top = 40
      Width = 329
      Height = 19
      Hint = #1050#1086#1084#1073#1080#1085#1072#1094#1080#1103' '#1089#1083#1086#1074' '#1076#1083#1103' '#1079#1072#1084#1077#1085#1099
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object chkReplace: TCheckBox
      Left = 16
      Top = 17
      Width = 97
      Height = 17
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1079#1072#1084#1077#1085#1091
      Caption = #1052#1077#1085#1103#1090#1100' '#1085#1072':'
      TabOrder = 1
      OnClick = chkReplaceClick
    end
  end
  object btnSearch: TButton
    Left = 8
    Top = 303
    Width = 81
    Height = 25
    Hint = #1053#1072#1081#1090#1080' '#1089' '#1085#1072#1095#1072#1083#1072' '#1092#1072#1081#1083#1072
    Caption = #1053#1072#1081#1090#1080
    Enabled = False
    TabOrder = 2
    OnClick = btnSearchClick
  end
  object btnReplace: TButton
    Left = 201
    Top = 303
    Width = 81
    Height = 25
    Hint = #1047#1072#1084#1077#1085#1080#1090#1100' '#1086#1076#1085#1086' '#1074#1093#1086#1078#1076#1077#1085#1080#1077' '#1085#1072#1095#1080#1085#1072#1103' '#1089' '#1090#1077#1082#1091#1097#1077#1081' '#1087#1086#1079#1080#1094#1080#1080
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = btnReplaceClick
  end
  object btnReplaceAll: TButton
    Left = 288
    Top = 303
    Width = 81
    Height = 25
    Hint = #1047#1072#1084#1077#1085#1080#1090#1100' '#1042#1057#1045' '#1080#1089#1082#1086#1084#1099#1077' '#1074#1093#1086#1078#1076#1077#1085#1080#1103' '#1074' '#1092#1072#1081#1083#1077
    Caption = #1047#1072#1084#1077#1085#1080#1090#1100' '#1074#1089#1077
    Enabled = False
    TabOrder = 4
    OnClick = btnReplaceAllClick
  end
  object btnSearchNext: TButton
    Left = 95
    Top = 303
    Width = 82
    Height = 25
    Hint = #1053#1072#1081#1090#1080' '#1085#1072#1095#1080#1085#1072#1103' '#1089' '#1090#1077#1082#1091#1097#1077#1081' '#1087#1086#1079#1080#1094#1080#1080
    Caption = #1053#1072#1081#1090#1080' '#1076#1072#1083#1077#1077
    Enabled = False
    TabOrder = 5
    OnClick = btnSearchNextClick
  end
end
