object frmSaveOnly: TfrmSaveOnly
  Left = 766
  Top = 271
  BorderStyle = bsDialog
  Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1086#1083#1100#1082#1086
  ClientHeight = 184
  ClientWidth = 192
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object chkChanged: TCheckBox
    Left = 24
    Top = 24
    Width = 121
    Height = 17
    Caption = #1048#1079#1084#1077#1085#1077#1085#1085#1099#1077
    TabOrder = 0
    OnClick = chkChangedClick
  end
  object chkAdded: TCheckBox
    Left = 24
    Top = 40
    Width = 121
    Height = 17
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1085#1099#1077
    TabOrder = 1
    OnClick = chkChangedClick
  end
  object chkRemoved: TCheckBox
    Left = 24
    Top = 56
    Width = 121
    Height = 17
    Caption = #1059#1076#1072#1083#1077#1085#1085#1099#1077
    TabOrder = 2
    OnClick = chkChangedClick
  end
  object chkNotTrans: TCheckBox
    Left = 24
    Top = 72
    Width = 121
    Height = 17
    Caption = #1053#1077#1087#1077#1088#1077#1074#1077#1076#1077#1085#1085#1099#1077
    TabOrder = 3
    OnClick = chkChangedClick
  end
  object btnOK: TButton
    Left = 8
    Top = 152
    Width = 75
    Height = 25
    Hint = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1087#1088#1086#1094#1077#1089#1089' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    TabOrder = 4
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 112
    Top = 152
    Width = 75
    Height = 25
    Hint = #1042#1077#1088#1085#1091#1090#1100#1089#1103' '#1085#1072#1079#1072#1076' '#1073#1077#1079' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 5
    OnClick = btnCancelClick
  end
  object rbtMarks: TRadioButton
    Left = 8
    Top = 8
    Width = 113
    Height = 17
    Hint = #1042#1099#1073#1088#1072#1090#1100' "'#1084#1072#1088#1082#1080#1088#1086#1074#1082#1091'" '#1089#1086#1093#1088#1072#1085#1103#1077#1084#1099#1093' '#1089#1090#1088#1086#1082
    Caption = #1055#1086' '#1084#1072#1088#1082#1080#1088#1086#1074#1082#1077
    Checked = True
    TabOrder = 6
    TabStop = True
    OnClick = rbtMarksClick
  end
  object rbtRange: TRadioButton
    Left = 8
    Top = 96
    Width = 113
    Height = 17
    Hint = #1059#1082#1072#1079#1072#1090#1100' '#1076#1080#1072#1087#1072#1079#1086#1085' '#1089#1090#1088#1086#1082' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103
    Caption = #1055#1086' '#1076#1080#1072#1087#1072#1079#1086#1085#1091
    TabOrder = 7
    OnClick = rbtMarksClick
  end
  object txtMin: TEdit
    Left = 24
    Top = 120
    Width = 49
    Height = 21
    Hint = #1053#1080#1078#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' ('#1080#1085#1076#1077#1082#1089') '#1076#1080#1072#1087#1072#1079#1086#1085#1072
    Enabled = False
    TabOrder = 8
    Text = '1'
    OnChange = txtMinChange
    OnKeyPress = txtMinKeyPress
  end
  object txtMax: TEdit
    Left = 88
    Top = 120
    Width = 49
    Height = 21
    Hint = #1042#1077#1088#1093#1085#1103#1103' '#1075#1088#1072#1085#1080#1094#1072' ('#1080#1085#1076#1077#1082#1089') '#1076#1080#1072#1087#1072#1079#1086#1085#1072
    Enabled = False
    TabOrder = 9
    Text = '1'
    OnChange = txtMinChange
    OnKeyPress = txtMinKeyPress
  end
end
