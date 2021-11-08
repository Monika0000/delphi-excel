unit MainMenu;

interface

uses
  Vcl.Menus, Forms, System.Classes, MenuManager, FormManager, Table, CommandManager;

procedure InitMenu(menu: TMainMenu);

procedure LoadMenuButton(Sender: TObject);
procedure CloseMenuButton(Sender: TObject);
procedure NewMenuButton(Sender: TObject);

implementation

procedure NewMenuButton(Sender: TObject);
begin
  FormManager.Open(FormManager.TType.TableMaster);
end;

procedure LoadMenuButton(Sender: TObject);
begin
  TTableForm(FormManager.gTableForm).Load();
  FormManager.Open(FormManager.TType.Table);
  CommandManager.gCmdManager.ClearAll();
end;

procedure CloseMenuButton(Sender: TObject);
begin
  TTableForm(FormManager.gTableForm).Clear();
  FormManager.Open(FormManager.TType.Main);
end;

procedure InitMenu(menu: TMainMenu);
begin
  var fileMenu := MenuManager.AddSubmenu(menu, 'File');
  fileMenu.Add(AddSubmenu(fileMenu, 'New', NewMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Load', LoadMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Close', CloseMenuButton));

  gCurrentMenu.Items.Add(fileMenu);
end;

end.
