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
  TFormManager.GetInstance().Open(FormManager.TType.TableMaster);
end;

procedure LoadMenuButton(Sender: TObject);
begin
  if TTableForm(TFormManager.GetInstance().GetForm(TType.Table)).Load() then begin
    TFormManager.GetInstance().Open(FormManager.TType.Table);
    TCmdManager.GetInstance().ClearAll();
  end;
end;

procedure CloseMenuButton(Sender: TObject);
begin
  TTableForm(TFormManager.GetInstance().GetForm(TType.Table)).Clear();
  TFormManager.GetInstance().Open(FormManager.TType.Main);
end;

procedure AboutMenuButton(Sender: TObject);
begin
  TFormManager.GetInstance().Open(FormManager.TType.About);
end;

procedure HelperMenuButton(Sender: TObject);
begin
  TFormManager.GetInstance().Open(FormManager.TType.Helper);
end;

procedure InitMenu(menu: TMainMenu);
begin
  var helpMenu := MenuManager.AddSubmenu(menu, 'Help');
  helpMenu.Add(AddSubmenu(helpMenu, 'About', AboutMenuButton));
  helpMenu.Add(AddSubmenu(helpMenu, 'Helper', HelperMenuButton));

  gCurrentMenu.Items.Add(helpMenu);
end;

end.
