unit Table;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, MenuManager, MainMenu;

type
  TTableForm = class(TForm)
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
