page 50001 "Accuweather Forecast Log"
{
    ApplicationArea = All;
    Caption = 'Accuweather Forecast Log';
    PageType = List;
    SourceTable = "Accuweather Forecast Log";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field("Forecast Date"; Rec."Forecast Date")
                {
                    ToolTip = 'Specifies the value of the Forecast Date field.';
                }
                field("Minimum Temperature"; Rec."Minimum Temperature")
                {
                    ToolTip = 'Specifies the value of the Minimum Temperature field.';
                }
                field("Maximum Temperature"; Rec."maximum Temperature")
                {
                    ToolTip = 'Specifies the value of the Maximum Temperature field.';
                }
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

    actions
    {
        area(Processing)
        {
            action(GetForecast)
            {
                Caption = 'Get Forecast by Post Code';
                ToolTip = 'Get the forecast temperature per Post Code';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Calendar;

                trigger OnAction()
                var
                    AccuweatherGetForecast: Report "Accuweather Get Forecast";
                begin
                    AccuweatherGetForecast.RunModal();
                end;
            }
        }
    }
}
