unit MainMenu;

interface

uses
  Vcl.Menus, Forms, System.Classes, MenuManager, FormManager, Table, CommandManager;

procedure InitMenu(menu: TMainMenu);

procedure LoadMenuButton(Sender: TObject);
procedure CloseMenuButton(Sender: TObject);
procedure NewMenuButton(Sender: TObject);
procedure AboutMenuButton(Sender: TObject);
procedure HelperMenuButton(Sender: TObject);

implementation

procedure NewMenuButton(Sender: TObject);
begin
  FormManager.Open(FormManager.TType.TableMaster);
end;

procedure LoadMenuButton(Sender: TObject);
begin
  if TTableForm(FormManager.gTableForm).Load() then begin
    FormManager.Open(FormManager.TType.Table);
    CommandManager.gCmdManager.ClearAll();
  end;
end;

procedure CloseMenuButton(Sender: TObject);
begin
  TTableForm(FormManager.gTableForm).Clear();
  FormManager.Open(FormManager.TType.Main);
end;

procedure AboutMenuButton(Sender: TObject);
begin
  FormManager.Open(FormManager.TType.About);
end;

procedure HelperMenuButton(Sender: TObject);
begin
  FormManager.Open(FormManager.TType.Helper);
end;

procedure InitMenu(menu: TMainMenu);
begin
  var helpMenu := MenuManager.AddSubmenu(menu, 'Help');
  helpMenu.Add(AddSubmenu(helpMenu, 'About', AboutMenuButton));
  helpMenu.Add(AddSubmenu(helpMenu, 'Helper', HelperMenuButton));

  gCurrentMenu.Items.Add(helpMenu);
end;

end.
