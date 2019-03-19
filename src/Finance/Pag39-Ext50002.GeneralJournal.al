pageextension 50002 "TTTHGS GeneralJournal" extends "General Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("TTTHGS DueDate"; "Due Date")
            {
                ApplicationArea = All;
            }
        }
    }
}