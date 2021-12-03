unit FormManager;

interface

uses
  BasicForm, Vcl.Forms, Types, Vcl.Dialogs, System.Generics.Collections, Singleton;

type
  TType = (None = 0, Main = 1, Table = 2, TableMaster = 3, About = 4, Helper = 5, Sorting = 6);

type TFormManager = class(TSingleton)
public
  procedure Close(_type: TType);
  procedure Open(_type: TType);
  procedure Back();
  procedure Init();
  procedure SetForm(form: TIBasicForm; _type: TType);
  function GetForm(_type: TType): TIBasicForm;
private
  procedure CloseNonModal();
  function TypeToForm(_type: TType): TIBasicForm;
private
  _forms: TDictionary<TType, TIBasicForm>;
  _currentType: TType;
  _currentForm: BasicForm.TIBasicForm;
  _history: TStack<TType>;
  _nonModals: TSet<TType>;
end;

implementation

function TFormManager.GetForm(_type: TType): TIBasicForm;
begin
  Result := TypeToForm(_type);
end;

procedure TFormManager.SetForm(form: TIBasicForm; _type: TType);
begin
  _forms.Add(_type, form);
end;

function TFormManager.TypeToForm(_type: TType): BasicForm.TIBasicForm;
begin
  Result := _forms[_type];
end;

procedure TFormManager.Close(_type: TType);
begin
  var form: BasicForm.TIBasicForm := TypeToForm(_type);
  if form.IsModal() then
    Application.Terminate
  else begin
    if _nonModals.Contains(_type) then begin
      _nonModals.Exclude(_type);
      form.Close();
    end;
  end;
end;

procedure TFormManager.Back();
begin
  if _history.Count <= 1 then begin
    ShowMessage('History is empty!');
    exit;
  end;

  _history.Pop; // current form

  Open(_history.Pop); // prev form
end;

procedure TFormManager.CloseNonModal();
begin
  for var form in _nonModals.Values() do begin
    TypeToForm(form).Close();
  end;
  _nonModals.Clear();
end;

procedure TFormManager.Init();
begin
  _currentForm := nil;
  _currentType := TType.None;
  _nonModals := TSet<TType>.Create();
  _history := TStack<TType>.Create;
  _forms := TDictionary<TType, TIBasicForm>.Create();
end;

procedure TFormManager.Open(_type: TType);
begin          
  // select new form
  var newForm: BasicForm.TIBasicForm := TypeToForm(_type);

  if not newForm.IsModal() then // немодальные спец формы
  begin
    if not _nonModals.Contains(_type) then
      _nonModals.Include(_type);
  end else
  begin // обычые модальные формы
    if _type = _currentType then
      exit;

    _currentType := _type;
    _history.Push(_currentType);

    // close the old form and inherit its settings
    if _currentForm <> nil then begin
      _currentForm.Hide();
      newForm.Width    := _currentForm.Width;
      newForm.Height   := _currentForm.Height;
      newForm.Top      := _currentForm.Top;
      newForm.Left     := _currentForm.Left;
      newForm.Position := _currentForm.Position;
    end;

    _currentForm := newForm;

    CloseNonModal();
  end;

  if newForm = nil then begin
    ShowMessage('Form is nullptr! Terminate...');
    Application.Terminate;
  end;

  if (fsModal in TForm(newForm).FormState) or (not newForm.IsModal()) then
    newForm.Show()
  else
    newForm.ShowModal();
end;


end.
