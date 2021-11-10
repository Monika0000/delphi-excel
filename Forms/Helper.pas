unit Helper;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasicForm, MenuManager;

type
  THelperForm = class(BasicForm.TIBasicForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure THelperForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);
end;

end.
