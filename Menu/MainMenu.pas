unit MainMenu;

interface

uses
  Vcl.Menus, Forms, System.Classes, MenuManager, FormManager, Table, CommandManager;

procedure InitMainMenu(menu: TMainMenu);

implementation

procedure NewMenuButton(Sender: TObject);
begin
  //var colNames: Table.ColNamesArray := ['Aboba', 'Fofo', 'Fofo', 'sadas'];
  //Table.TTableForm(FormManager.gTableForm).New(3, 5, true, colNames);

  FormManager.Open(FormManager.TType.TableMaster);
end;

procedure LoadMenuButton(Sender: TObject);
begin
  TTableForm(FormManager.gTableForm).Load('none');
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
  TTableForm(FormManager.gTableForm).Clear();
  FormManager.Open(FormManager.TType.Main);
end;

procedure RedoMenuButton(Sender: TObject);
begin
  CommandManager.gCmdManager.Redo();
end;

procedure UndoMenuButton(Sender: TObject);
begin
  CommandManager.gCmdManager.Undo();
end;

procedure InitMainMenu(menu: TMainMenu);
begin
  var fileMenu := MenuManager.AddSubmenu(menu, 'File');
  fileMenu.Add(AddSubmenu(fileMenu, 'New', NewMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Load', LoadMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Save', SaveMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Save As', SaveAsMenuButton));
  fileMenu.Add(AddSubmenu(fileMenu, 'Close', CloseMenuButton));

  var editMenu := MenuManager.AddSubmenu(menu, 'Edit');
  editMenu.Add(AddSubMenu(editMenu, 'Redo', RedoMenuButton));
  editMenu.Add(AddSubMenu(editMenu, 'Undo', UndoMenuButton));

  gCurrentMenu.Items.Add(fileMenu);
  gCurrentMenu.Items.Add(editMenu);
end;

end.
