unit ProductsLists;

interface

uses
  BasicForm, FormManager, MenuManager, MainMenu;

type
  TMainForm = class(BasicForm.TIBasicForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TMainForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);
end;


end.
