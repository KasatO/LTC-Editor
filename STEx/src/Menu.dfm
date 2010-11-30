object MenuForm: TMenuForm
  Left = 303
  Top = 257
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 121
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object CheckBox1: TCheckBox
    Left = 16
    Top = 32
    Width = 225
    Height = 17
    Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100'  '#1087#1088#1077#1092#1080#1082#1089
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 56
    Width = 241
    Height = 21
    TabOrder = 1
    Text = 'LNG_'
  end
  object CheckBox2: TCheckBox
    Left = 16
    Top = 8
    Width = 233
    Height = 17
    Caption = #1048#1089#1082#1072#1090#1100' '#1089#1090#1088#1086#1082#1080' '#1085#1072' '#1088#1091#1089#1089#1082#1086#1084
    TabOrder = 2
  end
  object Button1: TButton
    Left = 176
    Top = 88
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object Button2: TButton
    Left = 88
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
end
