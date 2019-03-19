pageextension 50003 "TTTHGS SalesList" extends "Sales List"
{
    layout
    {
        addafter("Ship-to Name")
        {
            field("TTTHGS ShipToAddress"; "Ship-To Address")
            {
                ApplicationArea = All;
            }
        }
    }
}