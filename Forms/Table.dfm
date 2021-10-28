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
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object TableGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 708
    Height = 462
    ColCount = 255
    RowCount = 255
    ParentColor = True
    TabOrder = 0
    OnContextPopup = TableGridContextPopup
    OnKeyDown = TableGridKeyDown
    OnSelectCell = TableGridSelectCell
    OnSetEditText = TableGridSetEditText
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
  object TablePopupMenu: TPopupMenu
    OwnerDraw = True
    Left = 24
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
      end
      object InsertColRight: TMenuItem
        Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094' '#1089#1087#1088#1072#1074#1072
      end
    end
    object N9: TMenuItem
      Caption = #1059#1076#1072#1083#1077#1085#1080#1077
      object N5: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
        OnClick = DeleteRowButton
      end
      object N7: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1086#1083#1073#1077#1094
      end
    end
  end
end
