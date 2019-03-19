pageextension 50000 "TTTHGS SalesOrder" extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Co&mments")
        {
            action("TTTHGS CustomerComments")
            {
                Caption = 'Customer Comments';
                ToolTip = 'View or add comments for the record.';
                ApplicationArea = Comments;
                Image = ViewComments;
                RunObject = Page "Comment List";
                RunPageMode = View;
                RunPageLink = "No." = field ("Sell-to Customer No.");
                RunPageView = where ("Table Name" = const ("Customer"));
            }
        }
    }
}