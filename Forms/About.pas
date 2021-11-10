unit About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasicForm, MenuManager;

type
  TAboutForm = class(BasicForm.TIBasicForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TAboutForm.FormShow(Sender: TObject);
begin
  MenuManager.InitMenu(Self, _menu);
end;

end.
