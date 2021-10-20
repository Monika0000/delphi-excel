program Project;

uses
  Vcl.Menus,
  Forms,
  System.Classes,
  MainMenu in 'Menu\MainMenu.pas',
  MenuManager in 'Menu\MenuManager.pas',
  FormManager in 'Forms\FormManager.pas',
  ProductsLists in 'Forms\ProductsLists.pas' {MainForm},
  Table in 'Forms\Table.pas' {TableForm},
  BasicForm in 'Forms\BasicForm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;

  FormManager.gTableForm := TTableForm.Create(Application);
  FormManager.gMainForm := TMainForm.Create(Application);

  FormManager.Open(FormManager.TType.Main);

  Application.Run;
end.

