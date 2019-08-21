pageextension 50012 "TTTHGS CustomerList" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field("TTTHGS Address"; Address)
            {
                ApplicationArea = All;
            }
        }
    }
}