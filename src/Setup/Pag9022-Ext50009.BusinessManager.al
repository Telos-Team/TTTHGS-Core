pageextension 50009 "TTTHGS Bus. Man. Role Center" extends "Business Manager Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addfirst(Processing)
        {
            action("TTTHGS Jobs")
            {
                Caption = 'Jobs';
                ToolTip = 'Show Job List';
                RunObject = page "Job List";
                ApplicationArea = All;
                Image = Job;
            }
        }

        addlast(Processing)
        {
            group("TTTHGS ProcessingAnchor")
            {
                Caption = 'Hummels';
                ToolTip = 'Hummels Processing Menu';
                Image = CostAccounting;
                action("TTTHGS SomeProcessingAction")
                {
                    Caption = 'Test';
                    ToolTip = 'Test';
                    RunObject = codeunit "Type Helper";
                    ApplicationArea = All;
                    image = Import;
                }
            }
        }

    }
}
