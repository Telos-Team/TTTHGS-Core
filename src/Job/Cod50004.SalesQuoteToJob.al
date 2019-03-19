codeunit 50004 "TTTHGS SalesQuoteToJob"
{
    TableNo = 36;
    Description = '';

    trigger OnRun()
    begin
        TestField("Document Type", "Document Type"::Quote);
    end;

    // CreateWorkDescription
    // New fields Quote No, Order No.

    procedure GetJob(var parvarrecJob: Record "Job")
    var
    begin
        parvarrecJob := recJob;
    end;

    var
        recJob: Record "Job";
}

/*

CALCFIELDS(Work Description");
CreateSalesHeader(Rec,Cust."Prepayment %");

TransferQuoteToSalesOrderLines(SalesQuoteLine,Rec,SalesOrderLine,SalesOrderHeader,Cust);

SalesSetup.GET;
CASE SalesSetup."Archive Quotes" OF
  SalesSetup."Archive Quotes"::Always:
    ArchiveManagement.ArchSalesDocumentNoConfirm(Rec);
  SalesSetup."Archive Quotes"::Question:
    ArchiveManagement.ArchiveSalesDocument(Rec);
END;

IF SalesSetup."Default Posting Date" = SalesSetup."Default Posting Date"::"No Date" THEN BEGIN
  SalesOrderHeader."Posting Date" := 0D;
  SalesOrderHeader.MODIFY;
END;

SalesCommentLine.CopyComments("Document Type",SalesOrderHeader."Document Type","No.",SalesOrderHeader."No.");
RecordLinkManagement.CopyLinks(Rec,SalesOrderHeader);


LOCAL CreateSalesHeader(SalesHeader : Record "Sales Header";PrepmtPercent : Decimal)
WITH SalesHeader DO BEGIN
  SalesOrderHeader := SalesHeader;
  SalesOrderHeader."Document Type" := SalesOrderHeader."Document Type"::Order;

  SalesOrderHeader."No. Printed" := 0;
  SalesOrderHeader.Status := SalesOrderHeader.Status::Open;
  SalesOrderHeader."No." := '';
  SalesOrderHeader."Quote No." := "No.";
  SalesOrderLine.LOCKTABLE;
  SalesOrderHeader.INSERT(TRUE);

  SalesOrderHeader."Order Date" := "Order Date";
  IF "Posting Date" <> 0D THEN
    SalesOrderHeader."Posting Date" := "Posting Date";

  SalesOrderHeader.InitFromSalesHeader(SalesHeader);
  SalesOrderHeader."Outbound Whse. Handling Time" := "Outbound Whse. Handling Time";
  SalesOrderHeader.Reserve := Reserve;

  SalesOrderHeader."Prepayment %" := PrepmtPercent;
  IF SalesOrderHeader."Posting Date" = 0D THEN
    SalesOrderHeader."Posting Date" := WORKDATE;
  OnBeforeInsertSalesOrderHeader(SalesOrderHeader,SalesHeader);
  SalesOrderHeader.MODIFY;
END;


LOCAL TransferQuoteToSalesOrderLines(VAR QuoteSalesLine : Record "Sales Line";VAR QuoteSalesHeader : Record "Sales Header";VAR OrderSalesLine : Record "Sales Line";VAR OrderSalesHeader : Record "Sales Header";Customer : Record Customer)
QuoteSalesLine.RESET;
QuoteSalesLine.SETRANGE("Document Type",QuoteSalesHeader."Document Type");
QuoteSalesLine.SETRANGE("Document No.",QuoteSalesHeader."No.");
IF QuoteSalesLine.FINDSET THEN
  REPEAT
    IF QuoteSalesLine.Type = QuoteSalesLine.Type::Resource THEN
      IF QuoteSalesLine."No." <> '' THEN
        IF Resource.GET(QuoteSalesLine."No.") THEN BEGIN
          Resource.CheckResourcePrivacyBlocked(FALSE);
          Resource.TESTFIELD(Blocked,FALSE);
        END;
    OrderSalesLine := QuoteSalesLine;
    OrderSalesLine."Document Type" := OrderSalesHeader."Document Type";
    OrderSalesLine."Document No." := OrderSalesHeader."No.";
    OrderSalesLine."Shortcut Dimension 1 Code" := QuoteSalesLine."Shortcut Dimension 1 Code";
    OrderSalesLine."Shortcut Dimension 2 Code" := QuoteSalesLine."Shortcut Dimension 2 Code";
    OrderSalesLine."Dimension Set ID" := QuoteSalesLine."Dimension Set ID";
    IF Customer."Prepayment %" <> 0 THEN
      OrderSalesLine."Prepayment %" := Customer."Prepayment %";
    PrepmtMgt.SetSalesPrepaymentPct(OrderSalesLine,OrderSalesHeader."Posting Date");
    OrderSalesLine.VALIDATE("Prepayment %");
    IF OrderSalesLine."No." <> '' THEN
      OrderSalesLine.DefaultDeferralCode;
    OnBeforeInsertSalesOrderLine(OrderSalesLine,OrderSalesHeader,QuoteSalesLine,QuoteSalesHeader);
    OrderSalesLine.INSERT;
    OnAfterInsertSalesOrderLine(OrderSalesLine,OrderSalesHeader,QuoteSalesLine,QuoteSalesHeader);
    ATOLink.MakeAsmOrderLinkedToSalesOrderLine(QuoteSalesLine,OrderSalesLine);
    SalesLineReserve.TransferSaleLineToSalesLine(
      QuoteSalesLine,OrderSalesLine,QuoteSalesLine."Outstanding Qty. (Base)");
    SalesLineReserve.VerifyQuantity(OrderSalesLine,QuoteSalesLine);

    IF OrderSalesLine.Reserve = OrderSalesLine.Reserve::Always THEN
      OrderSalesLine.AutoReserve;

  UNTIL QuoteSalesLine.NEXT = 0;

*/
