unit CommandManager;

interface

uses Vcl.Dialogs, System.SysUtils, IOUtils;

type TICommand = class
  public
    procedure Redo(); virtual; abstract;
    procedure Undo(); virtual; abstract;
end;

type TCmdManager = class
  public
    procedure Send(cmd: TICommand);
    procedure Redo();
    procedure Undo();
    procedure ClearAfter(_begin: integer);
    procedure ClearAll();
    function Top(): &TICommand;
  private
    const _maxCmds = 2048;
    var _current: integer;
    var _commands: array[0..(_maxCmds - 1)] of TICommand;
end;

var gCmdManager: TCmdManager;

procedure Init();

implementation

procedure TCmdManager.ClearAll();
begin
  _current := 0;
  for var i := 0 to _maxCmds - 1 do
    _commands[i] := nil;
end;

function TCmdManager.Top(): &TICommand;
begin
  if _current <= 0 then
    Top := nil
  else
    Top := _commands[_current - 1];
end;

procedure Init();
begin
  gCmdManager := TCmdManager.Create();
  gCmdManager.ClearAfter(0);
end;

procedure TCmdManager.ClearAfter(_begin: Integer);
begin
  // достигли вершины буфера, очищать нечего
  if _begin >= _maxCmds then
    exit;

  // если начальная команда уже пустая, то предполагается, что и остальные тоже пустые
  if _commands[_begin] = nil then
    exit;

  for var i := _begin + 1 to _maxCmds - 1 do
    _commands[i] := nil;
end;

procedure TCmdManager.Send(cmd: TICommand);
begin
  // если буфер переполнен, сдвигаем все команды влево на 1 и записываем новую вместо последней
  if _current = _maxCmds then
  begin
    for var i := 0 to _maxCmds - 2 do
      _commands[i] := _commands[i + 1];

    _commands[_current - 1] := cmd;
    exit;
  end;

  _commands[_current] := cmd;
  _current := _current + 1;

  ClearAfter(_current - 1);
end;

procedure TCmdManager.Redo();
begin
  if (_current >= _maxCmds) then
    exit;

  if _commands[_current] = nil then
    exit;

  _commands[_current].Redo();

  _current := _current + 1;
end;

procedure TCmdManager.Undo();
begin
  if _current <= 0 then
    exit;

  _commands[_current - 1].Undo();

  _current := _current - 1;
end;

end.
