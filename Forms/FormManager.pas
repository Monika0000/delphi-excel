unit FormManager;

interface

uses
  Vcl.Forms;

type
  TType = (None = 0, Main = 1, Table = 2);

var
  gMainForm: TForm = nil;
  gTableForm: TForm = nil;

procedure Open(_type: TType);

implementation

var
  gCurrentType: TType = TType.None;
  gCurrentForm: TForm = nil;

procedure Open(_type: TType);
begin
  if _type = gCurrentType then
    exit;

  gCurrentType := _type;

  var newForm: TForm := nil;

  // select new form
  case gCurrentType of
    TType.None: exit;
    TType.Main: newForm := gMainForm;
    TType.Table: newForm := gTableForm;
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

  if (fsModal in gCurrentForm.FormState) then
    gCurrentForm.Show()
  else
    gCurrentForm.ShowModal();
end;


end.
