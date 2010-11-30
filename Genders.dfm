object frmGenders: TfrmGenders
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1057#1082#1083#1086#1085#1077#1085#1080#1103
  ClientHeight = 288
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    660
    288)
  PixelsPerInch = 96
  TextHeight = 13
  object lstGenders: TListView
    Left = 8
    Top = 8
    Width = 644
    Height = 272
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = 'Index'
      end>
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial Unicode MS'
    Font.Style = []
    FlatScrollBars = True
    HideSelection = False
    OwnerData = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
    OnData = lstGendersData
    OnMouseUp = lstGendersMouseUp
  end
  object btnEdit: TButton
    Left = 616
    Top = 32
    Width = 25
    Height = 17
    Caption = '...'
    TabOrder = 1
    Visible = False
    OnClick = btnEditClick
  end
end
