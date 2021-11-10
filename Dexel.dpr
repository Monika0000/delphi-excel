program Dexel;

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
  ColCommand in 'Utils\ColCommand.pas',
  TableMenu in 'Menu\TableMenu.pas' {$R *.res},
  Expression in 'Utils\Expression.pas',
  About in 'Forms\About.pas' {AboutForm},
  Helper in 'Forms\Helper.pas' {HelperForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;

  Application.Icon.LoadFromFile(FileSystem.GetExeFolder() + FileSystem.ResourcesFolder + '\dexel.ico');

  CommandManager.Init();

  FormManager.gTableForm := TTableForm.Create(Application);
  FormManager.gTableForm.SetMenu(TableMenu.InitMenu);

  FormManager.gMainForm := TMainForm.Create(Application);
  FormManager.gMainForm.SetMenu(MainMenu.InitMenu);

  FormManager.gTableMasterForm := TTableMasterForm.Create(Application);
  FormManager.gTableMasterForm.SetMenu(MainMenu.InitMenu);

  FormManager.gAboutForm := TAboutForm.Create(Application);
  FormManager.gAboutForm.SetMenu(MainMenu.InitMenu);

  FormManager.gHelperForm := THelperForm.Create(Application);
  FormManager.gHelperForm.SetMenu(MainMenu.InitMenu);

  FormManager.Open(FormManager.TType.Main);

  Application.Run;
end.

