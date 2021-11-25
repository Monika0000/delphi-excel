unit Sorting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasicForm, FormManager, Vcl.ExtCtrls, Table,
  Vcl.Grids, Vcl.StdCtrls, System.Generics.Collections, Vcl.Imaging.pngimage, StringUtils;

type TOperation = (More = 0, Less = 1, Equals = 2, LessOrEquals = 3, MoreOrEquals = 4, NotEquals = 5, Range = 6);
type TFilterType = (Lexical = 0, Numeric = 1);
type TSortType = (Ascending = 0, Descending = 1);

type TFilter = class
public
  _op: TOperation;
  _type: TFilterType;
  _value: string;
  _rangeA: string;
  _rangeB: string;
public

end;

type
  TSortingForm = class(TIBasicForm)
    Panel1: TPanel;
    TableGrid: TStringGrid;
    Panel2: TPanel;
    ColSelectComboBox: TComboBox;
    ResetFilter: TButton;
    OperationValue: TEdit;
    OperationComboBox: TComboBox;
    ErrorImage: TImage;
    TypeComboBox: TComboBox;
    RangeAEdit: TEdit;
    RangeBEdit: TEdit;
    SortTypeComboBox: TComboBox;
    SortColComboBox: TComboBox;
    Сортировка: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ColSelectComboBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OperationValueChange(Sender: TObject);
    procedure OperationComboBoxChange(Sender: TObject);
    procedure TypeComboBoxChange(Sender: TObject);
    procedure ResetFilterClick(Sender: TObject);
    procedure RangeAEditChange(Sender: TObject);
    procedure RangeBEditChange(Sender: TObject);
    procedure SortColComboBoxChange(Sender: TObject);
    procedure SortTypeComboBoxChange(Sender: TObject);
  private
    procedure EnumerateRows();
    procedure InitFilter();
    procedure HasErrors(enabled: boolean);
    function EvalateRow(row: TStrings): boolean;
    procedure CheckFilter();
  public
    procedure Update();
    function IsModal(): boolean; override;
  private
    _sortColumn: integer;
    _sortType: TSortType;
    _filters: TDictionary<integer, TFilter>;
    _currentFilter: Integer;
  end;

implementation

function Evalate(filter: TFilter; str: string): boolean;
begin
  if
    (str = '')
    or ((filter._op = TOperation.Range) and ((filter._rangeA = '') or (filter._rangeB = '')))
    or ((filter._op <> TOperation.Range) and (filter._value = ''))
    then begin
      Result := true;
      exit;
    end;


  if filter._type = TFilterType.Lexical then begin
    case filter._op of
      TOperation.More: Result := str > filter._value;
      TOperation.Less: Result := str < filter._value;
      TOperation.Equals: Result := str = filter._value;
      TOperation.LessOrEquals: Result := str <= filter._value;
      TOperation.MoreOrEquals: Result := str >= filter._value;
      TOperation.NotEquals: Result := str <> filter._value;
      TOperation.Range: Result := (filter._rangeA > str) and (str < filter._rangeB);
    end;
  end else begin
    var a := StrToFloat(str);
    if filter._op <> TOperation.Range then begin
      var b := StrToFloat(filter._value);
      case filter._op of
        TOperation.More: Result := a > b;
        TOperation.Less: Result := a < b;
        TOperation.Equals: Result := a = b;
        TOperation.LessOrEquals: Result := a <= b;
        TOperation.MoreOrEquals: Result := a >= b;
        TOperation.NotEquals: Result := a <> b;

      end;
    end else begin
      Result := (a > StrToFloat(filter._rangeA)) and (a < StrToFloat(filter._rangeB));
    end;
  end;
end;

procedure TSortingForm.CheckFilter();
begin
  if not _filters.ContainsKey(ColSelectComboBox.ItemIndex) then begin
    _filters.Add(ColSelectComboBox.ItemIndex, TFilter.Create);
  end;
end;

procedure TSortingForm.HasErrors(enabled: boolean);
begin
  ErrorImage.Visible := enabled;
end;

function TSortingForm.EvalateRow(row: TStrings): boolean;
begin
  var _result := _filters.Count = 0;

  try
    for var col in _filters.Keys do begin
      _result := Evalate(_filters[col], row[col + 1]);

      if _result = false then
        break;
    end;
    HasErrors(false);
  except
    HasErrors(true);
  end;

  Result := _result;
end;

procedure TSortingForm.InitFilter();
begin
  ColSelectComboBox.Clear();
  SortColComboBox.Clear();

  SortColComboBox.Clear();
  SortColComboBox.Items.Add('Не сортировать');
  for var col := 1 to TableGrid.ColCount - 1 do begin
    SortColComboBox.Items.Add(TableGrid.Cols[col][0]);
  end;
  SortColComboBox.ItemIndex := 0;

  for var col := 1 to TableGrid.ColCount - 1 do begin
    ColSelectComboBox.Items.Add(TableGrid.Cols[col][0]);
  end;

  if ColSelectComboBox.GetCount > 0 then begin
    ColSelectComboBox.ItemIndex := 0;
    ColSelectComboBoxChange(nil);
  end;

  OperationComboBoxChange(nil);
end;

procedure TSortingForm.ColSelectComboBoxChange(Sender: TObject);
begin
  _currentFilter := ColSelectComboBox.ItemIndex;

  if _currentFilter = -1 then
    exit;

  CheckFilter();

  OperationValue.Text := _filters[ColSelectComboBox.ItemIndex]._value;
  OperationComboBox.ItemIndex := integer(_filters[ColSelectComboBox.ItemIndex]._op);
  RangeAEdit.Text := _filters[ColSelectComboBox.ItemIndex]._rangeA;
  RangeBEdit.Text := _filters[ColSelectComboBox.ItemIndex]._rangeB;

  Update();
end;

procedure TSortingForm.EnumerateRows();
begin
  for var i := 1 to TableGrid.RowCount do
  begin
    TableGrid.Rows[i][0] := IntToStr(i);
  end;
end;

procedure TSortingForm.Update();
begin
  var _table := (gTableForm as Table.TTableForm).VisibleTableGrid;

  TableGrid.ColCount := _table.ColCount;
  TableGrid.RowCount := 1;

  for var col := 1 to TableGrid.ColCount - 1 do begin
    TableGrid.ColWidths[col] := _table.ColWidths[col];
    TableGrid.Rows[0][col] := _table.Rows[0][col];
  end;

  for var row := 1 to _table.RowCount - 1 do begin
    var rowData := _table.Rows[row];

    if EvalateRow(rowData) then begin
      TableGrid.RowCount := TableGrid.RowCount + 1;
      for var col := 1 to TableGrid.ColCount - 1 do
        TableGrid.Rows[TableGrid.RowCount - 1][col] := rowData[col];
    end;
  end;

  if (_sortColumn <> -1) then begin
    try
      StringUtils.sgSort(TableGrid, _sortColumn + 1, _sortType = TSortType.Descending);
      Self.HasErrors(false);
    except
      Self.HasErrors(true);
    end;
  end;

  EnumerateRows();
end;

procedure TSortingForm.FormShow(Sender: TObject);
begin
  _sortColumn := -1;
  _sortType := TSortType.Ascending;

  Update();
  InitFilter();
  ResetFilterClick(nil);
end;

function TSortingForm.IsModal(): boolean;
begin
  Result := false;
end;

procedure TSortingForm.OperationComboBoxChange(Sender: TObject);
begin
  CheckFilter();

  var filter := _filters[_currentFilter];
  filter._op := TOperation(OperationComboBox.ItemIndex);
  _filters[_currentFilter] := filter;

  if filter._op = TOperation.Range then begin
    RangeAEdit.Visible := true;
    RangeBEdit.Visible := true;
    OperationValue.Visible := false;
  end else begin
    RangeAEdit.Visible := false;
    RangeBEdit.Visible := false;
    OperationValue.Visible := true;
  end;

  Update();
end;

procedure TSortingForm.OperationValueChange(Sender: TObject);
begin
  CheckFilter();

  var filter := _filters[_currentFilter];
  filter._value := OperationValue.Text;
  _filters[_currentFilter] := filter;

  Update();
end;

procedure TSortingForm.RangeAEditChange(Sender: TObject);
begin
  CheckFilter();

  var filter := _filters[_currentFilter];
  filter._rangeA := RangeAEdit.Text;
  _filters[_currentFilter] := filter;

  Update();
end;

procedure TSortingForm.RangeBEditChange(Sender: TObject);
begin
  CheckFilter();

  var filter := _filters[_currentFilter];
  filter._rangeB := RangeBEdit.Text;
  _filters[_currentFilter] := filter;

  Update();
end;

procedure TSortingForm.ResetFilterClick(Sender: TObject);
begin
  _currentFilter := 0;

  OperationValue.Clear();
  RangeAEdit.Clear();
  RangeBEdit.Clear();

  _filters.Clear();

  TypeComboBox.ItemIndex := 0;
  OperationComboBox.ItemIndex := 0;
  ColSelectComboBox.ItemIndex := 0;

  CheckFilter();

  Update();
end;

procedure TSortingForm.SortColComboBoxChange(Sender: TObject);
begin
  _sortColumn := SortColComboBox.ItemIndex - 1;
  Update();
end;

procedure TSortingForm.SortTypeComboBoxChange(Sender: TObject);
begin
  _sortType := TSortType(SortTypeComboBox.ItemIndex);
  Update();
end;

procedure TSortingForm.TypeComboBoxChange(Sender: TObject);
begin
  CheckFilter();

  var filter := _filters[_currentFilter];
  filter._type := TFilterType(TypeComboBox.ItemIndex);
  _filters[_currentFilter] := filter;

  OperationComboBoxChange(nil);

  Update();
end;

{$R *.dfm}

procedure TSortingForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormManager.Close(FormManager.TType.Sorting);
end;

procedure TSortingForm.FormCreate(Sender: TObject);
begin
  _filters := TDictionary<Integer, TFilter>.Create();

  const ops = ['>', '<', '=', '<=', '>=', '!=', 'E [a, b]'];
  for var op in ops do
    OperationComboBox.Items.Add(op);
  OperationComboBox.ItemIndex := 0;

  const filterTypes = ['Строковый', 'Числовой'];
  for var op in filterTypes do
    TypeComboBox.Items.Add(op);
  TypeComboBox.ItemIndex := 0;

  const sortTypes = ['По возрастанию', 'По убыванию'];
  for var sort in sortTypes do
    SortTypeComboBox.Items.Add(sort);
  SortTypeComboBox.ItemIndex := 0;
end;

end.
