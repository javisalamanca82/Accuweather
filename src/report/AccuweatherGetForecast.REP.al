report 50000 "Accuweather Get Forecast"
{
    Caption = 'Accuweather Get Forecast';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(PostCode; "Post Code")
        {
            trigger OnPreDataItem()
            begin
                InitProcessDt := CurrentDateTime();
                NoOfRecords := Count();
            end;

            trigger OnAfterGetRecord()
            var
                AccuweatherAPIMgt: Codeunit "Accuweather API Mgt.";
            begin
                AccuweatherAPIMgt.ProcessLocationAPICall(PostCode);
                Commit();
            end;

            trigger OnPostDataItem()
            begin
                Message(ProcessFinishedMsg, NoOfRecords, CurrentDateTime - InitProcessDt);
            end;
        }
    }

    var
        NoOfRecords: Integer;
        InitProcessDt: DateTime;
        ProcessFinishedMsg: Label '%1 records were processed in %2.';
}
