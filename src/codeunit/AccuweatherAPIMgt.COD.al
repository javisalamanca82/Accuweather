codeunit 50000 "Accuweather API Mgt."
{
    var
        RestAPIManagement: Codeunit "Rest API Management";
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        HttpMethod: Enum "REST API Method";

    procedure GetLocationUrl(PostCode: Record "Post Code"): Text
    var
        AccuweatherSetup: Record "Accuweather Setup";
        Url: Text;
        UrlMappingTxt: Label '%1/%2/v1/postalcodes/%3/search?apikey=%4&q=%5';
    begin
        AccuweatherSetup.Get();

        exit(StrSubstNo(UrlMappingTxt, AccuweatherSetup."Base Uri", AccuweatherSetup."Location Entity Name", PostCode."Country/Region Code", AccuweatherSetup."API Key", PostCode.Code));
    end;

    procedure GetDailyForecastUrl(APILocationKey: Text): Text
    var
        AccuweatherSetup: Record "Accuweather Setup";
        Url: Text;
        UrlMappingTxt: Label '%1/%2/v1/daily/15day/%3?apikey=%4&deatils=true&metric=true';
    begin
        AccuweatherSetup.Get();

        exit(StrSubstNo(UrlMappingTxt, AccuweatherSetup."Base Uri", AccuweatherSetup."Forecast Entity Name", APILocationKey, AccuweatherSetup."API Key"));
    end;

    procedure ProcessLocationAPICallWithHttpWebRequestMgt(PostCode: Record "Post Code")
    var
        Url: Text;
    //DecompressionMethod: DotNet DecompressionMethods;
    begin
        Url := GetLocationUrl(PostCode);

        HttpWebRequestMgt.Initialize(Url);
        HttpWebRequestMgt.SetContentType('application/json');
        HttpWebRequestMgt.SetReturnType('application/json');
        //HttpWebRequestMgt.SetDecompresionMethod();
    end;

    procedure ProcessLocationAPICall(PostCode: Record "Post Code")
    var
        APILocationKey: Text;
        HttpResponseAsText: Text;
        Url: Text;
    begin
        Url := GetLocationUrl(PostCode);
        RestAPIManagement.SendRequest(Url, HttpMethod::GET, '');
        HttpResponseAsText := RestAPIManagement.GetResponseAsText();
        APILocationKey := GetAPILocationKey(HttpResponseAsText);

        Url := GetDailyForecastUrl(APILocationKey);
        Clear(RestAPIManagement);
        RestAPIManagement.SendRequest(Url, HttpMethod::GET, '');
        HttpResponseAsText := RestAPIManagement.GetResponseAsText();
        ProcessAccuweatherForecast(HttpResponseAsText, PostCode);
    end;

    local procedure ProcessAccuweatherForecast(HttResponseAsText: Text; PostCode: Record "Post Code")
    var
        AccuweatherForecastLog: Record "Accuweather Forecast Log";
        JsonDailyForecasts: JsonArray;
        JsonObject: JsonObject;
        JsonForecast: JsonObject;
        JsonTemperature: JsonObject;
        JsonValue: JsonObject;
        JsonToken: JsonToken;
        ForecastDateTime: DateTime;
        ForecastDate: Date;
        MinTemperature: Decimal;
        MaxTemperature: Decimal;
    begin
        JsonObject.ReadFrom(HttResponseAsText);
        JsonObject.Get('DailyForecasts', JsonToken);

        JsonDailyForecasts := JsonToken.AsArray();
        foreach JsonToken in JsonDailyForecasts do begin
            JsonForecast := JsonToken.AsObject();

            JsonForecast.Get('Date', JsonToken);
            ForecastDateTime := JsonToken.AsValue().AsDateTime();
            ForecastDate := DT2Date(ForecastDateTime);

            JsonForecast.Get('Temperature', JsonToken);
            JsonTemperature := JsonToken.AsObject();

            JsonTemperature.Get('Minimum', JsonToken);
            JsonValue := JsonToken.AsObject();

            JsonValue.Get('Value', JsonToken);
            MinTemperature := JsonToken.AsValue().AsDecimal();

            JsonTemperature.Get('Maximum', JsonToken);
            JsonValue := JsonToken.AsObject();

            JsonValue.Get('Value', JsonToken);
            MaxTemperature := JsonToken.AsValue().AsDecimal();

            Clear(AccuweatherForecastLog);
            AccuweatherForecastLog.Init();
            AccuweatherForecastLog."Country/Region Code" := PostCode."Country/Region Code";
            AccuweatherForecastLog."Forecast Date" := ForecastDate;
            AccuweatherForecastLog."Maximum Temperature" := MaxTemperature;
            AccuweatherForecastLog."Minimum Temperature" := MinTemperature;
            AccuweatherForecastLog."Post Code" := PostCode.Code;
            AccuweatherForecastLog.Insert();
        end;
    end;

    local procedure GetAPILocationKey(HttpResponseAsText: Text): Text
    var
        JsonArray: JsonArray;
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        JsonToken2: JsonToken;
    begin
        JsonArray.ReadFrom(HttpResponseAsText);
        foreach JsonToken in JsonArray do begin
            JsonObject := JsonToken.AsObject();
            JsonObject.Get('Key', JsonToken2);
            exit(JsonToken2.AsValue().AsText());
        end;
    end;
}
