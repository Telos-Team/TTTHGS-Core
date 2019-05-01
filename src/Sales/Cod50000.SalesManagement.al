codeunit 50000 "TTTHGS SalesManagement"
{
    Description = 'Special functions for sales management';

    trigger OnRun()
    begin
    end;

    procedure GetFIK71SH(parrecSIH: Record "Sales Invoice Header") ReturnValue: Text
    var
        locrecCompSetup: Record "Company Information";
        locintLength: Integer;
        loccodPaymentReference: Code[16];
        loccodModulus: Code[1];
    begin
        locrecCompSetup.Get();
        if locrecCompSetup."BankCreditorNo" = '' then
            exit;
        locintLength := 15;
        loccodPaymentReference := PADSTR('', locintLength - 2 - STRLEN(parrecSIH."No."), '0') + parrecSIH."No." + '0';
        loccodModulus := Modulus10(loccodPaymentReference);
        if loccodModulus = '' then
            exit;
        loccodPaymentReference := copystr(loccodPaymentReference + loccodModulus, 1, 16);
        exit(StrSubstNo('+71<%1+%2<', loccodPaymentReference, locrecCompSetup.BankCreditorNo));
    end;

    procedure GetFIK71Cust(parrecCust: Record "Customer") ReturnValue: Text
    var
        locrecCompSetup: Record "Company Information";
        locintLength: Integer;
        loccodPaymentReference: Code[16];
        loccodModulus: Code[1];
    begin
        locrecCompSetup.Get();
        if locrecCompSetup."BankCreditorNo" = '' then
            exit;
        locintLength := 15;
        loccodPaymentReference := PADSTR('', locintLength - 2 - STRLEN(parrecCust."No."), '0') + parrecCust."No." + '9';
        loccodModulus := Modulus10(loccodPaymentReference);
        if loccodModulus = '' then
            exit;
        loccodPaymentReference := copystr(loccodPaymentReference + loccodModulus, 1, 16);
        exit(StrSubstNo('+71<%1+%2<', loccodPaymentReference, locrecCompSetup.BankCreditorNo));
    end;

    procedure GetFIK71Remind(parrecReminder: Record "Issued Reminder Header") ReturnValue: Text
    var
        locrecCompSetup: Record "Company Information";
        locintLength: Integer;
        loccodPaymentReference: Code[16];
        loccodModulus: Code[1];
    begin
        locrecCompSetup.Get();
        if locrecCompSetup."BankCreditorNo" = '' then
            exit;
        locintLength := 15;
        loccodPaymentReference := PADSTR('', locintLength - 2 - STRLEN(parrecReminder."Customer No."), '0') + parrecReminder."Customer No." + '9';
        loccodModulus := Modulus10(loccodPaymentReference);
        if loccodModulus = '' then
            exit;
        loccodPaymentReference := copystr(loccodPaymentReference + loccodModulus, 1, 16);
        exit(StrSubstNo('+71<%1+%2<', loccodPaymentReference, locrecCompSetup.BankCreditorNo));
    end;

    procedure Modulus10(parcodNumber: Code[16]): Code[1]
    var
        locintWeight: Integer;
        locintCounter: Integer;
        locintAccumulator: Integer;
        loctxtSumStr: Text;
    begin
        locintWeight := 2;
        for locintCounter := StrLen(parcodNumber) DOWNTO 1 DO begin
            if not Evaluate(locintAccumulator, CopyStr(parcodNumber, locintCounter, 1)) then
                exit;
            locintAccumulator := locintAccumulator * locintWeight;
            loctxtSumStr := loctxtSumStr + Format(locintAccumulator);
            if locintWeight = 1 then
                locintWeight := 2
            else
                locintWeight := 1;
        end;
        locintAccumulator := 0;
        for locintCounter := 1 to StrLen(loctxtSumStr) do begin
            if not Evaluate(locintWeight, CopyStr(loctxtSumStr, locintCounter, 1)) then
                exit;
            locintAccumulator := locintAccumulator + locintWeight;
        end;
        locintAccumulator := 10 - (locintAccumulator MOD 10);
        if locintAccumulator = 10 then
            exit('0')
        else
            exit(format(locintAccumulator));
    end;
}
