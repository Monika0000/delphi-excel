unit Table;

interface

uses
  MenuManager, MainMenu, BasicForm;

type
  TTableForm = class(BasicForm.TIBasicForm)
    procedure FormShow(Sender: TObject);
  private
  public
    procedure Load(var path: string);
    procedure Save(var path: string);
    procedure Clear();
    { Public declarations }
  end;

implementation

procedure TTableForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, MainMenu.InitMainMenu);
end;

procedure TTableForm.Load(var path: string);
begin
  //
end;

procedure TTableForm.Save(var path: string);
begin
  //
end;

procedure TTableForm.Clear();
begin
  //
end;

{$R *.dfm}

end.
