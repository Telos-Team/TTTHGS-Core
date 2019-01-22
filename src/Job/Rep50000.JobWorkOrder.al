report 50000 "TTTHGS JobWorkOrder"
{
    Caption = 'Job - Work Order';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './src/Job/Rep50000.JobWorkOrder.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Job; Job)
        {
            RequestFilterFields = "No.", Blocked;

            // Header fields
            column(Caption_Report; textReportCaptionLbl) { }
            column(Today_Report; Format(Today(), 0, 4)) { }
            column(CompanyName_Report; CompanyProperty.DisplayName()) { }
            column(Picture_CompanyInfo; recCompInfo.Picture) { }

            // Caption fields
            column(JobTask_No_Capt; JobTask.FieldCaption("Job Task No.")) { }
            column(JobTask_Descr_Capt; JobTask.FieldCaption(Description)) { }
            column(JobTask_Type_Capt; JobTask.FieldCaption("Job Task Type")) { }
            column(JobTask_StartDate_Capt; JobTask.FieldCaption("Start Date")) { }
            column(JobTask_EndDate_Capt; JobTask.FieldCaption("End Date")) { }

            // Job fields
            column(Job_No_; "No.") { }
            column(Job_Description; Description) { }
            column(Job_Description_2; "Description 2") { }
            column(Job_WorkDescription; TTTHGS_GetWorkDescription()) { }
            column(Job_CustomerNo; "Bill-to Customer No.") { }
            column(Job_DeliveryCustomerNo; "TTTHGS DeliveryCustomer") { }
            dataitem(Job_BillTo; Integer)
            {
                DataItemTableView = sorting (Number);

                column(Job_BillToAddr; txtJobAddr) { }

                trigger OnPreDataItem()
                var
                begin
                    Job.TTTHGS_FormatBillToAddr(arrJobBillToAddr);
                    SetRange(Number, 1, CompressArray(arrJobBillToAddr));
                end;

                trigger OnAfterGetRecord()
                begin
                    txtJobAddr := arrJobBillToAddr[Number];
                end;
            }
            dataitem(Job_Delivery; Integer)
            {
                DataItemTableView = sorting (Number);
                column(Job_DeliveryAddr; txtJobAddr) { }

                trigger OnPreDataItem()
                var
                begin
                    Job.TTTHGS_FormatDeliveryAddr(arrJobDeliveryAddr);
                    SetRange(Number, 1, CompressArray(arrJobDeliveryAddr));
                end;

                trigger OnAfterGetRecord()
                begin
                    txtJobAddr := arrJobDeliveryAddr[Number];
                end;
            }
            dataitem(JobTask; "Job Task")
            {
                DataItemLinkReference = "Job";
                DataItemLink = "Job No." = FIELD ("No.");
                RequestFilterFields = "Job Task No.", "Job Task Type", "Start Date", "End Date";

                column(JobTask_No; "Job Task No.") { }
                column(JobTask_Description; txtJobTaskDescription) { }
                column(JobTask_Type; "Job Task Type") { }
                column(JobTask_StartDate; "Start Date") { }
                column(JobTask_EndDate; "End Date") { }


                dataitem(JobPlanningLine; "Job Planning Line")
                {
                    DataItemLinkReference = "JobTask";
                    DataItemLink = "Job No." = field ("Job No."), "Job Task No." = field ("Job Task No.");
                    DataItemTableView = where ("Line Type" = filter (Budget));

                    column(JobPlanningLine_JobTaskNo; "Job Task No.") { }
                    column(JobPlanningLine_LineNo; "Line No.") { }
                    column(JobPlanningLine_LineType; "Line Type") { }
                    column(JobPlanningLine_No; "No.") { }
                    column(JobPlanningLine_Description; Description) { }
                    column(JobPlanningLine_Qty; Quantity) { }
                    column(JobPlanningLine_UoM; "Unit of Measure Code") { }
                }

                trigger OnAfterGetRecord()
                var
                begin
                    if not booJobTasksHaveHeadings then
                        booJobTasksHaveHeadings := "Job Task Type" <> "Job Task Type"::Posting;
                    txtJobTaskDescription := Description;
                    if booJobTasksHaveHeadings then
                        if "Job Task Type" = "Job Task Type"::Posting then
                            txtJobTaskDescription := '- ' + txtJobTaskDescription;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //if "TTTHGS DeliveryCustomer" = '' then
                //    "TTTHGS DeliveryCustomer" := "Bill-to Customer No.";
                //if "TTTHGS DeliveryContact" = '' then
                //    "TTTHGS DeliveryContact" := "Bill-to Contact No.";
            end;
        }
    }

    trigger OnPreReport()
    var
    begin
        recCompInfo.Get();
        recCompInfo.CalcFields(Picture);
    end;

    var
        recCompInfo: Record "Company Information";
        textReportCaptionLbl: Label 'Work Order';
        arrJobDeliveryAddr: array[8] of Text;
        arrJobBillToAddr: array[8] of Text;
        txtJobAddr: Text;
        txtJobTaskDescription: Text;
        txtStartDate: Text;
        txtEndDate: Text;
        booJobTasksHaveHeadings: Boolean;
}
