table 50000 "Accuweather Setup"
{
    Caption = 'Accuweather Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Base Uri"; Text[250])
        {
            Caption = 'Base Uri';
        }
        field(3; "Location Entity Name"; Text[50])
        {
            Caption = 'Location Entity Name';
        }
        field(4; "Forecast Entity Name"; Text[50])
        {
            Caption = 'Forecast Entity Name';
        }
        field(5; "API Key"; Text[250])
        {
            Caption = 'API Key';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
