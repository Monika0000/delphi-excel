unit TableMenu;

interface

uses
  Vcl.Menus, Forms, System.Classes, MenuManager, FormManager, Table, CommandManager, MainMenu;

procedure InitMenu(menu: TMainMenu);

implementation

procedure SaveMenuButton(Sender: TObject);
begin
  (TFormManager.GetInstance().GetForm(TType.Table) as TTableForm).Save();
end;

procedure RedoMenuButton(Sender: TObject);
begin
  TCmdManager.GetInstance().Redo();
end;

procedure UndoMenuButton(Sender: TObject);
begin
  TCmdManager.GetInstance().Undo();
end;

procedure InitMenu(menu: TMainMenu);
begin
  var fileMenu := MenuManager.AddSubmenu(menu, 'File');
  fileMenu.Add(AddSubmenu(fileMenu, 'New', MainMenu.NewMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Load', MainMenu.LoadMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Save', SaveMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Close', MainMenu.CloseMenuButton));

  var editMenu := MenuManager.AddSubmenu(menu, 'Edit');
  editMenu.Add(AddSubMenu(editMenu, 'Redo', RedoMenuButton));
  editMenu.Add(AddSubMenu(editMenu, 'Undo', UndoMenuButton));

  var helpMenu := MenuManager.AddSubmenu(menu, 'Help');
  helpMenu.Add(AddSubmenu(helpMenu, 'About', MainMenu.AboutMenuButton));
  helpMenu.Add(AddSubmenu(helpMenu, 'Helper', MainMenu.HelperMenuButton));

  gCurrentMenu.Items.Add(fileMenu);
  gCurrentMenu.Items.Add(editMenu);
  gCurrentMenu.Items.Add(helpMenu);
end;

end.
