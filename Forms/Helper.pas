unit Helper;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasicForm, MenuManager, Vcl.ExtCtrls,
  Vcl.StdCtrls, FormManager, System.Generics.Collections, Vcl.ComCtrls;

type
  THelperForm = class(BasicForm.TIBasicForm)
    Panel1: TPanel;
    LeftPanel: TPanel;
    BackButton: TButton;
    RightPanel: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BottomBorder: TPanel;
    RightBorder: TPanel;
    CaptionPanel: TPanel;
    SectionListBox: TListBox;
    Label1: TLabel;
    Label5: TLabel;
    PageControl: TPageControl;
    HotKeysSection: TTabSheet;
    ExpressionsSection: TTabSheet;
    ExpressionLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure SectionListBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    _sections: TDictionary<string, &TTabSheet>;

    procedure HideAll();
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure THelperForm.HideAll();
begin
  for var Key in _sections.Keys do begin
    _sections[Key].Hide();
  end;
end;

procedure THelperForm.BackButtonClick(Sender: TObject);
begin
  FormManager.Back();
end;

procedure THelperForm.FormCreate(Sender: TObject);
begin
  _sections := TDictionary<string, &TTabSheet>.Create();

  _sections.Add('Горячие клавиши', HotKeysSection);
  _sections.Add('Выражения', ExpressionsSection);

  HideAll();

  ExpressionLabel.Caption := string(ExpressionLabel.Caption).Replace('#', #10);

  for var Key in _sections.Keys do
    SectionListBox.Items.Add(Key);
end;

procedure THelperForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);
end;

procedure THelperForm.SectionListBoxClick(Sender: TObject);
begin
  HideAll();

  if SectionListBox.ItemIndex = -1 then
    exit;

  var selected := SectionListBox.Items.Strings[SectionListBox.ItemIndex];

  if _sections.ContainsKey(selected) then begin
    _sections[selected].Show();
  end;
end;

end.
