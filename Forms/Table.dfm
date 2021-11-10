object TableForm: TTableForm
  Left = 0
  Top = 0
  Caption = #1058#1072#1073#1083#1080#1094#1072
  ClientHeight = 466
  ClientWidth = 716
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 716
    Height = 466
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object VisibleTableGrid: TStringGrid
      Left = 1
      Top = 24
      Width = 714
      Height = 441
      Align = alClient
      ColCount = 255
      RowCount = 255
      ParentColor = True
      TabOrder = 0
      OnContextPopup = VisibleTableGridContextPopup
      OnKeyDown = VisibleTableGridKeyDown
      OnSelectCell = VisibleTableGridSelectCell
      OnSetEditText = VisibleTableGridSetEditText
      RowHeights = (
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24
        24)
    end
    object CellEdit: TEdit
      Left = 1
      Top = 1
      Width = 714
      Height = 23
      Align = alTop
      TabOrder = 1
      OnChange = CellEditChange
    end
  end
  object TableGrid: TStringGrid
    Left = 656
    Top = 408
    Width = 40
    Height = 40
    TabOrder = 1
    Visible = False
  end
  object TablePopupMenu: TPopupMenu
    OwnerDraw = True
    Left = 16
    object N8: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1082#1072
      object InsertRowDown: TMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1088#1086#1082#1091' '#1089#1085#1080#1079#1091
        OnClick = InsertRowDownClick
      end
      object InsertRowUp: TMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1088#1086#1082#1091' '#1089#1074#1077#1088#1093#1091
        OnClick = InsertRowUpClick
      end
      object InsertColLeft: TMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094' '#1089#1083#1077#1074#1072
        OnClick = InsertColLeftClick
      end
      object InsertColRight: TMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094' '#1089#1087#1088#1072#1074#1072
        OnClick = InsertColRightClick
      end
    end
    object N9: TMenuItem
      Caption = #1059#1076#1072#1083#1077#1085#1080#1077
      object DeleteRow: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
        OnClick = DeleteRowClick
      end
      object DeleteCol: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094
        OnClick = DeleteColClick
      end
    end
  end
end
