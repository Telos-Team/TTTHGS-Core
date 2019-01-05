pageextension 50001 "TTTHGS JobCard" extends "Job Card"
{
    layout
    {
        addafter(General)
        {
            group("TTTHGS Delivery")
            {
                field("TTTHGS DeliveryCustomer"; "TTTHGS DeliveryCustomer")
                {
                    ApplicationArea = All;
                }
                field("TTTHGS DeliveryName"; "TTTHGS DeliveryName")
                {
                    ApplicationArea = All;
                }
                field("TTTHGS DeliveryAddress"; "TTTHGS DeliveryAddress")
                {
                    ApplicationArea = All;
                }
                field("TTTHGS DeliveryPostCode"; "TTTHGS DeliveryPostCode")
                {
                    ApplicationArea = All;
                }
                field("TTTHGS DeliveryCity"; "TTTHGS DeliveryCity")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}