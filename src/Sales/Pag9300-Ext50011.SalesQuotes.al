pageextension 50011 "TTTHGS SalesQuotes" extends "Sales Quotes"
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