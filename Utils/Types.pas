unit Types;

interface

uses Vcl.Forms, System.Generics.Collections;

type TCallBack = reference to procedure();

type TIVec3 = array[0..2] of Integer;
type TFVec3 = array[0..2] of Real;

type TIVec2 = array[0..1] of Integer;
type TFVec2 = array[0..1] of Real;

type
  TSet<T> = class
  private
    FDict: TDictionary<T, Integer>;
  public
    constructor Create;
    destructor Destroy; override;
    function Contains(const Value: T): Boolean;
    procedure Include(const Value: T);
    procedure Clear();
    procedure Exclude(const Value: T);
    function Values(): TList<T>;
  end;

implementation

procedure TSet<T>.Clear();
begin
  FDict.Clear();
end;

function TSet<T>.Values(): TList<T>;
begin
  var v := TList<T>.Create();
  for var Key in FDict.Keys do
    v.Add(Key);
  Result := v;
end;

constructor TSet<T>.Create;
begin
  inherited;
  FDict := TDictionary<T, Integer>.Create;
end;

destructor TSet<T>.Destroy;
begin
  FDict.Free;
  inherited;
end;

function TSet<T>.Contains(const Value: T): Boolean;
begin
  Result := FDict.ContainsKey(Value);
end;

procedure TSet<T>.Include(const Value: T);
begin
  FDict.AddOrSetValue(Value, 0);
end;

procedure TSet<T>.Exclude(const Value: T);
begin
  FDict.Remove(Value);
end;


end.