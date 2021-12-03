program Dexel;

uses
  Vcl.Menus,
  Forms,
  System.Classes,
  MainMenu in 'Menu\MainMenu.pas',
  MenuManager in 'Menu\MenuManager.pas',
  FormManager in 'Forms\FormManager.pas',
  MainForm in 'Forms\MainForm.pas' {MainForm},
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
  Helper in 'Forms\Helper.pas' {HelperForm},
  Sorting in 'Forms\Sorting.pas' {SortingForm},
  Singleton in 'Utils\Singleton.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;

  Application.Icon.LoadFromFile(FileSystem.GetExeFolder() + FileSystem.ResourcesFolder + '\dexel.ico');

  TCmdManager.GetInstance().ClearAfter(0);
  TFormManager.GetInstance().Init();

  TFormManager.GetInstance().SetForm(TTableForm.Create(Application), FormManager.TType.Table);
  TFormManager.GetInstance().GetForm(FormManager.Table).SetMenu(TableMenu.InitMenu);

  TFormManager.GetInstance().SetForm(TMainForm.Create(Application), FormManager.TType.Main);
  TFormManager.GetInstance().GetForm(FormManager.Main).SetMenu(MainMenu.InitMenu);

  TFormManager.GetInstance().SetForm(TTableMasterForm.Create(Application), FormManager.TType.TableMaster);
  TFormManager.GetInstance().GetForm(FormManager.TableMaster).SetMenu(MainMenu.InitMenu);

  TFormManager.GetInstance().SetForm(TAboutForm.Create(Application), FormManager.TType.About);
  TFormManager.GetInstance().GetForm(FormManager.About).SetMenu(MainMenu.InitMenu);

  TFormManager.GetInstance().SetForm(THelperForm.Create(Application), FormManager.TType.Helper);
  TFormManager.GetInstance().GetForm(FormManager.Helper).SetMenu(MainMenu.InitMenu);

  TFormManager.GetInstance().SetForm(TSortingForm.Create(Application), FormManager.TType.Sorting);

  TFormManager.GetInstance().Open(FormManager.TType.Main);

  Application.Run;
end.

