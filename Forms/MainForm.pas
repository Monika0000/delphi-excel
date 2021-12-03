unit MainForm;

interface

uses
  BasicForm, FormManager, MenuManager, MainMenu, Vcl.Controls, Vcl.ExtCtrls,
  System.Classes, Vcl.StdCtrls, Table, CommandManager, Vcl.Imaging.jpeg, Forms,
  System.ImageList, Vcl.ImgList, Vcl.Buttons;

type
  TMainForm = class(BasicForm.TIBasicForm)
    NewTableButton: TButton;
    Panel1: TPanel;
    Panel3: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    ExitButton: TButton;
    LoadTableButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure NewTableButtonClick(Sender: TObject);
    procedure LoadTableButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TMainForm.ExitButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);
end;


procedure TMainForm.LoadTableButtonClick(Sender: TObject);
begin
  if TTableForm(TFormManager.GetInstance().GetForm(TType.Table)).Load() then begin
    TFormManager.GetInstance().Open(FormManager.TType.Table);
    TCmdManager.GetInstance().ClearAll();
  end;
end;

procedure TMainForm.NewTableButtonClick(Sender: TObject);
begin
  TFormManager.GetInstance().Open(FormManager.TType.TableMaster);
end;

end.
