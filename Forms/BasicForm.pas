unit BasicForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids;

type
  TIBasicForm = class(TForm)
  private
    Procedure WMGetSysCommand(var Message : TMessage); message WM_SYSCOMMAND;
  public
    { Public declarations }
  end;

implementation

procedure TIBasicForm.WMGetSysCommand;
begin
  case Message.WParam of
    SC_CLOSE:
    begin
      if MessageDlg('Выйти? Все несохраненные изменения будут утеряны.',mtCustom, [mbYes ,mbCancel], 0) = mrYes then
        Application.Terminate;
    end;
    SC_MINIMIZE:
      Application.Minimize;
    else
      inherited;
  end;
end;

end.
