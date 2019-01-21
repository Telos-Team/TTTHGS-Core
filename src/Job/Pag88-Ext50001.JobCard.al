pageextension 50001 "TTTHGS JobCard" extends "Job Card"
{
    layout
    {
        addafter("Project Manager")
        {
            field("TTTHGS YourReference"; "TTTHGS YourReference")
            {
                ApplicationArea = All;
            }
            field("TTTHGS ExternalDocumentNo"; "TTTHGS ExternalDocumentNo")
            {
                ApplicationArea = All;
            }
        }
        addafter(General)
        {
            group("TTTHGS WorkDescription Group")
            {
                Caption = 'HGS Arbejdsbeskrivelse';
                field("TTTHGS WorkDescription"; txtWorkDescription)
                {
                    Caption = '';
                    MultiLine = true;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        TTTHGS_SetWorkDescription(txtWorkDescription);
                    end;
                }
            }
            group("TTTHGS Delivery")
            {
                Caption = 'HGS Levering';
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
                field("TTTHGS DeliveryPhoneNo"; "TTTHGS DeliveryPhoneNo")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        addfirst(Reporting)
        {
            action("TTTHGS JobWorkOrder")
            {
                Caption = 'Work Order';
                ApplicationArea = All;
                Image = Action;
                trigger OnAction()
                var
                begin
                    rec.TTTHGS_PrintJobWorkOrder();
                end;
            }
        }
        addLast(Reporting)
        {
            action("TTTHGS TTTPR WorkOrder")
            {
                Caption = 'TTTPR1';
                ApplicationArea = All;
                Image = Action;
                trigger OnAction()
                var
                    locrepWorkOrder: Report "TTTHGS JobWorkOrder";
                begin
                    locrepWorkOrder.Run();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        txtWorkDescription := TTTHGS_GetWorkDescription();
    end;

    var
        txtWorkDescription: Text;
}