uses Classes, SysUtils;

var CurrentParam: Integer;
var MaxParam: Integer;
var SplitString: TStringList;
var Position: Integer;
var ScannerIndex: Integer;
var ScannerPosition: Integer;
var Layer: Integer;
var Depth: Integer;
var Period: Integer;
var Severity: Integer;
begin
    if ParamCount = 0 then
    begin
        WriteLn('No arguments given');
        Halt(1);
    end;

    CurrentParam := 1;
    MaxParam := ParamCount;
    Position := -1;
    ScannerIndex := 0;
    SplitString := TStringList.Create;
    Severity := 0;

    while CurrentParam <= MaxParam do
    begin
        SplitString.Clear;
        SplitString.Delimiter := ':';
        SplitString.StrictDelimiter := True;
        SplitString.DelimitedText := ParamStr(CurrentParam);

        Position := Position + 1;
        Layer := StrToInt(SplitString.Strings[0]);

        if Position = Layer then
        begin
            CurrentParam := CurrentParam + 1;
            Depth := StrToInt(SplitString.Strings[1]);
            Period := Depth + Depth - 2;
            ScannerPosition := ScannerIndex mod Period;

            if ScannerPosition >= Depth then
            begin
                ScannerPosition := 2 * Depth - 2 - ScannerPosition;
            end;

            if ScannerPosition = 0 then
            begin
                Severity := Severity + Layer * Depth;
            end;
        end;

        ScannerIndex := ScannerIndex + 1;
    end;

    WriteLn(Severity);
end.
