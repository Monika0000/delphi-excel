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
  BasicForm in 'Forms\BasicForm.pas',
  CommandManager in 'Utils\CommandManager.pas',
  GridCellCommand in 'Utils\GridCellCommand.pas' {$R *.res},
  TableMaster in 'Forms\TableMaster.pas' {TableMasterForm},
  Types in 'Utils\Types.pas',
  FileSystem in 'Utils\FileSystem.pas',
  StringUtils in 'Utils\StringUtils.pas',
  RowCommand in 'Utils\RowCommand.pas',
  ColCommand in 'Utils\ColCommand.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;

  CommandManager.Init();

  FormManager.gTableForm := TTableForm.Create(Application);
  FormManager.gTableForm.SetMenu(MainMenu.InitMainMenu);

  FormManager.gMainForm := TMainForm.Create(Application);
  FormManager.gMainForm.SetMenu(MainMenu.InitMainMenu);

  FormManager.gTableMasterForm := TTableMasterForm.Create(Application);
  FormManager.gTableMasterForm.SetMenu(MainMenu.InitMainMenu);

  FormManager.Open(FormManager.TType.Main);

  Application.Run;
end.

