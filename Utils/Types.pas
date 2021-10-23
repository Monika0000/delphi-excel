unit Types;

interface

uses Vcl.Forms;

type TIVec3 = array[0..2] of Integer;
type TFVec3 = array[0..2] of Real;

type TIVec2 = array[0..1] of Integer;
type TFVec2 = array[0..1] of Real;

type TFormMertics = record
  position: Vcl.Forms.TPosition;
  top: integer;
  left: integer;
  width: integer;
  height: integer;

  function Valid(): boolean;
end;

implementation

function TFormMertics.Valid(): boolean;
begin
  Valid := (width <> 0) and (height <> 0);
end;

end.