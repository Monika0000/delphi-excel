unit Table;

interface

uses
  MenuManager, BasicForm, System.Classes, Vcl.Controls, Vcl.Grids, Winapi.Windows,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.SysUtils, CommandManager, GridCellCommand,
  Vcl.Menus, Types, RowCommand, ColCommand, FileSystem, System.JSON,
  Vcl.ExtCtrls, Expression, FormManager;

type
  TTableForm = class(BasicForm.TIBasicForm)
    VisibleTableGrid: TStringGrid;
    TablePopupMenu: TPopupMenu;
    InsertRowUp: TMenuItem;
    InsertColLeft: TMenuItem;
    InsertRowDown: TMenuItem;
    InsertColRight: TMenuItem;
    DeleteRow: TMenuItem;
    DeleteCol: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Panel1: TPanel;
    CellEdit: TEdit;
    TableGrid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SetSize(rows, cols: Integer);
    procedure VisibleTableGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      Value: string);
    procedure VisibleTableGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure VisibleTableGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VisibleTableGridContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure InsertRowDownClick(Sender: TObject);
    procedure InsertRowUpClick(Sender: TObject);
    procedure InsertColLeftClick(Sender: TObject);
    procedure InsertColRightClick(Sender: TObject);
    procedure DeleteRowClick(Sender: TObject);
    procedure DeleteColClick(Sender: TObject);
    procedure CellEditChange(Sender: TObject);
  private
    procedure DeselectCells();
    procedure EnumerateRows();
    procedure EnumerateCols();
    procedure UpdateCellEdit();
    procedure UpdateVisible(cell: TPoint);
  private
    var _popupCell: TPoint;
    var _lastCellValue: string;
    var _selectedCell: TPoint;
    var _colNames: TArray<string>;
    var _repeatNames: boolean;
    var _defaultNames: boolean;
  public
    procedure New(rows, cols: integer; _repeat: boolean; colNames: TArray<string> = nil);
    function Load(): boolean;
    procedure Save();
    procedure Clear();
  end;

implementation

procedure TTableForm.UpdateVisible(cell: TPoint);
begin
  if cell = TPoint.Create(-1, -1) then
  begin
    VisibleTableGrid.ColCount := TableGrid.ColCount;
    VisibleTableGrid.RowCount := TableGrid.RowCount;
    for var i := 0 to VisibleTableGrid.ColCount do
      for var j := 0 to VisibleTableGrid.RowCount do
        Expression.MathCell(TableGrid, VisibleTableGrid, TPoint.Create(i, j))
  end else begin
    Expression.MathCell(TableGrid, VisibleTableGrid, cell);
  end;
end;

procedure TTableForm.UpdateCellEdit();
begin
  if (_selectedCell.X = -1) or (_selectedCell.Y = -1) then begin
    CellEdit.Text := '';
    exit;
  end;

  CellEdit.Text := TableGrid.Cols[_selectedCell.X][_selectedCell.Y];
end;

procedure TTableForm.EnumerateCols();
begin
  if _repeatNames then begin
    for var i := 0 to TableGrid.ColCount do
    begin
      var offset := i div Length(_colNames);
      TableGrid.Cols[i + 1][0] := _colNames[i - Length(_colNames) * offset];
    end;
  end else begin
    var min := Length(_colNames);

    if min > TableGrid.ColCount then
      min := TableGrid.ColCount;

    for var i := 0 to min - 1 do
      TableGrid.Cols[i + 1][0] := _colNames[i];
  end;
end;

procedure TTableForm.DeselectCells();
begin
  var rect: TGridRect;
   with rect do begin
    Left := -1;
    Top := -1;
    Right := -1;
    Bottom := -1;
  end;
  TableGrid.Selection := rect;
  _selectedCell := TPoint.Create(-1, -1);
  UpdateCellEdit();
end;

procedure TTableForm.DeleteColClick(Sender: TObject);
begin
  // мы не можем удалить нумерованный столбец
  if _popupCell.X = 0 then
    exit;

  var cmd := ColCommand.TColCommand.Create(TableGrid, _popupCell.X, procedure()
    begin
      DeselectCells();
      if _defaultNames then
        EnumerateCols();
      UpdateVisible(TPoint.Create(-1, -1));
    end);

  cmd.Redo();
  CommandManager.gCmdManager.Send(cmd);
end;

procedure TTableForm.DeleteRowClick(Sender: TObject);
begin
  // мы не можем удалить строку названий колонок
  if _popupCell.Y = 0 then
    exit;

  var cmd := RowCommand.TRowCommand.Create(TableGrid, _popupCell.Y, procedure()
    begin
      EnumerateRows();
      DeselectCells();
      UpdateVisible(TPoint.Create(-1, -1));
    end);

  cmd.Redo();
  CommandManager.gCmdManager.Send(cmd);
end;

procedure TTableForm.EnumerateRows();
begin
  for var i := 1 to TableGrid.RowCount do
  begin
    TableGrid.Rows[i][0] := IntToStr(i);
  end;
end;

procedure TTableForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);
  DeselectCells();
  UpdateVisible(TPoint.Create(-1, -1));
end;

procedure TTableForm.InsertColLeftClick(Sender: TObject);
begin
  var cmd := ColCommand.TColCommand.Create(TableGrid, _popupCell.X, procedure()
    begin
      DeselectCells();
      if _defaultNames then
        EnumerateCols();
      UpdateVisible(TPoint.Create(-1, -1));
    end, ColCommand.Left
  );

  cmd.Redo();
  CommandManager.gCmdManager.Send(cmd);
end;

procedure TTableForm.InsertColRightClick(Sender: TObject);
begin
  var cmd := ColCommand.TColCommand.Create(TableGrid, _popupCell.X, procedure()
    begin
      DeselectCells();
      if _defaultNames then
        EnumerateCols();
      UpdateVisible(TPoint.Create(-1, -1));
    end, ColCommand.Right
  );

  cmd.Redo();
  CommandManager.gCmdManager.Send(cmd);
end;

procedure TTableForm.InsertRowDownClick(Sender: TObject);
begin
  var cmd := RowCommand.TRowCommand.Create(TableGrid, _popupCell.Y, procedure()
    begin
      EnumerateRows();
      DeselectCells();
      UpdateVisible(TPoint.Create(-1, -1));
    end, RowCommand.Down
  );

  cmd.Redo();
  CommandManager.gCmdManager.Send(cmd);
end;

procedure TTableForm.InsertRowUpClick(Sender: TObject);
begin
  // мы не можем вставить строку над полосой названий колонок
  if _popupCell.Y <= 1 then
    exit;

  var cmd := RowCommand.TRowCommand.Create(TableGrid, _popupCell.Y, procedure()
    begin
      EnumerateRows();
      DeselectCells();
      UpdateVisible(TPoint.Create(-1, -1));
    end, RowCommand.Up
  );

  cmd.Redo();
  CommandManager.gCmdManager.Send(cmd);
end;

procedure TTableForm.FormCreate(Sender: TObject);
begin
  VisibleTableGrid.PopupMenu := TablePopupMenu;
  VisibleTableGrid.Options := TableGrid.Options + [goEditing] + [goColSizing] + [goTabs];
end;

procedure TTableForm.New(rows, cols: integer; _repeat: boolean; colNames: TArray<string>);
begin
  CommandManager.gCmdManager.ClearAll();

  Clear();

  TableGrid.RowCount := rows + 1;
  TableGrid.ColCount := cols + 1;

  _repeatNames := _repeat;

  if colNames = nil then
  begin
    _defaultNames := true;
    _colNames :=  ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
  end
  else
  begin
    _colNames := colNames;
    _defaultNames := false;
  end;

  EnumerateRows();
  EnumerateCols();
  DeselectCells();
  UpdateVisible(TPoint.Create(-1, -1));
end;

procedure TTableForm.SetSize(rows: Integer; cols: Integer);
begin
  //
end;

function TTableForm.Load(): boolean;
begin
  var filename := FileSystem.DialogLoadFile();
  if filename = '' then begin
    Result := false;
    exit;
  end;

  var _file := TStreamReader.Create(filename, TEncoding.UTF8);
  try
    var json := TJSonObject.ParseJSONValue(_file.ReadToEnd) as TJSONObject;  

    Self._repeatNames := json.GetValue('useRepeatNames').Value = 'true';
    Self._defaultNames := json.GetValue('useDefaultNames').Value = 'true';
                                                       
    FileSystem.JsonToStringGrid(Self.TableGrid, json);

    VisibleTableGrid.ColCount := TableGrid.ColCount;

    for var col := 0 to TableGrid.ColCount - 1 do
      VisibleTableGrid.ColWidths[col] := TableGrid.ColWidths[col];

    if _defaultNames then
      EnumerateCols();

    EnumerateRows();
    DeselectCells();
    UpdateVisible(TPoint.Create(-1, -1));
    
    json.Free;
  except
    on ex: Exception do begin
      ShowMessage('Failed to load save! Path: ' + filename + ' Reason: ' + ex.Message);
      Result := false;
      FreeAndNil(_file);
      exit;
    end;
  end;

  Result := true;
  FreeAndNil(_file);
end;

procedure TTableForm.Save();
begin
  for var col := 0 to TableGrid.ColCount - 1 do
    TableGrid.ColWidths[col] := VisibleTableGrid.ColWidths[col];

  var json := FileSystem.StringGridToJson(TableGrid);

  json.AddPair('useDefaultNames', _defaultNames);
  json.AddPair('useRepeatNames', _repeatNames);
  FileSystem.DialogSaveFile(FileSystem.FormatJSON(json.ToString()));

  FreeAndNil(json);
end;

procedure TTableForm.VisibleTableGridContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  (Sender as TStringGrid).MouseToCell(MousePos.X, MousePos.Y, _popupCell.X, _popupCell.Y);
end;

procedure TTableForm.VisibleTableGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (GetKeyState(VK_CONTROL) < 0) then begin
    if key = 90 then // Z
      CommandManager.gCmdManager.Undo()
    else if key = 89 then // Y
      CommandManager.gCmdManager.Redo()
    else if key = 83 then // S
      Self.Save()
    else if key = 76 then // L
      Self.Load()
    else if key = 70 then // F
      FormManager.Open(FormManager.Sorting);
  end;
end;

procedure TTableForm.VisibleTableGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  _lastCellValue := TableGrid.Rows[ARow][ACol];

  _selectedCell := TPoint.Create(ACol, ARow);
  UpdateCellEdit();
end;

procedure TTableForm.VisibleTableGridSetEditText(Sender: TObject; ACol, ARow: Integer; Value: string);
begin
  if (Value.IndexOf('=') = 0) and (Sender <> nil) then begin
    ShowMessage('Формулы можно вводить только в верхнем поле!');
    VisibleTableGrid.Cols[ACol][ARow] := '';
    Value := '';
  end;

  TableGrid.Cols[ACol][ARow] := Value;

  var top := gCmdManager.Top();

  if Sender <> nil then
    UpdateCellEdit()
  else
    UpdateVisible(TPoint.Create(ACol, ARow));

  if (top <> nil) and (top is GridCellCommand.TGridCellCommand) then
  begin
    var cmd := GridCellCommand.TGridCellCommand(top);
    if (cmd.GetColumn() = ACol) and (cmd.GetRow() = ARow) then
    begin
      cmd.Update(Value);
      exit;
    end;
  end;

  var cmd := GridCellCommand.TGridCellCommand.Create(
    TableGrid,
    ACol,
    ARow,
    _lastCellValue,
    Value,
    procedure() begin
      UpdateCellEdit();
      UpdateVisible(TPoint.Create(ACol, ARow));
    end);

  CommandManager.gCmdManager.Send(cmd);
end;

procedure TTableForm.CellEditChange(Sender: TObject);
begin
  if (_selectedCell.X = -1) or (_selectedCell.Y = -1) or (not CellEdit.Focused) then
    exit;

  VisibleTableGridSetEditText(nil, _selectedCell.X, _selectedCell.Y, CellEdit.Text);
end;

procedure TTableForm.Clear();
begin
  for var col := 0 to TableGrid.ColCount - 1 do
    VisibleTableGrid.ColWidths[col] := VisibleTableGrid.DefaultColWidth;

  with TableGrid do
    for var i := FixedCols to ColCount - 1 do
      for var j := FixedRows to RowCount - 1 do
        Cells[i, j] := '';

  DeselectCells();
  UpdateVisible(TPoint.Create(-1, -1));
end;

{$R *.dfm}

end.
