unit Table;

interface

uses
  MenuManager, BasicForm, System.Classes, Vcl.Controls, Vcl.Grids, Winapi.Windows,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.SysUtils, CommandManager, GridCellCommand;

type
  TTableForm = class(BasicForm.TIBasicForm)
    TableGrid: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SetSize(rows, cols: Integer);
    procedure TableGridSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure TableGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure TableGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    var _lastCellValue: string;
  public
    procedure New(rows, cols: integer; _repeat: boolean; colNames: TArray<string> = nil);
    procedure Load(path: string);
    procedure Save(path: string);
    procedure Clear();
  end;

implementation

const gEmptyCell = '###empty###$$$empty$$$%%%empty%%%';

procedure TTableForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);
end;

procedure TTableForm.FormCreate(Sender: TObject);
begin
  TableGrid.Options := TableGrid.Options + [goEditing] + [goColSizing] + [goTabs];
end;

procedure TTableForm.FormResize(Sender: TObject);
begin
  TableGrid.Width := Self.Width - 13;
  TableGrid.Height := Self.Height - 58;
end;

procedure TTableForm.New(rows, cols: integer; _repeat: boolean; colNames: TArray<string>);
begin
  CommandManager.gCmdManager.ClearAll();

  Clear();

  TableGrid.RowCount := rows + 1;
  TableGrid.ColCount := cols + 1;

  var _colNames: TArray<string>;

  if colNames = nil then
    _colNames :=  ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
  else
    _colNames := colNames;

  for var i := 1 to TableGrid.RowCount do
  begin
    TableGrid.Rows[i][0] := IntToStr(i);
  end;

  if _repeat then begin
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

procedure TTableForm.SetSize(rows: Integer; cols: Integer);
begin
  //
end;

procedure TTableForm.Load(path: string);
begin
  //
end;

procedure TTableForm.Save(path: string);
begin
  //
end;

procedure TTableForm.TableGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (GetKeyState(VK_CONTROL) < 0) then begin
    if key = 90 then // Z
      CommandManager.gCmdManager.Undo()
    else if key = 89 then // Y
      CommandManager.gCmdManager.Redo();
  end;
end;

procedure TTableForm.TableGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  _lastCellValue := TableGrid.Rows[ARow][ACol];
end;

procedure TTableForm.TableGridSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  var top := gCmdManager.Top();

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
    Value);

  CommandManager.gCmdManager.Send(cmd);
end;

procedure TTableForm.Clear();
begin
  with TableGrid do
    for var i := FixedCols to ColCount - 1 do
      for var j := FixedRows to RowCount - 1 do
        Cells[i, j] := '';
end;

{$R *.dfm}

end.
