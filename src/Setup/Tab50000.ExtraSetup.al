table 50000 "TTTHGS ExtraSetup"
{
    Caption = 'Extra Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "TTTHGS Code"; Integer)
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TTTHGS Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}