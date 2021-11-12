unit Expression;

interface

uses Vcl.Grids, System.Classes, System.SysUtils, Winapi.Windows, System.Generics.Collections, Vcl.Dialogs,
     System.Math, System.Character;

procedure MathCell(grid, visible: TStringGrid; cell: TPoint);

type TExprType = (Unknown, Numeric, Literal);

type TExpression = class
public
  constructor Expression(token: string); overload; // ����������� ��� �����
  constructor Expression(token: string; a: TExpression); overload; // ����������� ������� ��������
  constructor Expression(token: string; a: TExpression; b: TExpression); overload; // ����������� �������� ��������

public
  // �������� ��� �����
  _token: string;
  // ��������� - ��������� ��������
  _args: TArray<TExpression>;
end;

type TExprResult = record
  _type: TExprType;
  _numeric: double;
  _literal: string;
end;

type TParser = class
public
  constructor TParser(input: string);
private
  _input: string;
  _pos: integer;

  function ParseToken(): string;
  function ParseSimpleExpression(): TExpression;
  function Parse(): TExpression;
  function ParseBinaryExpression(minPriority: integer): TExpression;
end;

implementation // --------------------------------------------------------------

constructor TParser.TParser(input: string);
begin
  _input := input;
  _pos := 1;
end;

function GetPriority(token: string): integer;
begin
  if (token = '+') then GetPriority := 1
  else if token = '-' then GetPriority := 1
  else if token = '*' then GetPriority := 2
  else if token = '/' then GetPriority := 2
  else if token = 'pow' then GetPriority := 2
  else if token = 'mod' then GetPriority := 3
  else GetPriority := 0 // ���������� 0 ���� ����� - ��� �� �������� �������� (�������� ")")
end;

constructor TExpression.Expression(token: string);
begin
  _token := token;
end;

constructor TExpression.Expression(token: string; a: TExpression);
begin
  _token := token;
  _args := [a];
end;

constructor TExpression.Expression(token: string; a: TExpression; b: TExpression);
begin
  _token := token;
  _args := [a, b];
end;

function StrnCmp(str1: string; str2: string; num: integer): boolean;
begin
  for var i := 1 to num do
    if str1[i] <> str2[i] then
    begin
      StrnCmp := false;
      exit;
    end;

  StrnCmp := true;
end;

function TParser.Parse(): TExpression;
begin
  Parse := ParseBinaryExpression(0);
end;

function TParser.ParseBinaryExpression(minPriority: integer): TExpression;
begin
  var left_expr := ParseSimpleExpression();

  if _pos > Length(_input) then begin
    ParseBinaryExpression := left_expr;
    exit;
  end;

  while True do begin
    var op := ParseToken(); // ������� ������� �������� ��������.
    var priority := GetPriority(op);

    // ������� �� ����� ���� �� ��������� ������� ����� (��� ��� �� �������� ��������).
    if (priority <= minPriority) then begin
      _pos := _pos - Length(op); // ������ ����� �������,
      ParseBinaryExpression := left_expr; // ���������� ��������� �����.
      exit;
    end;

    // ������ ��������� ������. ������� �������� ������ ����������� ���������.
    var right_expr := ParseBinaryExpression(priority);
    left_expr := TExpression.Expression(op, left_expr, right_expr); // ��������� ��������� �����.

    if _pos > Length(_input) then begin
      ParseBinaryExpression := left_expr;
      break;
    end;

    // ��������� ����: ������� ��������, � �������� �� ����������.
  end;
end;

function TParser.ParseToken(): string;
begin
  // ���������� ������� ����� �������.
  while _input[_pos] = ' ' do begin
    inc(_pos);
  end;

  // ���� _input ���������� � �����, �� ������ �����.
  if IsDigit(_input[_pos]) then begin
    var number: string;
    while ((IsDigit(_input[_pos])) or (_input[_pos] = ',')) do begin
      number := number + _input[_pos];
      inc(_pos);

      if _pos > Length(_input) then
        break;
    end;
    ParseToken := number;
    exit;
  end;

  for var token in ['+', '-', '*', '/', 'pow', 'mod', 'abs', 'sin', 'cos', 'tan', 'ctg', '(', ')'] do
  begin
    var temp := _input;
    Delete(temp, 1, _pos - 1);

    if StrnCmp(temp, token, Length(token)) then begin
      _pos := _pos + Length(token);
      ParseToken := token;
      exit;
    end;
  end;

  ParseToken := '';
end;

function TParser.ParseSimpleExpression(): TExpression;
begin
  // ������ ������ �����.
  var token: string := ParseToken();
  if token = '' then  // ����������� ����� ������, ��� ����������� �����
      raise Exception.Create('Invalid input');

  if IsDigit(token[1]) then begin // ���� ��� �����, ���������� ��������� ��� ����������
      ParseSimpleExpression := TExpression.Expression(token);
      exit;
  end;

  if token = '(' then begin
      var _result := Parse();
      if ParseToken() <> ')' then
        raise Exception.Create(')');

      ParseSimpleExpression := _result; // ���� ��� ������, ������ � ���������� ��������� � �������
      exit;
  end;

  // �����, ��� ������� �������� ("-", "sin", � �.�.)
  var arg := ParseSimpleExpression(); // ������ �� ��������.
  ParseSimpleExpression := TExpression.Expression(token, arg);
end;

function Eval(expr: TExpression): Real;
begin
  case Length(expr._args) of
    2: begin
      var a := Eval(expr._args[0]);
      var b := Eval(expr._args[1]);

      if (expr._token = '+') then Eval := a + b
      else if (expr._token = '-') then Eval := a - b
      else if (expr._token = '*') then Eval := a * b
      else if (expr._token = '/') then Eval := a / b
      else if (expr._token = 'pow') then Eval := power(a, b)
      else if (expr._token = 'mod') then Eval := round(a) mod round(b)
      else raise Exception.Create('Unknown binary operator');
    end;
    1: begin
      var a := Eval(expr._args[0]);
      if (expr._token = '+') then Eval := +a
      else if (expr._token = '-') then Eval := -a
      else if (expr._token = 'abs') then Eval := abs(a)
      else if (expr._token = 'sin') then Eval := sin(a)
      else if (expr._token = 'cos') then Eval := cos(a)
      else if (expr._token = 'tan') then Eval := tan(a)
      else if (expr._token = 'ctg') then Eval := cos(a) / sin(a)
      else raise Exception.Create('Unknown binary operator');
    end;
    0: begin
      Eval := StrToFloat(expr._token);
    end
    else
      raise Exception.Create('Unknown expression type');
  end;
end;

function MathExpression(expr: string): string;
begin
  try
    MathExpression := FloatToStr(Eval(TParser.TParser(expr).Parse()));
  except
    on ex: Exception do
      MathExpression := '#' + ex.Message + '#';
  end;
end;

function ReplaceCells(grid: &TStringGrid; var expr: &string): boolean;
begin
  try
    var openId := expr.IndexOf('[');
    while openId >= 0 do begin
      var closeId := expr.IndexOf(']');

      if closeId < 0 then
        raise Exception.Create('"]" was not found');

      var args := expr.Substring(openId + 1, (closeId - openId) - 1).Split([':']);

      expr := expr.Remove(openId, (closeId - openId) + 1);

      var cell := grid.Rows[StrToInt(args[0])][StrToInt(args[1])];
      if cell[1] = '=' then
        cell := cell.Substring(1, Length(cell) - 1);

      expr := expr.Insert(openId, '(' + cell + ')');

      openId := expr.IndexOf('[');
    end;

    ReplaceCells := true;
  except
    on ex: Exception do begin
      expr := '#' + ex.Message + '#';
      ReplaceCells := false;
    end;
  end;
end;

procedure MathCell(grid, visible: TStringGrid; cell: TPoint);
begin
  var value := grid.Cols[cell.x][cell.y];
  if value.IndexOf('=') = 0 then begin
    if ReplaceCells(grid, value) then begin
      visible.Cols[cell.x][cell.y] := MathExpression(value.Substring(1, Length(value) - 1));
      exit;
    end;
  end;

  visible.Cols[cell.x][cell.y] := value;
end;

end.
