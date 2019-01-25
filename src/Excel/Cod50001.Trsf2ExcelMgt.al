codeunit 50001 "TTTHGS Trsf2ExcelMgt"
{
    Description = 'Transfer2Excel Management';

    trigger OnRun()
    begin

    end;

    procedure Transfer2Excel(parrecTmpl: Record "TTTHGS Trsf2ExcelTemplate")
    var
        loctmprecExcelBuf: Record "Excel Buffer" temporary;
        locrrTable: RecordRef;
        locfrField: FieldRef;
        locintRecordCounter: Integer;
        locintFieldCount: Integer;
        i: Integer;
    begin
        locrrTable.Open(parrecTmpl."TTTHGS TableNo");
        locintFieldCount := locrrTable.FieldCount();
        for i := 1 to locintFieldCount do begin
            locfrField := locrrTable.FieldIndex(i);
            if locfrField.Active() then begin
                loctmprecExcelBuf.Init();
                loctmprecExcelBuf.validate("Column No.", i);
                loctmprecExcelBuf.Validate("Row No.", locintRecordCounter + 1);
                loctmprecExcelBuf.validate("Cell Value as Text", locfrField.Name());
                loctmprecExcelBuf.Bold := true;
                loctmprecExcelBuf.insert(true);
            end;
        end;

        if locrrTable.FindSet() then
            repeat
                locintRecordCounter += 1;
                for i := 1 to locintFieldCount do begin
                    locfrField := locrrTable.FieldIndex(i);
                    if locfrField.Active() then begin
                        loctmprecExcelBuf.Init();
                        loctmprecExcelBuf.validate("Column No.", i);
                        loctmprecExcelBuf.Validate("Row No.", locintRecordCounter + 1);
                        loctmprecExcelBuf.validate("Cell Value as Text", Format(locfrField.Value()));
                        loctmprecExcelBuf.insert(true);
                    end;
                end;
            until locrrTable.Next() = 0;

        loctmprecExcelBuf.CreateNewBook(CopyStr(locrrTable.Name(), 1, 250));
        loctmprecExcelBuf.WriteSheet(locrrTable.Name(), '', '');
        loctmprecExcelBuf.CloseBook();
        loctmprecExcelBuf.OpenExcel();
    end;
}