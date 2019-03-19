codeunit 50003 "TTTHGS SalesQuoteToJobYesNo"
{
    TableNo = 36;
    Description = '';

    trigger OnRun()
    begin
        TestField("Document Type", "Document Type"::Quote);
        if GuiAllowed() then
            if not Confirm(lblConfirmConvertToJobTxt, false) then
                exit;

        cuSalesQuoteToOrder.Run(Rec);
        cuSalesQuoteToOrder.GetJob(recJob);
        Commit();

        if not GuiAllowed() then
            exit;

        recJob.SetRecFilter();
        pagJobCard.SetTableView(recJob);
        pagJobCard.Run();
    end;

    var
        recJob: Record "Job";
        cuSalesQuoteToOrder: Codeunit "TTTHGS SalesQuoteToJob";
        pagJobCard: Page "Job Card";
        lblConfirmConvertToJobTxt: Label 'Do you want to convert the quote to an order?';
}