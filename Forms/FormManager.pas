unit FormManager;

interface

uses
  BasicForm, Vcl.Forms, Types;

type
  TType = (None = 0, Main = 1, Table = 2, TableMaster = 3);

var
  gMainForm:        BasicForm.TIBasicForm = nil;
  gTableForm:       BasicForm.TIBasicForm = nil;
  gTableMasterForm: BasicForm.TIBasicForm = nil;

procedure Open(_type: TType);

implementation

var
  gCurrentType: TType = TType.None;
  gCurrentForm: BasicForm.TIBasicForm = nil;

procedure Open(_type: TType);
begin
  if _type = gCurrentType then
    exit;

  gCurrentType := _type;

  var newForm: BasicForm.TIBasicForm := nil;

  // select new form
  case gCurrentType of
    TType.None: exit;
    TType.Main: newForm := gMainForm;
    TType.Table: newForm := gTableForm;
    TType.TableMaster: newForm := gTableMasterForm;
  end;

  // close the old form and inherit its settings
  if gCurrentForm <> nil then begin
    gCurrentForm.Hide();
    newForm.Width := gCurrentForm.Width;
    newForm.Height := gCurrentForm.Height;
    newForm.Top := gCurrentForm.Top;
    newForm.Left := gCurrentForm.Left;
    newForm.Position := gCurrentForm.Position;
  end;

  gCurrentForm := newForm;

  if (fsModal in TForm(gCurrentForm).FormState) then
    gCurrentForm.Show()
  else
    gCurrentForm.ShowModal();
end;


end.
