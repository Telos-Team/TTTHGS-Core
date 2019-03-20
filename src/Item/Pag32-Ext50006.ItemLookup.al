pageextension 50006 "TTTHGS ItemLookup" extends "Item Lookup"
{
    layout
    {
        addafter("Unit Price")
        {
            field("TTTHGS Inventory"; Inventory)
            {
                ApplicationArea = All;
            }
            field("TTTHGS UnitCost"; "Unit Cost")
            {
                ApplicationArea = All;
            }
        }
    }
}
