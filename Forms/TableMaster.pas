unit TableMaster;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasicForm, MenuManager, Vcl.StdCtrls,
  Vcl.ButtonGroup, Vcl.ExtCtrls, IOUtils, FileSystem, StringUtils, Table, FormManager;

type
  TTableMasterForm = class(BasicForm.TIBasicForm)
    MainPanel: TPanel;
    TemplatesListBox: TListBox;
    ListBoxPanel: TPanel;
    SettingsPanel: TPanel;
    Botttom: TPanel;
    LeftCheckBoxes: TPanel;
    Label1: TLabel;
    CreateButton: TButton;
    UseTemplateCheckBox: TCheckBox;
    EnableRepeatsCheckBox: TCheckBox;
    RowsEdit: TEdit;
    Right: TPanel;
    Label2: TLabel;
    ColumnsEdit: TEdit;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure UseTemplateCheckBoxClick(Sender: TObject);
    procedure CreateButtonClick(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

procedure TTableMasterForm.CreateButtonClick(Sender: TObject);
begin
  if RowsEdit.Text = '' then begin
    ShowMessage('Нужно указать количество строк!');
    exit;
  end;

  var colCount := 0;
  var rowCount := StrToInt(RowsEdit.Text);

  var colNames: TArray<string>;

  if UseTemplateCheckBox.Checked then begin
    if (TemplatesListBox.ItemIndex = -1) then begin
      ShowMessage('Нужно выбрать шаблон!');
      exit;
    end;

    // ищем нужный шаблон
    for var path in TDirectory.GetFiles(FileSystem.ResourcesFolder + '\Templates') do begin
      var _file := TStreamReader.Create(path, TEncoding.UTF8);
      try
        if _file.ReadLine = TemplatesListBox.Items[TemplatesListBox.ItemIndex] then
        begin
          colNames := _file.ReadLine.Split([',']);
          colCount := Length(colNames);
        end;
      finally
        FreeAndNil(_file);
      end;
    end;
  end else begin
    if ColumnsEdit.Text = '' then begin
      ShowMessage('Нужно указать количество столбцов!');
      exit;
    end;

    colCount := StrToInt(ColumnsEdit.Text);
  end;

  if (rowCount >= 1000000) or (rowCount >= 1000000) then begin
    ShowMessage('Слишком большая таблица!');
    exit;
  end;

  Table.TTableForm(FormManager.gTableForm).New(rowCount, colCount, EnableRepeatsCheckBox.Checked, colNames);

  FormManager.Open(FormManager.Table);
end;

procedure TTableMasterForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);

  TemplatesListBox.Enabled := False;
  UseTemplateCheckBox.Enabled := True;
  EnableRepeatsCheckBox.Enabled := True;
  ColumnsEdit.Enabled := True;

  TemplatesListBox.Clear();

  for var path in TDirectory.GetFiles(FileSystem.ResourcesFolder + '\Templates') do begin
    var _file := TStreamReader.Create(path, TEncoding.UTF8);

    try
      TemplatesListBox.Items.Add(_file.ReadLine);
    finally
      FreeAndNil(_file);
    end;
  end;
end;

procedure TTableMasterForm.UseTemplateCheckBoxClick(Sender: TObject);
begin
  if UseTemplateCheckBox.Checked then
  begin
    ColumnsEdit.Enabled := False;
    TemplatesListBox.Enabled := True;
    EnableRepeatsCheckBox.Enabled := False;
  end else begin
    ColumnsEdit.Enabled := True;
    TemplatesListBox.Enabled := False;
    EnableRepeatsCheckBox.Enabled := True;
  end;
end;

end.
