object frmGenderCorrection: TfrmGenderCorrection
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1050#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072' '#1088#1086#1076#1086#1074
  ClientHeight = 108
  ClientWidth = 188
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblCorrection: TLabel
    Left = 8
    Top = 8
    Width = 121
    Height = 13
    Caption = #1057#1087#1086#1089#1086#1073' '#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1080':'
  end
  object rbtToString: TRadioButton
    Left = 16
    Top = 24
    Width = 129
    Height = 17
    Caption = #1052#1072#1088#1082#1077#1088' -> '#1057#1090#1088#1086#1082#1072
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object rbtFromString: TRadioButton
    Left = 16
    Top = 40
    Width = 129
    Height = 17
    Caption = #1057#1090#1088#1086#1082#1072' -> '#1052#1072#1088#1082#1077#1088
    TabOrder = 1
  end
  object btnStart: TButton
    Left = 8
    Top = 73
    Width = 75
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 2
    OnClick = btnStartClick
  end
  object btnCancel: TButton
    Left = 103
    Top = 73
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
