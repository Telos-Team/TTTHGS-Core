pageextension 50005 "TTTHGS SalesQuoteJobIntegr" extends "Sales Quote"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(MakeOrder)
        {
            action("TTTHGS MakeJob")
            {
                Caption = 'Create Job';
                ToolTip = 'Convert the sales quote to a job.';
                Image = MakeOrder;
                ApplicationArea = All;
                RunObject = Page 21;
                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"TTTHGS SalesQuoteToJobYesNo", Rec);
                end;
            }
        }
    }
}