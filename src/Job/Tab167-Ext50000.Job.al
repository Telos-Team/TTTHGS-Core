tableextension 50000 "TTTHGS Job" extends Job
{
    fields
    {
        field(50000; "TTTHGS DeliveryCustomer"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(50001; "TTTHGS DeliveryContact"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(50002; "TTTHGS DeliveryName"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "TTTHGS DeliveryName2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50004; "TTTHGS DeliveryAddress"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50005; "TTTHGS DeliveryAddress2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50006; "TTTHGS DeliveryPostCode"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50007; "TTTHGS DeliveryCity"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50008; "TTTHGS DeliveryPhoneNo"; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }

    procedure TTTHGS_AddressArray2List(pararrAddr: array[8] of Text[90]; var parvarlstAddr: List of [Text]): Integer
    var
        locintCount: Integer;
        locintElements: Integer;
    begin
        Clear(parvarlstAddr);
        locintElements := CompressArray(pararrAddr);
        for locintCount := 1 to locintElements do
            if pararrAddr[locintCount] <> '' then
                parvarlstAddr.Add(pararrAddr[locintCount]);
        exit(locintElements);
    end;

    procedure TTTHGS_FormatBillToAddr(var parvararrAddr: array[8] of Text[90]): Integer;
    var
        locrecCust: Record Customer;
        loccuFormatAddr: Codeunit "Format Address";
    begin
        Clear(parvararrAddr);
        locrecCust."No." := "Bill-to Customer No.";
        locrecCust.Name := "Bill-to Name";
        locrecCust."Name 2" := "Bill-to Name 2";
        locrecCust.Address := "Bill-to Address";
        locrecCust."Address 2" := "Bill-to Address 2";
        locrecCust."Post Code" := "Bill-to Post Code";
        locrecCust.City := "Bill-to City";
        locreccust.Contact := "Bill-to Contact";
        locrecCust."Primary Contact No." := "Bill-to Contact No.";
        locrecCust.County := "Bill-to County";
        locrecCust."Country/Region Code" := "Bill-to Country/Region Code";
        loccuFormatAddr.Customer(parvararrAddr, locrecCust);
        exit(CompressArray(parvararrAddr));
    end;

    procedure TTTHGS_FormatBillToAddr(var parvarlstAddr: List of [Text]): Integer
    var
        locarrAddr: array[8] of Text[90];
    begin
        Clear(parvarlstAddr);
        TTTHGS_FormatBillToAddr(locarrAddr);
        exit(TTTHGS_AddressArray2List(locarrAddr, parvarlstAddr));
    end;

    procedure TTTHGS_FormatDeliveryAddr(var parvararrAddr: array[8] of Text[90]): Integer;
    var
        locrecCust: Record Customer;
        loccuFormatAddr: Codeunit "Format Address";
    begin
        Clear(parvararrAddr);
        locrecCust."No." := "TTTHGS DeliveryCustomer";
        locrecCust.Name := "TTTHGS DeliveryName";
        locrecCust."Name 2" := "TTTHGS DeliveryName2";
        locrecCust.Address := "TTTHGS DeliveryAddress";
        locrecCust."Address 2" := "TTTHGS DeliveryAddress2";
        locrecCust."Post Code" := "TTTHGS DeliveryPostCode";
        locrecCust.City := "TTTHGS DeliveryCity";
        locrecCust."Primary Contact No." := "TTTHGS DeliveryContact";
        loccuFormatAddr.Customer(parvararrAddr, locrecCust);
        exit(CompressArray(parvararrAddr));
    end;

    procedure TTTHGS_FormatDeliveryAddr(var parvarlstAddr: List of [Text]): Integer
    var
        locarrAddr: array[8] of Text[90];
    begin
        Clear(parvarlstAddr);
        TTTHGS_FormatBillToAddr(locarrAddr);
        exit(TTTHGS_AddressArray2List(locarrAddr, parvarlstAddr));
    end;
}