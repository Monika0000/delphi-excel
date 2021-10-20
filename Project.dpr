program Project;

uses
  Vcl.Forms,
  ProductsLists in 'ProductsLists.pas' {MainForm},
  FormManager in 'FormManager.pas',
  Table in 'Table.pas' {TableForm},
  MainMenu in 'Menu\MainMenu.pas',
  MenuManager in 'Menu\MenuManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  FormManager.gTableForm := TTableForm.Create(Application);
  FormManager.gMainForm := TMainForm.Create(Application);

  FormManager.Open(FormManager.TType.Main);

  Application.Run;
end.

