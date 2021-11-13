object HelperForm: THelperForm
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 250
  Caption = #1055#1086#1084#1086#1097#1100
  ClientHeight = 441
  ClientWidth = 806
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
    Width = 806
    Height = 441
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 624
    object LeftPanel: TPanel
      Left = 1
      Top = 1
      Width = 200
      Height = 439
      Align = alLeft
      BorderStyle = bsSingle
      Caption = 'Panel3'
      TabOrder = 0
      object BackButton: TButton
        Left = 1
        Top = 409
        Width = 194
        Height = 25
        Align = alBottom
        Caption = #1053#1072#1079#1072#1076
        TabOrder = 0
        OnClick = BackButtonClick
      end
      object SectionListBox: TListBox
        Left = 1
        Top = 1
        Width = 194
        Height = 408
        Align = alClient
        Color = clScrollBar
        ItemHeight = 15
        TabOrder = 1
        OnClick = SectionListBoxClick
      end
    end
    object RightPanel: TPanel
      Left = 201
      Top = 1
      Width = 604
      Height = 439
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 422
      object BottomBorder: TPanel
        Left = 0
        Top = 435
        Width = 604
        Height = 4
        Align = alBottom
        BorderStyle = bsSingle
        Caption = 'Panel5'
        TabOrder = 0
        ExplicitWidth = 422
      end
      object RightBorder: TPanel
        Left = 600
        Top = 33
        Width = 4
        Height = 402
        Align = alRight
        BorderStyle = bsSingle
        Caption = 'Panel5'
        TabOrder = 1
        ExplicitLeft = 418
        ExplicitTop = 40
        ExplicitHeight = 395
      end
      object CaptionPanel: TPanel
        Left = 0
        Top = 0
        Width = 604
        Height = 33
        Align = alTop
        Caption = #1057#1087#1088#1072#1074#1082#1072' '#1087#1086' '#1088#1072#1073#1086#1090#1077' '#1089' Dexel'
        Color = clSilver
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        ExplicitWidth = 649
      end
      object PageControl: TPageControl
        Left = 0
        Top = 33
        Width = 600
        Height = 402
        ActivePage = ExpressionsSection
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -1
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        ExplicitWidth = 645
        object HotKeysSection: TTabSheet
          TabVisible = False
          object Label4: TLabel
            AlignWithMargins = True
            Left = 30
            Top = 55
            Width = 559
            Height = 334
            Margins.Left = 30
            Margins.Top = 55
            Align = alClient
            Caption = '* CTRL+ L - '#1079#1072#1075#1088#1091#1079#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitTop = 40
            ExplicitWidth = 236
            ExplicitHeight = 23
          end
          object Label3: TLabel
            AlignWithMargins = True
            Left = 30
            Top = 30
            Width = 559
            Height = 359
            Margins.Left = 30
            Margins.Top = 30
            Align = alClient
            Caption = '* CTRL+ S - '#1089#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitTop = 20
            ExplicitWidth = 242
            ExplicitHeight = 23
          end
          object Label2: TLabel
            AlignWithMargins = True
            Left = 10
            Top = 5
            Width = 579
            Height = 384
            Margins.Left = 10
            Margins.Top = 5
            Align = alClient
            Caption = #1043#1086#1088#1103#1095#1080#1077' '#1082#1083#1072#1074#1080#1096#1080':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 158
            ExplicitHeight = 25
          end
          object Label1: TLabel
            AlignWithMargins = True
            Left = 30
            Top = 80
            Width = 559
            Height = 309
            Margins.Left = 30
            Margins.Top = 80
            Align = alClient
            Caption = '* CTRL+ Z - '#1086#1090#1084#1077#1085#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitTop = 70
            ExplicitWidth = 244
            ExplicitHeight = 23
          end
          object Label5: TLabel
            AlignWithMargins = True
            Left = 30
            Top = 105
            Width = 559
            Height = 284
            Margins.Left = 30
            Margins.Top = 105
            Align = alClient
            Caption = '* CTRL+ Y - '#1087#1086#1074#1090#1086#1088#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitTop = 90
            ExplicitWidth = 251
            ExplicitHeight = 23
          end
        end
        object ExpressionsSection: TTabSheet
          ImageIndex = 1
          TabVisible = False
          object ExpressionLabel: TLabel
            Left = 0
            Top = 0
            Width = 592
            Height = 392
            Align = alClient
            Caption = 
              #1044#1083#1103' '#1085#1072#1087#1080#1089#1072#1085#1080#1103' '#1084#1072#1090#1077#1084#1072#1090#1080#1095#1077#1089#1082#1080#1093' '#1074#1099#1088#1072#1078#1077#1085#1080#1081' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1074#1074#1077#1089#1090#1080' '#1074' '#1089#1090#1088#1086#1082 +
              #1077' '#1085#1072#1076' '#1090#1072#1073#1083#1080#1094#1077#1081' '#1089#1080#1084#1074#1086#1083' "=" ##'#1044#1083#1103' '#1091#1082#1072#1079#1072#1085#1080#1103' '#1103#1095#1077#1081#1082#1080', '#1085#1072' '#1082#1086#1090#1086#1088#1091#1102' '#1073#1091#1076#1077 +
              #1090' '#1089#1089#1099#1083#1082#1072#1090#1100#1089#1103' '#1092#1086#1088#1084#1091#1083#1072', '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1074#1074#1077#1089#1090#1080' '#1089#1083#1077#1076#1091#1102#1097#1077#1077': #   ['#1085#1086#1084#1077#1088' '#1089#1090 +
              #1088#1086#1082#1080':'#1085#1086#1084#1077#1088' '#1089#1090#1086#1083#1073#1094#1072']##'#1055#1086#1076#1076#1077#1088#1078#1080#1074#1072#1077#1084#1099#1077' '#1086#1087#1077#1088#1072#1090#1086#1088#1099':#   + - * / pow mo' +
              'd abs sin cos tan ctg##'#1055#1088#1080#1084#1077#1088':#   =([1:3] + sin(3)) / 2 pow 6'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            WordWrap = True
            ExplicitWidth = 589
            ExplicitHeight = 115
          end
        end
      end
    end
  end
end
