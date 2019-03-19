page 50000 "TTTHGS ExtraSetup"
{
    Caption = 'HGS Extra Setup';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "TTTHGS ExtraSetup";

    layout
    {
        area(Content)
        {
            group("TTTHGS Group")
            {
                field("TTTHGS Code"; "TTTHGS Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}