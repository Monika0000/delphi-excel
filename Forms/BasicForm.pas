unit BasicForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Menus;

type
  TMenuInitProc = procedure(menu: TMainMenu);

type
  TIBasicForm = class(TForm)
  private
    procedure WMGetSysCommand(var Message : TMessage); message WM_SYSCOMMAND;
  public
    procedure SetMenu(menu: TMenuInitProc);
  protected
    var _menu: TMenuInitProc;
  end;

implementation

procedure TIBasicForm.SetMenu(menu: TMenuInitProc);
begin
  _menu := menu;
end;

procedure TIBasicForm.WMGetSysCommand;
begin
  case Message.WParam of
    SC_CLOSE:
    begin
      if MessageDlg('�����? ��� ������������� ��������� ����� �������.',mtCustom, [mbYes, mbCancel], 0) = mrYes then
        Application.Terminate;
    end;
    SC_MINIMIZE:
      Application.Minimize;
    else
      inherited;
  end;
end;

end.
