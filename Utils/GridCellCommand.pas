unit GridCellCommand;

interface

uses CommandManager, Vcl.Grids, Types;

type TGridCellCommand = class(TICommand)
  public
    constructor Create(grid: &TStringGrid; col, row: integer; old,
      new: string; callback: TCallBack);

    procedure Redo(); override;
    procedure Undo(); override;
    function GetColumn(): Integer;
    function GetRow(): Integer;
    procedure Update(new: string);
  private
    var _grid: &TStringGrid;
    var _col, _row: integer;
    var _old, _new: string;
    var _callback: Types.TCallBack;
end;

implementation

constructor TGridCellCommand.Create(grid: TStringGrid; col: Integer;
  row: Integer; old: string; new: string; callback: TCallBack);
begin
  _grid := grid;
  _col := col;
  _row := row;
  _old := old;
  _new := new;
  _callback := callback;
end;

procedure TGridCellCommand.Update(new: string);
begin
  _new := new;
end;

function TGridCellCommand.GetColumn(): Integer;
begin
  GetColumn := _col;
end;

function TGridCellCommand.GetRow(): Integer;
begin
  GetRow := _row;
end;

procedure TGridCellCommand.Redo();
begin
  _grid.Rows[_row][_col] := _new;

  if Assigned(_callback) then
    _callback();
end;

procedure TGridCellCommand.Undo();
begin
  _grid.Rows[_row][_col] := _old;

  if Assigned(_callback) then
    _callback();
end;

end.
