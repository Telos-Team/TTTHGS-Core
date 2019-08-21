pageextension 50010 "TTTHGS TimeSheet" extends "Time Sheet"
{
    layout
    {
        addafter(Type)
        {
            field("TTTHGS JobNo"; "Job No.")
            {
                Caption = 'Sags nr.';
                ToolTip = 'Sagsnr.';
                ApplicationArea = All;
                Width = 5;
            }
            field("TTTHGS JobTaskNo"; "Job Task No.")
            {
                Caption = 'Opg. nr.';
                ToolTip = 'Opgavenr.';
                ApplicationArea = All;
                Width = 3;
            }
            field("TTTHGS WorkTypeCode"; "Work Type Code")
            {
                Caption = 'Arb. type';
                ToolTip = 'Arbejdstypekode';
                ApplicationArea = All;
                Width = 3;
            }
            field("TTTHGS CauseOfAbsenceCode"; "Cause of Absence Code")
            {
                Caption = 'Fravær';
                ToolTip = 'Fraværskode';
                ApplicationArea = All;
                Width = 5;
            }
            field("TTTHGS Chargeable"; Chargeable)
            {
                Caption = 'Fakt.';
                ToolTip = 'Fakturérbar';
                ApplicationArea = All;
                Width = 4;
            }
            field("TTTHGS M2Pcs"; "TTTHGS M2Pcs")
            {
                ApplicationArea = All;
                Width = 3;
            }
        }
        //        moveafter("TTTHGS JobTaskNo"; Field6)
        //        moveafter("TTTHGS CauseOfAbsenceCode"; Description)
        modify(Control1)
        {
            FreezeColumn = Description;
        }
    }
}