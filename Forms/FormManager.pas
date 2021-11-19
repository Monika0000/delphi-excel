unit FormManager;

interface

uses
  BasicForm, Vcl.Forms, Types, Vcl.Dialogs, System.Generics.Collections;

type
  TType = (None = 0, Main = 1, Table = 2, TableMaster = 3, About = 4, Helper = 5, Sorting = 6);

var
  gMainForm:        BasicForm.TIBasicForm = nil;
  gTableForm:       BasicForm.TIBasicForm = nil;
  gTableMasterForm: BasicForm.TIBasicForm = nil;
  gAboutForm:       BasicForm.TIBasicForm = nil;
  gHelperForm:      BasicForm.TIBasicForm = nil;
  gSortingForm:     BasicForm.TIBasicForm = nil;

procedure Close(_type: TType);
procedure Open(_type: TType);
procedure Back();
procedure Init();

implementation

var
  gCurrentType: TType = TType.None;
  gCurrentForm: BasicForm.TIBasicForm = nil;
  gHistory: TStack<TType>;
  gNonModals: TSet<TType>;

function TypeToForm(_type: TType): BasicForm.TIBasicForm;
begin
  case _type of
    TType.None:        Result := nil;
    TType.Main:        Result := gMainForm;
    TType.Table:       Result := gTableForm;
    TType.TableMaster: Result := gTableMasterForm;
    TType.About:       Result := gAboutForm;
    TType.Helper:      Result := gHelperForm;
    TType.Sorting:     Result := gSortingForm;
  end;
end;

procedure Close(_type: TType);
begin
  var form: BasicForm.TIBasicForm := TypeToForm(_type);
  if form.IsModal() then
    Application.Terminate
  else begin
    if gNonModals.Contains(_type) then begin
      gNonModals.Exclude(_type);
      form.Close();
    end;
  end;
end;

procedure Back();
begin
  if gHistory.Count <= 1 then begin
    ShowMessage('History is empty!');
    exit;
  end;

  gHistory.Pop; // current form

  Open(gHistory.Pop); // prev form
end;

procedure CloseNonModal();
begin
  for var form in gNonModals.Values() do begin
    TypeToForm(form).Close();
  end;
  gNonModals.Clear();
end;

procedure Init();
begin
  gNonModals := TSet<TType>.Create();
  gHistory := TStack<TType>.Create;
end;

procedure Open(_type: TType);
begin          
  // select new form
  var newForm: BasicForm.TIBasicForm := TypeToForm(_type);

  if not newForm.IsModal() then // немодальные спец формы
  begin
    if not gNonModals.Contains(_type) then
      gNonModals.Include(_type);
  end else
  begin // обычые модальные формы
    if _type = gCurrentType then
      exit;

    gCurrentType := _type;
    gHistory.Push(gCurrentType);

    // close the old form and inherit its settings
    if gCurrentForm <> nil then begin
      gCurrentForm.Hide();
      newForm.Width    := gCurrentForm.Width;
      newForm.Height   := gCurrentForm.Height;
      newForm.Top      := gCurrentForm.Top;
      newForm.Left     := gCurrentForm.Left;
      newForm.Position := gCurrentForm.Position;
    end;

    gCurrentForm := newForm;

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
