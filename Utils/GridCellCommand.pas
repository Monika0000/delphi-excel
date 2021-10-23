unit GridCellCommand;

interface

uses CommandManager, Vcl.Grids;

type TGridCellCommand = class(TICommand)
  public
    constructor Create(grid: &TStringGrid; col, row: integer; old, new: string);
    procedure Redo(); override;
    procedure Undo(); override;
  private
    var _grid: &TStringGrid;
    var _col, _row: integer;
    var _old, _new: string;
end;

implementation

constructor TGridCellCommand.Create(grid: TStringGrid; col: Integer; row: Integer; old: string; new: string);
begin
  _grid := grid;
  _col := col;
  _row := row;
  _old := old;
  _new := new;
end;

procedure TGridCellCommand.Redo();
begin
  _grid.Rows[_row][_col] := _new;
end;

procedure TGridCellCommand.Undo();
begin
  _grid.Rows[_row][_col] := _old;
end;

end.
