codeunit 50004 "TTTHGS SalesQuoteToJob"
{
    TableNo = 36;
    Description = 'This codeunit will create a job based on a quote or order.';

    trigger OnRun()
    begin
        recSH := Rec;
        Code();
        Rec := recSH;
    end;

    local procedure Code()
    begin
        PerformTests();
        FindJobPostingGroup();
        CreateJob();
        FillJob();
        CreateWorkDescription();
        SaveJob();
        CopyLines();
        CopyComments();
        CopyLinks();
        DeleteDocument();
    end;

    local procedure PerformTests()
    begin
        if not (recsh."Document Type" in [recsh."Document Type"::Quote, recsh."Document Type"::Order]) then
            recsh.TestField("Document Type", recsh."Document Type"::Quote);
    end;

    local procedure FindJobPostingGroup()
    var
        locrecJobSetup: Record "Jobs Setup";
    begin
        locrecJobSetup.Get();
        locrecJobSetup.TestField("Default Job Posting Group");
        recJobPostingGroup.Get(locrecJobSetup."Default Job Posting Group");
    end;

    local procedure CreateJob()
    begin
        recJob.Init();
        recJob.Insert(true);
    end;

    local procedure SaveJob()
    begin
        recJob.Modify(true);
    end;

    local procedure FillJob()
    begin
        recJob.Validate(Status, recJob.Status::Open);
        recJob.Validate("Job Posting Group", recJobPostingGroup.Code);

        recJob.Validate("Bill-to Customer No.", recSH."Sell-to Customer No.");
        recJob.Validate(Description, recSH."Ship-to Address");
        if recSH."Shortcut Dimension 1 Code" <> '' then
            recJob.Validate("Global Dimension 1 Code", recSH."Shortcut Dimension 1 Code");
        if recSH."Shortcut Dimension 2 Code" <> '' then
            recJob.Validate("Global Dimension 2 Code", recSH."Shortcut Dimension 2 Code");
        recJob.Validate("TTTHGS ExternalDocumentNo", recsh."External Document No.");
        recJob.Validate("TTTHGS YourReference", recsh."Your Reference");
        //recJob.Validate("TTTHGS DeliveryCustomer");
        //recJob.Validate("TTTHGS DeliveryContact");
        recJob.Validate("TTTHGS DeliveryName", recSH."Ship-to Name");
        recJob.Validate("TTTHGS DeliveryName2", recSH."Ship-to Name 2");
        recJob.Validate("TTTHGS DeliveryAddress", recSH."Ship-to Address");
        recJob.Validate("TTTHGS DeliveryAddress2", recSH."Ship-to Address 2");
        recJob.Validate("TTTHGS DeliveryPostCode", recSH."Ship-to Post Code");
        recJob.Validate("TTTHGS DeliveryCity", recSH."Ship-to City");

        if recSH."Document Type" = recSH."Document Type"::Quote then
            recJob.Validate("TTTHGS QuoteNo", recsh."No.")
        else begin
            recJob.Validate("TTTHGS QuoteNo", recsh."Quote No.");
            recJob.Validate("TTTHGS OrderNo", recsh."No.");
        end;
    end;

    local procedure CreateWorkDescription()
    var
        locrecSL: Record "Sales Line";
        loctbDescription: TextBuilder;
        locstrmOut: OutStream;
    begin
        locrecSL.SetRange("Document Type", recSH."Document Type");
        locrecSL.SetRange("Document No.", recsh."no.");
        locrecSL.SetRange(Type, locrecSL.Type::" ");
        if not locrecSL.FindSet() then
            exit;
        repeat
            loctbDescription.AppendLine(DelChr(StrSubstNo('%1 %2 ', locrecSL.Description, locrecSL."Description 2"), '>', ' '));
        until locrecSL.Next() = 0;
        recJob."TTTHGS WorkDescription".CreateOutStream(locstrmOut);
        locstrmOut.WriteText(DelChr(loctbDescription.ToText(), '>', ' '));
    end;

    local procedure CreateJobTask()
    var
        locrecJobTask: Record "Job Task";
    begin
        locrecJobTask.Init();
        locrecJobTask.Validate("Job No.", recJob."No.");
        locrecJobTask.Validate("Job Task No.", lblJobTaskNoTok);
        locrecJobTask.Validate("Job Task Type", locrecJobTask."Job Task Type"::Posting);
        locrecJobTask.Insert(true);
    end;

    local procedure CopyLines()
    var
        locrecSL: Record "Sales Line";
    begin
        locrecSL.SetRange("Document Type", recSH."Document Type");
        locrecSL.SetRange("Document No.", recSH."No.");
        locrecSL.SetFilter(Type, '%1|%2|%3', locrecSL.Type::" ", locrecSL.Type::"G/L Account", locrecSL.Type::"item");
        if not locrecSL.FindSet() then
            exit;
        CreateJobTask();
        repeat
            CopyLine(locrecSL);
        until locrecSL.Next() = 0;
    end;

    local procedure CopyLine(parrecSL: Record "Sales Line")
    var
        locrecJobPlanLine: Record "Job Planning Line";
    begin
        //   parrecSL.TestField(Type);
        locrecJobPlanLine.SetRange("Job No.", recJob."No.");
        locrecJobPlanLine.SetRange("Job Task No.", lblJobTaskNoTok);
        if locrecJobPlanLine.FindLast() then;

        locrecJobPlanLine.Init();
        locrecJobPlanLine.Validate("Job No.", recJob."No.");
        locrecJobPlanLine.Validate("Job Task No.", lblJobTaskNoTok);
        locrecJobPlanLine."Line No." += 10000;
        locrecJobPlanLine.Insert(true);

        case parrecSL.Type of
            parrecSL.type::" ":
                locrecJobPlanLine.Validate(Type, locrecJobPlanLine.Type::Text);
            parrecSL.Type::"G/L Account":
                locrecJobPlanLine.Validate(Type, locrecJobPlanLine.Type::"G/L Account");
            parrecSL.Type::"Item":
                locrecJobPlanLine.Validate(Type, locrecJobPlanLine.Type::Item);
        end;
        if parrecSL.Type <> parrecSL.type::" " then begin
            locrecJobPlanLine.Validate("Line Type", locrecJobPlanLine."Line Type"::Billable);
            locrecJobPlanLine.Validate("No.", parrecSL."No.");
            locrecJobPlanLine.Validate(Quantity, parrecSL.Quantity);
            locrecJobPlanLine.Validate("Unit Price", parrecSL."Unit Price");
            locrecJobPlanLine.Validate("Line Discount %", parrecsl."Line Discount %");
        end;
        locrecJobPlanLine.Validate("Description", parrecsl."Description");
        locrecJobPlanLine.Validate("Description 2", parrecsl."Description 2");
        locrecJobPlanLine.Modify(false);
    end;

    local procedure CopyComments()
    var
        locrecSalesCommentLine: Record "Sales Comment Line";
        locrecCommentLine: Record "Comment Line";
    begin
        locrecSalesCommentLine.SetRange("Document Type");
        locrecSalesCommentLine.SetRange("No.");
        locrecSalesCommentLine.SetRange("Document Line No.", 0);
        if not locrecSalesCommentLine.FindSet() then
            exit;
        repeat
            locrecCommentLine.Init();
            locrecCommentLine."Table Name" := locrecCommentLine."Table Name"::Job;
            locrecCommentLine."No." := recJob."No.";
            locrecCommentLine."Line No." := locrecSalesCommentLine."Line No.";
            locrecCommentLine.Insert(true);
            locrecCommentLine.Validate(Code, locrecSalesCommentLine.Code);
            locrecCommentLine.Validate(Date, locrecSalesCommentLine.Date);
            locrecCommentLine.Validate(Comment, locrecSalesCommentLine.Comment);
            locrecCommentLine.Modify(true);
        until locrecSalesCommentLine.Next() = 0;
    end;

    local procedure CopyLinks()
    var
        loccuRecLinkMgt: Codeunit "Record Link Management";
    begin
        loccuRecLinkMgt.CopyLinks(recSH, recJob);
    end;

    local procedure DeleteDocument()
    var
        locrecSH: Record "Sales Header";
    begin
        case recSH."Document Type" of
            recsh."Document Type"::Order:
                begin
                    locrecSH.Get(recsh."Document Type", recsh."No.");
                    locrecSH.Delete(true);
                end;
        end;
    end;

    procedure GetJob(var parvarrecJob: Record "Job")
    var
    begin
        parvarrecJob := recJob;
    end;

    var
        recJob: Record "Job";
        recJobPostingGroup: Record "Job Posting Group";
        recSH: Record "Sales Header";
        lblJobTaskNoTok: Label '100';
}
