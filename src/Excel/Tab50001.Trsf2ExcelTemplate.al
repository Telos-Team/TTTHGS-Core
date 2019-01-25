table 50001 "TTTHGS Trsf2ExcelTemplate"
{
    Caption = 'Transfer2Excel Template';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "TTTHGS Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; "TTTHGS TableNo"; Integer)
        {
            Caption = 'Table No.';
            DataClassification = SystemMetadata;
        }
        field(3; "TTTHGS TableFilter"; TableFilter)
        {
            Caption = 'Table Filter';
            DataClassification = SystemMetadata;
        }
        field(4; "TTTHGS RequestPage"; Blob)
        {
            Caption = 'Request Page';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "TTTHGS Code")
        {
            Clustered = true;
        }
    }
}