codeunit 50005 "TTTHGS JobSalesSubscriber"
{
    // <TTT001>
    //   Event subscriber for Job/Sales functions.
    // </TTT001>

    Description = 'Object holds event subscribers to the Job/Sales module.';
    Subtype = Normal;
    SingleInstance = true;
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnBeforeModifySalesHeader', '', true, true)]
    local procedure OnBeforeModifySalesHeader(var SalesHeader: Record "Sales Header"; Job: Record Job)
    begin
        if Job."TTTHGS ExternalDocumentNo" <> '' then
            SalesHeader."External Document No." := job."TTTHGS ExternalDocumentNo";

        if Job."TTTHGS DeliveryName" <> '' then
            SalesHeader."Ship-to Name" := Job."TTTHGS DeliveryName";
        IF Job."TTTHGS DeliveryName2" <> '' then
            SalesHeader."Ship-to Name 2" := Job."TTTHGS DeliveryName2";
        if Job."TTTHGS DeliveryAddress" <> '' then
            SalesHeader."Ship-to Address" := Job."TTTHGS DeliveryAddress";
        if Job."TTTHGS DeliveryAddress2" <> '' then
            SalesHeader."Ship-to Address 2" := job."TTTHGS DeliveryAddress2";
        if Job."TTTHGS DeliveryPostCode" <> '' then
            SalesHeader."Ship-to Post Code" := job."TTTHGS DeliveryPostCode";
        if Job."TTTHGS DeliveryCity" <> '' then
            SalesHeader."Ship-to City" := job."TTTHGS DeliveryCity";
    end;
}