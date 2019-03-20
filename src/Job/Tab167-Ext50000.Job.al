tableextension 50000 "TTTHGS Job" extends Job
{
    fields
    {
        field(50000; "TTTHGS DeliveryCustomer"; Code[20])
        {
            Caption = 'Delivery Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;

            trigger OnValidate()
            var
                locrecCust: Record Customer;
            begin
                if not locrecCust.Get("TTTHGS DeliveryCustomer") then
                    exit;
                "TTTHGS DeliveryName" := locrecCust.Name;
                "TTTHGS DeliveryName2" := locrecCust."Name 2";
                "TTTHGS DeliveryAddress" := locrecCust.Address;
                "TTTHGS DeliveryAddress2" := locrecCust."Address 2";
                "TTTHGS DeliveryPostCode" := locrecCust."Post Code";
                "TTTHGS DeliveryCity" := locrecCust.City;
                "TTTHGS DeliveryPhoneNo" := locrecCust."Phone No.";
            end;
        }
        field(50001; "TTTHGS DeliveryContact"; Code[20])
        {
            Caption = 'Delivery Contact No.';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(50002; "TTTHGS DeliveryName"; Text[50])
        {
            Caption = 'Delivery Name';
            DataClassification = CustomerContent;
        }
        field(50003; "TTTHGS DeliveryName2"; Text[50])
        {
            Caption = 'Delivery Name 2';
            DataClassification = CustomerContent;
        }
        field(50004; "TTTHGS DeliveryAddress"; Text[50])
        {
            Caption = 'Delivery Address';
            DataClassification = CustomerContent;
        }
        field(50005; "TTTHGS DeliveryAddress2"; Text[50])
        {
            Caption = 'Delivery Address 2';
            DataClassification = CustomerContent;
        }
        field(50006; "TTTHGS DeliveryPostCode"; Code[20])
        {
            Caption = 'Delivery Post Code';
            DataClassification = CustomerContent;
        }
        field(50007; "TTTHGS DeliveryCity"; Text[30])
        {
            Caption = 'Delivery City';
            DataClassification = CustomerContent;
        }
        field(50008; "TTTHGS DeliveryPhoneNo"; Text[30])
        {
            Caption = 'Delivery Phone No.';
            DataClassification = CustomerContent;
        }
        field(50009; "TTTHGS WorkDescription"; Blob)
        {
            Caption = 'Work Description';
            DataClassification = CustomerContent;
        }
        field(50010; "TTTHGS YourReference"; Text[35])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
        }
        field(50011; "TTTHGS ExternalDocumentNo"; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(50012; "TTTHGS QuoteNo"; Code[20])
        {
            Caption = 'Quote No.';
            DataClassification = CustomerContent;
        }
        field(50013; "TTTHGS OrderNo"; Code[20])
        {
            Caption = 'Order No.';
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
        if (locreccust."no." = '') and
            (locrecCust.Name = '') and
            (locrecCust."Name 2" = '') and
            (locrecCust.Address = '') and
            (locrecCust."Address 2" = '') and
            (locrecCust."Post Code" = '') and
            (locrecCust.City = '') and
            (locrecCust."Primary Contact No." = '')
        then
            exit(TTTHGS_FormatBillToAddr(parvararraddr));
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

    procedure TTTHGS_PrintJobWorkOrder()
    var
        locrecJob: Record Job;
        locrepJobWorkOrder: Report "TTTHGS JobWorkOrder";
    begin
        locrecJob := rec;
        locrecJob.SetRecFilter();
        locrepJobWorkOrder.SetTableView(locrecJob);
        locrepJobWorkOrder.Run();
    end;

    procedure "TTTHGS_SetWorkDescription"(partxtNewWorkDescription: Text)
    var
        loctmprecBlob: Record TempBlob;
    begin
        CLEAR("TTTHGS WorkDescription");
        IF partxtNewWorkDescription = '' THEN
            EXIT;
        loctmprecBlob.Blob := "TTTHGS WorkDescription";
        loctmprecBlob.WriteAsText(partxtNewWorkDescription, TEXTENCODING::Windows);
        "TTTHGS WorkDescription" := loctmprecBlob.Blob;
        MODIFY();
    end;

    procedure TTTHGS_GetWorkDescription(): Text
    begin
        CALCFIELDS("TTTHGS WorkDescription");
        EXIT(TTTHGS_GetWorkDescriptionWorkDescriptionCalculated());
    end;

    procedure TTTHGS_GetWorkDescriptionWorkDescriptionCalculated(): Text
    var
        loctmprecBlob: Record TempBlob;
        CR: Text[1];
    begin
        IF NOT "TTTHGS WorkDescription".HASVALUE() THEN
            EXIT('');

        CR[1] := 10;
        loctmprecBlob.Blob := "TTTHGS WorkDescription";
        EXIT(loctmprecBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;
}