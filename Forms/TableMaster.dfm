object TableMasterForm: TTableMasterForm
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 250
  Anchors = [akLeft, akTop, akRight]
  Caption = #1052#1072#1089#1090#1077#1088' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1090#1072#1073#1083#1080#1094
  ClientHeight = 466
  ClientWidth = 774
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 774
    Height = 466
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 80
    ExplicitTop = 30
    ExplicitWidth = 393
    ExplicitHeight = 377
    object ListBoxPanel: TPanel
      Left = 1
      Top = 1
      Width = 222
      Height = 464
      Align = alLeft
      Color = clSilver
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 220
        Height = 15
        Align = alTop
        Alignment = taCenter
        Caption = #1064#1072#1073#1083#1086#1085#1099
        ExplicitWidth = 54
      end
      object ListBox1: TListBox
        Left = 1
        Top = 16
        Width = 220
        Height = 447
        Align = alClient
        Color = 14803425
        ItemHeight = 15
        TabOrder = 0
        ExplicitLeft = 8
        ExplicitTop = 15
        ExplicitWidth = 203
      end
    end
    object SettingsPanel: TPanel
      Left = 223
      Top = 1
      Width = 550
      Height = 464
      Align = alClient
      Color = clSilver
      ParentBackground = False
      TabOrder = 1
      ExplicitLeft = 191
      ExplicitTop = 17
      object Botttom: TPanel
        Left = 1
        Top = 304
        Width = 548
        Height = 159
        Align = alBottom
        Color = clAppWorkSpace
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 585
        object LeftCheckBoxes: TPanel
          Left = 1
          Top = 1
          Width = 272
          Height = 157
          Align = alLeft
          TabOrder = 0
          ExplicitLeft = 4
          ExplicitTop = -7
          object Button1: TButton
            Left = 1
            Top = 1
            Width = 270
            Height = 56
            Align = alTop
            Caption = #1057#1086#1079#1076#1072#1090#1100
            TabOrder = 0
          end
          object CheckBox1: TCheckBox
            Left = 12
            Top = 81
            Width = 149
            Height = 17
            Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1096#1072#1073#1083#1086#1085
            TabOrder = 1
          end
          object CheckBox3: TCheckBox
            Left = 12
            Top = 111
            Width = 237
            Height = 17
            Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1086#1074#1090#1086#1088#1077#1085#1080#1077' '#1080#1084#1077#1085' '#1089#1090#1086#1083#1073#1094#1086#1074
            TabOrder = 2
          end
        end
        object Right: TPanel
          Left = 273
          Top = 1
          Width = 274
          Height = 157
          Align = alClient
          TabOrder = 1
          ExplicitLeft = 328
          ExplicitWidth = 219
          object Label2: TLabel
            Left = 16
            Top = 16
            Width = 40
            Height = 23
            Caption = #1057#1090#1088#1086#1082#1080
          end
          object Label3: TLabel
            Left = 16
            Top = 43
            Width = 50
            Height = 15
            Caption = #1057#1090#1086#1083#1073#1094#1099
          end
          object Edit1: TEdit
            Left = 72
            Top = 14
            Width = 113
            Height = 23
            Color = clWhite
            TabOrder = 0
          end
          object Edit2: TEdit
            Left = 72
            Top = 43
            Width = 113
            Height = 23
            Color = clWhite
            TabOrder = 1
          end
        end
      end
    end
  end
end