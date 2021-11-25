unit StringUtils;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, ShellApi, Vcl.Grids, System.Generics.Collections;

function ConvertANSItoASCII(s: string): string;
function ConvertASCIItoANSI(a: string): string;
function StringToPWide(sStr: string): PWideChar;
function FindNext(str: string; value: char; skipFounds: integer): integer;
procedure SgSort(aSg : TStringGrid; const aCol : Integer; reverse: boolean);
function Copy(grid: TStringGrid): TStringGrid;

implementation

var reversed: boolean;

function CompareStrings(List: TStringList; Index1, Index2: Integer):
Integer;
begin
  var d1 := List[Index1].ToExtended;
  var d2 := List[Index2].ToExtended;

  if reversed then begin
    if d1 > d2 then
      Result := -1
    else if d1 < d2 then Result := 1
    else
      Result := 0;
  end else begin
    if d1 > d2 then
      Result := 1
    else if d1 < d2 then Result := -1
    else
      Result := 0;
  end;
end;

procedure SgSort(aSg : TStringGrid; const aCol : Integer; reverse: boolean);
var
  SlSort, SlRow : TStringList;
  i, j : Integer;
begin
  SlSort := TStringList.Create;
  for i := aSg.FixedRows + 1 to aSg.RowCount - 1 do begin
    SlRow := TStringList.Create;
    SlRow.Assign(aSg.Rows[i]);
    SlSort.AddObject(aSg.Cells[aCol, i], SlRow);
  end;

  reversed := reverse;
  SlSort.CustomSort(CompareStrings);

  j := 0;
  for i := aSg.FixedRows + 1 to aSg.RowCount - 1 do begin
    SlRow := SlSort.Objects[j] as TStringList;
    aSg.Rows[i].Assign(SlRow);
    SlRow.Free;
    Inc(j);
  end;

  SlSort.Free;
end;

function Copy(grid: TStringGrid): TStringGrid;
begin
  var newGrid := TStringGrid.Create(grid);
  newGrid.ColCount := grid.ColCount;
  newGrid.RowCount := grid.RowCount;
  for var i := 0 to grid.ColCount - 1 do begin
    newGrid.ColWidths[i] := grid.ColWidths[i];
    for var j := 0 to grid.RowCount - 1 do
    begin
      newGrid.Cols[i][j] := grid.Cols[i][j];
    end;
  end;
end;

function FindNext(str: string; value: char; skipFounds: integer): integer;
begin
  var pos := -1;
  for var i := 0 to skipFounds do
  begin
    pos := str.IndexOf(value, pos + 1);
    if pos = -1 then
      exit;
  end;
  Result := pos;
end;

function StringToPWide(sStr: string): PWideChar;
begin
 var iSize := (Length(sStr) + 1) * 2;

 var pw := AllocMem(iSize);

 MultiByteToWideChar(CP_ACP, 0, PAnsiChar(sStr), iSize, pw, iSize);

 Result := pw;
end;


function ConvertANSItoASCII(s: string): string;
begin
  for var i := 1 to length(s) do
    if ord(s[i]) in [192..239] then
      s[i] := chr(ord(s[i]) - 64)
    else if ord(s[i]) in [240..255] then
      s[i] := chr(ord(s[i]) - 16)
    else if ord(s[i]) = 168 then
      s[i] := chr(ord(240))
    else if ord(s[i]) = 184 then
      s[i] := chr(ord(241));

  ConvertANSItoASCII := s;
end;

function ConvertASCIItoANSI(a: string): string;
begin
  for var i := 1 to length(a) do
    if ord(a[i]) in [128..175] then
      a[i] := chr(ord(a[i]) + 64)
    else if ord(a[i]) in [224..239] then
      a[i] := chr(ord(a[i]) + 16)
    else if ord(a[i]) = 240 then
      a[i] := chr(ord(168))
    else if ord(a[i]) = 241 then
      a[i] := chr(ord(184));

  ConvertASCIItoANSI := a;
end;

end.