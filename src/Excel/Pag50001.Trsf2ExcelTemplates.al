page 50001 "TTTHGS Trsf2ExcelTemplates"
{
    Caption = 'Transfer2Excel Templates';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "TTTHGS Trsf2ExcelTemplate";

    layout
    {
        area(Content)
        {
            repeater("TTTHGS Group")
            {
                field("TTTHGS Code"; "TTTHGS Code")
                {
                    ApplicationArea = All;
                }
                field("TTTHGS TableNo"; "TTTHGS TableNo")
                {
                    ApplicationArea = All;
                }
                field("TTTHGS TableFilter"; "TTTHGS TableFilter")
                {
                    ApplicationArea = All;
                }
                field("TTTHGS RequestPage"; "TTTHGS RequestPage".HasValue())
                {
                    Caption = 'Request Page';
                    ApplicationArea = All;
                    BlankZero = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("TTTHGS Action")
            {
                Caption = 'Transfer2Excel';
                Image = Excel;
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    loccuMgt: Codeunit "TTTHGS Trsf2ExcelMgt";
                begin
                    loccuMgt.Transfer2Excel(rec);
                end;
            }
        }
    }
}