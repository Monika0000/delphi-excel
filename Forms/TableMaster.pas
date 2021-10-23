unit TableMaster;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasicForm, MenuManager, Vcl.StdCtrls,
  Vcl.ButtonGroup, Vcl.ExtCtrls;

type
  TTableMasterForm = class(BasicForm.TIBasicForm)
    MainPanel: TPanel;
    ListBox1: TListBox;
    ListBoxPanel: TPanel;
    SettingsPanel: TPanel;
    Botttom: TPanel;
    LeftCheckBoxes: TPanel;
    Label1: TLabel;
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    Edit1: TEdit;
    Right: TPanel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

procedure TTableMasterForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);
end;

end.
