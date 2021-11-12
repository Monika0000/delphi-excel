unit ColCommand;

interface

uses CommandManager, Vcl.Grids, System.Classes, Vcl.Dialogs, Types;

type TPlace = (PlaceNone = 0, Left = 1, Right = 2);

type TColCommand = class(TICommand)
  public
    constructor Create(grid: &TStringGrid; col: integer; callback: TCallBack; place: TPlace); overload;
    constructor Create(grid: &TStringGrid; col: integer; callback: TCallBack); overload;
    procedure Redo(); override;
    procedure Undo(); override;
  private
    procedure InsertColLeft();
    procedure InsertColRight();
    procedure DeleteCol();
  private
    var _grid: &TStringGrid;
    var _place: TPlace;
    var _col: integer;
    var _callback: Types.TCallBack;
    var _colData: TArray<string>;
end;

implementation

procedure TColCommand.InsertColLeft();
begin
    with _grid do
  begin
    ColCount := ColCount + 1;

    for var i := ColCount downto _col do
      for var j := 0 to RowCount do
        Cols[i + 1][j] := Cols[i][j];

    for var i := 0 to RowCount do
      Cols[_col][i] := '';
  end;
end;

procedure TColCommand.InsertColRight();
begin
  with _grid do
  begin
    ColCount := ColCount + 1;

    for var i := ColCount downto _col + 1 do
      for var j := 0 to RowCount do
        Cols[i + 1][j] := Cols[i][j];

    for var i := 0 to RowCount do
      Cols[_col + 1][i] := '';
  end;
end;

procedure TColCommand.DeleteCol();
begin
  with _grid do
  begin
    ColCount := ColCount - 1;

    var offset := 0;
    if _place = TPlace.Right then
      offset := 1;

    for var i := _col + offset to ColCount do
      for var j := 0 to RowCount do
        Cols[i][j] := Cols[i + 1][j];
  end;
end;

constructor TColCommand.Create(grid: &TStringGrid; col: integer; callback: TCallBack; place: TPlace);
begin
  _grid := grid;
  _place := place;
  _col := col;
  _callback := callback;
end;

constructor TColCommand.Create(grid: &TStringGrid; col: integer; callback: TCallBack);
begin
  _grid := grid;
  _col := col;
  _callback := callback;
  _place := TPlace.PlaceNone;
end;

procedure TColCommand.Redo();
begin
  // операция вставки
  if _place <> TPlace.PlaceNone then begin
    if _place = TPlace.Left then
      InsertColLeft()
    else
      InsertColRight();
  end else
  // операция удаления
  begin
    SetLength(_colData, _grid.RowCount);
    for var i := 0 to _grid.RowCount - 1 do
      _colData[i] := _grid.Cols[_col][i];

    DeleteCol();
  end;

  if Assigned(_callback) then
    _callback();
end;

procedure TColCommand.Undo();
begin
  // операция удаления
  if _place <> TPlace.PlaceNone then begin
    DeleteCol();
  end else
  // операция вставки
  begin
    InsertColLeft();

    for var i := 0 to _grid.RowCount - 1 do
      _grid.Rows[i][_col] := _colData[i];
  end;

  if Assigned(_callback) then
    _callback();
end;

end.
