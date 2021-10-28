unit StringUtils;

interface

function ConvertANSItoASCII(s: string): string;
function ConvertASCIItoANSI(a: string): string;

implementation

function ConvertANSItoASCII(s: string): string;
begin
  for var i := 1 to length(s) do
    if ord(s[i]) in [192..239] then
      s[i] := chr(ord(s[i]) - 64)
    else if ord(s[i]) in [240..255] then
      s[i] := chr(ord(s[i]) - 16)
    else if ord(s[i]) = 168 then
      s[i] := chr(ord(240))
    else if ord(s[i]) = 184 then
      s[i] := chr(ord(241));

  ConvertANSItoASCII := s;
end;

function ConvertASCIItoANSI(a: string): string;
begin
  for var i := 1 to length(a) do
    if ord(a[i]) in [128..175] then
      a[i] := chr(ord(a[i]) + 64)
    else if ord(a[i]) in [224..239] then
      a[i] := chr(ord(a[i]) + 16)
    else if ord(a[i]) = 240 then
      a[i] := chr(ord(168))
    else if ord(a[i]) = 241 then
      a[i] := chr(ord(184));

  ConvertASCIItoANSI := a;
end;

end.