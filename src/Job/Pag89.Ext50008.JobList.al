pageextension 50008 "TTTHGS JobList" extends "Job List"
{
    layout
    {
        addafter("Project Manager")
        {
            field("TTTHGS BillToName"; "Bill-to Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("TTTHGS ShipToName"; "TTTHGS DeliveryName")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}