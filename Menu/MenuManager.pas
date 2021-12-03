unit MenuManager;

interface

uses
  Vcl.Menus, Forms, System.Classes, Singleton;

type
  TClickCallBack = procedure(Sender: TObject);
  TMenuInitProc = procedure(menu: TMainMenu);

var
  gCurrentMenu: TMainMenu = nil;

function AddSubmenu(ovner: TComponent; caption: string; onClick: TClickCallBack = nil): TMenuItem;
procedure InitMenu(ovner: TComponent; initProc: TMenuInitProc);

implementation

function AddSubmenu(ovner: TComponent; caption: string; onClick: TClickCallBack = nil): TMenuItem;
begin
  var item: TMenuItem := TMenuItem.Create(ovner);
  item.Caption := caption;
  item.Enabled := True;

  var notify: TNotifyEvent := nil;
  @notify := @onClick;
  item.OnClick := notify;

  AddSubmenu := item;
end;

procedure InitMenu(ovner: TComponent; initProc: TMenuInitProc);
begin
  if gCurrentMenu <> nil then
    gCurrentMenu.Destroy();

  gCurrentMenu := TMainMenu.Create(ovner);

  initProc(gCurrentMenu);
end;

end.
