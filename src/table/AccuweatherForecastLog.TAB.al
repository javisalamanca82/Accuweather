table 50002 "Accuweather Forecast Log"
{
    Caption = 'Accuweather Forecast Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(3; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code" where("Country/Region Code" = field("Country/Region Code"));
        }
        field(4; "Minimum Temperature"; Decimal)
        {
            Caption = 'Minimum Temperature';
        }
        field(5; "Maximum Temperature"; Decimal)
        {
            Caption = 'Maximum Temperature';
        }
        field(6; "Forecast Date"; Date)
        {
            Caption = 'Forecast Date';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
