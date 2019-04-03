pageextension 50007 "TTTHGS JobCostFactbox" extends "Job Cost Factbox"
{
    layout
    {
        addbefore("Budget Cost")
        {
            group("TTTHGS BudgetContributionMarginGrp")
            {
                Caption = 'Contribution Margin';
                field("TTTHGS BudgetContributionMargin"; decBudgContrMarg)
                {
                    Caption = 'Budg. Contribution Margin';
                    ApplicationArea = All;
                }
                field("TTTHGS BudgetContributionMarginPct"; decBudgContrMargPct)
                {
                    Caption = 'Budg. Contribution Margin Pct.';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        loccuJobCalcStat: Codeunit "Job Calculate Statistics";
        locarrdecCL: array[16] of Decimal;
        locarrdecPL: array[16] of Decimal;
    begin
        CLEAR(loccuJobCalcStat);
        loccuJobCalcStat.JobCalculateCommonFilters(Rec);
        loccuJobCalcStat.CalculateAmounts();
        loccuJobCalcStat.GetLCYCostAmounts(locarrdecCL);
        loccuJobCalcStat.GetLCYPriceAmounts(locarrdecPL);
        decBudgContrMarg := locarrdecPL[12] - locarrdecCL[4];
        if locarrdecCL[4] <> 0 then
            decBudgContrMargPct := decBudgContrMarg * 100 / locarrdecCL[4];
    end;

    var
        decBudgContrMarg: Decimal;
        decBudgContrMargPct: Decimal;
}