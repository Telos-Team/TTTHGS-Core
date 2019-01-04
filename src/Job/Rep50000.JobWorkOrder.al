report 50000 "TTTHGS JobWorkOrder"
{
    Caption = 'Job - Work Order';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    WordLayout = './src/Job/JobWorkOrder.docx';
    DefaultLayout = Word;

    dataset
    {
        dataitem(ReportHeader; Integer)
        {
            DataItemTableView = where (Number = CONST (1));

            column(ReportCaption; textReportCaptionLbl)
            {
            }
            column(ReportToday; Format(Today(), 0, 4))
            {
            }
            column(ReportCompanyName; CompanyProperty.DisplayName())
            {
            }
            column(JobTask_No_Capt; JobTask.FieldCaption("Job Task No."))
            {
            }
            column(JobTask_Descr_Capt; JobTask.FieldCaption(Description))
            {
            }
            column(JobTask_Type_Capt; JobTask.FieldCaption("Job Task Type"))
            {
            }
            column(JobTask_StartDate_Capt; JobTask.FieldCaption("Start Date"))
            {
            }
            column(JobTask_EndDate_Capt; JobTask.FieldCaption("End Date"))
            {
            }

            trigger OnPreDataItem()
            var
            begin
            end;

            trigger OnAfterGetRecord()
            var
            begin
            end;

            trigger OnPostDataItem()
            var
            begin
            end;
        }
        dataitem(Job; Job)
        {
            column(Job_No_; "No.")
            {
            }
            column(Job_Description; Description)
            {
            }
            column(Job_Description_2; "Description 2")
            {
            }
            dataitem(Job_BillTo; Integer)
            {
                DataItemTableView = sorting (Number);
                column(Job_BillToAddr; txtJobAddr)
                {
                }

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
                column(Job_DeliveryAddr; txtJobAddr)
                {
                }

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
                column(JobTask_No; "Job Task No.")
                {
                }
                column(JobTask_Description; Description)
                {
                }
                column(JobTask_Type; "Job Task Type")
                {

                }
                column(JobTask_StartDate; JobTask."Start Date")
                {

                }
                column(JobTask_EndDate; JobTask."End Date")
                {
                }

                trigger OnPreDataItem()
                var
                begin
                end;

                trigger OnAfterGetRecord()
                var
                begin
                end;

                trigger OnPostDataItem()
                var
                begin
                end;
            }

            trigger OnPreDataItem()
            var
            begin
            end;

            trigger OnAfterGetRecord()
            var
            begin
            end;

            trigger OnPostDataItem()
            var
            begin
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("No."; Job."No.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    Image = Document;
                    trigger OnAction()
                    var
                    begin
                        Message('');
                    end;
                }
            }
        }
    }

    trigger OnInitReport()
    var
    begin
    end;

    trigger OnPreReport()
    var
    begin
    end;

    trigger OnPostReport()
    var
    begin
    end;

    var
        textReportCaptionLbl: Label 'Arbejdsseddel';
        textReportPageCaptLbl: Label 'Page';
        arrJobDeliveryAddr: array[8] of Text;
        arrJobBillToAddr: array[8] of Text;
        txtJobAddr: Text;
}