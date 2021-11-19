unit Sorting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasicForm, FormManager, Vcl.ExtCtrls, Table,
  Vcl.Grids, Vcl.StdCtrls, System.Generics.Collections, Vcl.Imaging.pngimage;

type TOperation = (More = 0, Less = 1, Equals = 2, LessOrEquals = 3, MoreOrEquals = 4, NotEquals = 5);
type TType = (Lexical = 0, Numeric = 1);

type TFilter = class
public
  _op: TOperation;
  _type: TType;
  _value: string;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ColSelectComboBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OperationValueChange(Sender: TObject);
    procedure OperationComboBoxChange(Sender: TObject);
    procedure TypeComboBoxChange(Sender: TObject);
    procedure ResetFilterClick(Sender: TObject);
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
    _filters: TDictionary<integer, TFilter>;
    _currentFilter: Integer;
  end;

implementation

function Evalate(filter: TFilter; str: string): boolean;
begin
  if filter._type = TType.Lexical then begin
    case filter._op of
      TOperation.More: Result := str > filter._value;
      TOperation.Less: Result := str < filter._value;
      TOperation.Equals: Result := str = filter._value;
      TOperation.LessOrEquals: Result := str <= filter._value;
      TOperation.MoreOrEquals: Result := str >= filter._value;
      TOperation.NotEquals: Result := str <> filter._value;
    end;
  end else begin
    var a := StrToFloat(str);
    var b := StrToFloat(filter._value);
    case filter._op of
      TOperation.More: Result := a > b;
      TOperation.Less: Result := a < b;
      TOperation.Equals: Result := a = b;
      TOperation.LessOrEquals: Result := a <= b;
      TOperation.MoreOrEquals: Result := a >= b;
      TOperation.NotEquals: Result := a <> b;
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

  for var col := 1 to TableGrid.ColCount - 1 do begin
    ColSelectComboBox.Items.Add(TableGrid.Cols[col][0]);
  end;

  if ColSelectComboBox.GetCount > 0 then begin
    ColSelectComboBox.ItemIndex := 0;
    ColSelectComboBoxChange(nil);
  end;
end;

procedure TSortingForm.ColSelectComboBoxChange(Sender: TObject);
begin
  _currentFilter := ColSelectComboBox.ItemIndex;

  if _currentFilter = -1 then
    exit;

  CheckFilter();

  OperationValue.Text := _filters[ColSelectComboBox.ItemIndex]._value;
  OperationComboBox.ItemIndex := integer(_filters[ColSelectComboBox.ItemIndex]._op);

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

  EnumerateRows();
end;

procedure TSortingForm.FormShow(Sender: TObject);
begin
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

procedure TSortingForm.ResetFilterClick(Sender: TObject);
begin
  _currentFilter := 0;

  OperationValue.Clear();

  _filters.Clear();

  TypeComboBox.ItemIndex := 0;
  OperationComboBox.ItemIndex := 0;
  ColSelectComboBox.ItemIndex := 0;

  CheckFilter();

  Update();
end;

procedure TSortingForm.TypeComboBoxChange(Sender: TObject);
begin
  CheckFilter();

  var filter := _filters[_currentFilter];
  filter._type := TType(TypeComboBox.ItemIndex);
  _filters[_currentFilter] := filter;

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

  const ops = ['>', '<', '=', '<=', '>=', '!='];
  for var op in ops do
    OperationComboBox.Items.Add(op);
  OperationComboBox.ItemIndex := 0;

  const types = ['Строковый', 'Числовой'];
  for var op in types do
    TypeComboBox.Items.Add(op);
  TypeComboBox.ItemIndex := 0;
end;

end.
