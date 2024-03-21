page 50000 "Accuweather Setup"
{
    ApplicationArea = All;
    Caption = 'Accuweather Setup';
    PageType = Card;
    SourceTable = "Accuweather Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Base Uri"; Rec."Base Uri")
                {
                    ToolTip = 'Specifies the value of the Base Uri field.';
                }
                field("API Key"; Rec."API Key")
                {
                    ToolTip = 'Specifies the value of the API Key field.';
                }
                field("Forecast Entity Name"; Rec."Forecast Entity Name")
                {
                    ToolTip = 'Specifies the value of the Forecast Entity Name field.';
                }
                field("Location Entity Name"; Rec."Location Entity Name")
                {
                    ToolTip = 'Specifies the value of the Location Entity Name field.';
                }
            }
            group(Audit)
            {
                Caption = 'Audit';
                Editable = false;

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert(true);
        end;
    end;
}
