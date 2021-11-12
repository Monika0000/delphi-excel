unit About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasicForm, MenuManager, Vcl.ExtCtrls,
  Vcl.StdCtrls, ShellApi, StringUtils, FormManager;

type
  TAboutForm = class(BasicForm.TIBasicForm)
    MainPanel: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    Panel4: TPanel;
    Panel3: TPanel;
    GitHubLinkLabel: TLinkLabel;
    BackButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure GitHubLinkLabelLinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
    procedure BackButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TAboutForm.BackButtonClick(Sender: TObject);
begin
  FormManager.Back();
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);
end;

procedure TAboutForm.GitHubLinkLabelLinkClick(Sender: TObject;
  const Link: string; LinkType: TSysLinkType);
begin
  var raw := string(GitHubLinkLabel.Caption);
  var completeLink := PChar(raw.Substring(3, Length(raw) - 7));
  ShellExecute(handle, 'open', completeLink, nil, nil, SW_SHOWNORMAL);
end;

end.
