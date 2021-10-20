unit ProductsLists;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, FormManager, MenuManager, MainMenu;

type
  TMainForm = class(TForm)
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
  MenuManager.InitMenu(Self, MainMenu.InitMainMenu);
end;

end.
