unit MainMenu;

interface

uses
  Vcl.Menus, Forms, System.Classes, MenuManager, FormManager;

procedure InitMainMenu(menu: TMainMenu);

implementation

procedure NewMenuButton(Sender: TObject);
begin
  FormManager.Open(FormManager.TType.Table);
end;

procedure LoadMenuButton(Sender: TObject);
begin
  FormManager.Open(FormManager.TType.Table);
end;

procedure SaveMenuButton(Sender: TObject);
begin

end;

procedure SaveAsMenuButton(Sender: TObject);
begin

end;

procedure CloseMenuButton(Sender: TObject);
begin
  FormManager.Open(FormManager.TType.Main);
end;

procedure InitMainMenu(menu: TMainMenu);
begin
  var fileMenu := MenuManager.AddSubmenu(menu, 'File');
  fileMenu.Add(AddSubmenu(fileMenu, 'New', NewMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Load', LoadMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Save', SaveMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Save As', SaveAsMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Close', CloseMenuButton));

  gCurrentMenu.Items.Add(fileMenu);
end;

end.
