pageextension 50004 "TTTHGS PostedSalesInvoices" extends "Posted Sales Invoices"
{
    layout
    {
        addlast(Control1)
        {
            field("TTTHGS ShipToAddress"; "Ship-To Address")
            {
                ApplicationArea = All;
            }
        }
    }
}