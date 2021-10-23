unit Table;

interface

uses
  MenuManager, BasicForm, System.Classes, Vcl.Controls, Vcl.Grids,
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
  private
    procedure OnKeyDown(key: integer);
  private
    procedure SendCommand(ARow, ACol: integer);
  private
    var _editingCol: Integer;
    var _editingRow: Integer;
    var _newLastCellValue: string;
    var _oldLastCellValue: string;
    var _lastCellValue: string;
  public
    procedure New();
    procedure Load(path: string);
    procedure Save(path: string);
    procedure Clear();
  end;

implementation

const gEmptyCell = '###empty###$$$empty$$$%%%empty%%%';

procedure TTableForm.OnKeyDown(key: Integer);
begin
  ShowMessage(IntToStr(key));
end;

procedure TTableForm.SendCommand(ARow, ACol: integer);
begin
  // никаких редактирований не было
  if _oldLastCellValue = gEmptyCell then
    exit;

  if ((ACol <> _editingCol) or (ARow <> _editingRow)) and
    (_editingCol <> -1) and (_editingRow <> -1) then
  begin
    // формируем команду
    var cmd := GridCellCommand.TGridCellCommand.Create(
      TableGrid,
      _editingCol,
      _editingRow,
      _oldLastCellValue,
      _newLastCellValue);

    CommandManager.gCmdManager.Send(cmd);

    // обнуляем старые значения, чтобы повторно не отсылать сообщение
    _oldLastCellValue := gEmptyCell;
  end;
end;

procedure TTableForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);
end;

procedure TTableForm.FormCreate(Sender: TObject);
begin
  New();
  TableGrid.Options := TableGrid.Options + [goEditing] + [goColSizing] + [goTabs];
end;

procedure TTableForm.FormResize(Sender: TObject);
begin
  TableGrid.Width := Self.Width - 13;
  TableGrid.Height := Self.Height - 53;
end;

procedure TTableForm.New();
begin
  Clear();

  var alphovite := ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

  for var i := 1 to TableGrid.RowCount do
  begin
    TableGrid.Rows[i][0] := IntToStr(i);
  end;

  for var i := 0 to TableGrid.ColCount do
  begin
    var offset := i div Length(alphovite);
    TableGrid.Cols[i + 1][0] := alphovite[i - Length(alphovite) * offset];
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

procedure TTableForm.TableGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    SendCommand(ARow, ACol);

    _lastCellValue := TableGrid.Rows[ARow][ACol];
end;

procedure TTableForm.TableGridSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  if _oldLastCellValue = gEmptyCell then
    _oldLastCellValue := _lastCellValue;

  _editingCol := ACol;
  _editingRow := ARow;
  _newLastCellValue := Value;
end;

procedure TTableForm.Clear();
begin
  _editingCol := -1;
  _editingRow := -1;
  _oldLastCellValue := '';
  _newLastCellValue := gEmptyCell;
end;

{$R *.dfm}

end.
