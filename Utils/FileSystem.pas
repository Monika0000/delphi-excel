unit FileSystem;

interface

uses Json, Vcl.Grids, Vcl.ExtDlgs, Forms, System.SysUtils, System.Classes, Vcl.Dialogs;

const ResourcesFolder = '..\..\Resources';
const FileExtension = 'dxcl';

function StringGridToJson(grid: TStringGrid): TJSONObject;
function JsonToStringGrid(grid: &TStringGrid; json: TJSONObject): boolean;

function DialogSaveFile(data: string): boolean;
function DialogLoadFile(): string; // filename

function GetExeFolder(): string;

implementation

function GetExeFolder(): string;
begin
  GetExeFolder := ExtractFilePath(ParamStr(0));
end;

function JsonToStringGrid(grid: &TStringGrid; json: TJSONObject): boolean;
begin
  try
    grid.ColCount := StrToInt((json.GetValue('ColCount') as TJSONNumber).Value);
    grid.RowCount := StrToInt((json.GetValue('RowCount') as TJSONNumber).Value);

    var matrix := json.GetValue('grid') as TJsonArray;

    for var col := 0 to grid.ColCount - 1 do
      for var row := 0 to grid.RowCount - 1 do
        grid.Cols[col][row] := (matrix[col] as TJsonArray)[row].Value;

    JsonToStringGrid := true;
  except
    on ex : Exception do begin
      ShowMessage('Failed to parse json grid! Reason: ' + ex.Message);
      JsonToStringGrid := false;
    end;
  end;
end;

function DialogLoadFile(): string;
begin
  var filename: string := '';
  var dialog := TOpenTextFileDialog.Create(Application);
  dialog.DefaultExt := FileExtension;

  if dialog.Execute then
    filename := dialog.FileName;

  DialogLoadFile := filename;
end;

function DialogSaveFile(data: string): boolean;
begin
  var dialog := TSaveTextFileDialog.Create(Application);

  dialog.DefaultExt := FileExtension;

  var _result := false;

  if dialog.Execute then begin
      var _file := TStreamWriter.Create(dialog.FileName, false, TEncoding.UTF8);
      try
        _file.Write(data);
        _file.Flush();
        _file.Close();

        _result := true;
      finally
        FreeAndNil(_file);
      end;
  end;

  dialog.Destroy;
  DialogSaveFile := _result;
end;

function StringGridToJson(grid: TStringGrid): TJSONObject;
begin
  var jsonCols := TJSONArray.Create;
  for var col: integer := 0 to grid.ColCount - 1 do begin
    var jsonCol := TJSONArray.Create;
    for var row := 0 to grid.RowCount - 1 do begin
      jsonCol.AddElement(TJSONString.Create(grid.Cols[col][row]));
    end;
    jsonCols.AddElement(jsonCol);
  end;

  var jsonGrid := TJSONObject.Create();

  jsonGrid.AddPair('ColCount', grid.ColCount);
  jsonGrid.AddPair('RowCount', grid.RowCount);
  jsonGrid.AddPair('grid', jsonCols);

  StringGridToJson := jsonGrid;
end;

end.