unit RowCommand;

interface

uses CommandManager, Vcl.Grids, System.Classes, Vcl.Dialogs, Expression, Winapi.Windows;

type TPlace = (PlaceNone = 0, Up = 1, Down = 2);

type TCallBack = reference to procedure();

type TRowCommand = class(TICommand)
  public
    constructor Create(grid: &TStringGrid; row: integer; callback: TCallBack; place: TPlace); overload;
    constructor Create(grid: &TStringGrid; row: integer; callback: TCallBack); overload;
    procedure Redo(); override;
    procedure Undo(); override;
  private
    procedure InsertRowDown();
    procedure InsertRowUp();
    procedure DeleteRow();
  private
    var _grid: &TStringGrid;
    var _place: TPlace;
    var _row: integer;
    var _callback: TCallBack;
    var _rowData: TArray<string>;
end;

implementation

procedure TRowCommand.InsertRowDown();
begin
  with _grid do
  begin
    RowCount := RowCount + 1;

    for var i := RowCount downto _row + 1 do
      for var j := 1 to ColCount do
        Rows[i + 1][j] := Rows[i][j];

    for var i := 1 to ColCount do
      Rows[_row + 1][i] := '';
  end;
  Expression.OffsetExpressions(_grid, TPoint.Create(_row + 2, 1), TPoint.Create(1, 0))
end;

procedure TRowCommand.InsertRowUp();
begin
  with _grid do
  begin
    RowCount := RowCount + 1;

    for var i := RowCount downto _row do
      for var j := 1 to ColCount do
        Rows[i + 1][j] := Rows[i][j];

    for var i := 1 to ColCount do
      Rows[_row][i] := '';
  end;
  Expression.OffsetExpressions(_grid, TPoint.Create(_row + 1, 1), TPoint.Create(1, 0))
end;

procedure TRowCommand.DeleteRow();
begin
  with _grid do
  begin
    RowCount := RowCount - 1;

    var offset := 0;
    if _place = TPlace.Down then
      offset := 1;

    for var i := _row + offset to RowCount do
      for var j := 1 to ColCount do
        Rows[i][j] := Rows[i + 1][j];
  end;
  Expression.OffsetExpressions(_grid, TPoint.Create(_row + 1, 1), TPoint.Create(-1, 0))
end;

constructor TRowCommand.Create(grid: &TStringGrid; row: integer; callback: TCallBack; place: TPlace);
begin
  _grid := grid;
  _row := row;
  _place := place;
  _callback := callback;
end;

constructor TRowCommand.Create(grid: &TStringGrid; row: integer; callback: TCallBack);
begin
  _grid := grid;
  _row := row;
  _place := TPlace.PlaceNone;
  _callback := callback;
end;

procedure TRowCommand.Redo();
begin
  // операция вставки
  if _place <> TPlace.PlaceNone then begin
    if _place = TPlace.Up then
      InsertRowUp()
    else
      InsertRowDown();
  end else
  // операция удаления
  begin
    SetLength(_rowData, _grid.ColCount);
    for var i := 0 to _grid.ColCount - 1 do
      _rowData[i] := _grid.Rows[_row][i];

    DeleteRow();
  end;

  if Assigned(_callback) then
    _callback();
end;

procedure TRowCommand.Undo();
begin
  // операция удаления
  if _place <> TPlace.PlaceNone then begin
    DeleteRow();
  end else
  // операция вставки
  begin
    InsertRowUp();

    for var i := 0 to _grid.ColCount - 1 do
      _grid.Cols[i][_row] := _rowData[i];
  end;

  if Assigned(_callback) then
    _callback();
end;

end.
