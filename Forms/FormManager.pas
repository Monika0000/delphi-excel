unit FormManager;

interface

uses
  BasicForm, Vcl.Forms, Types, Vcl.Dialogs;

type
  TType = (None = 0, Main = 1, Table = 2, TableMaster = 3, About = 4, Helper = 5);

var
  gMainForm:        BasicForm.TIBasicForm = nil;
  gTableForm:       BasicForm.TIBasicForm = nil;
  gTableMasterForm: BasicForm.TIBasicForm = nil;
  gAboutForm:       BasicForm.TIBasicForm = nil;
  gHelperForm:      BasicForm.TIBasicForm = nil;

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
    TType.Main:        newForm := gMainForm;
    TType.Table:       newForm := gTableForm;
    TType.TableMaster: newForm := gTableMasterForm;
    TType.About:       newForm := gAboutForm;
    TType.Helper:      newForm := gHelperForm;
  end;

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

  if gCurrentForm = nil then begin
    ShowMessage('Form is nullptr! Terminate...');
    Application.Terminate;
  end;

  if (fsModal in TForm(gCurrentForm).FormState) then
    gCurrentForm.Show()
  else
    gCurrentForm.ShowModal();
end;


end.
