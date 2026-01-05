-- Create stored procedure to call OpenWeather API and store response
CREATE OR ALTER PROCEDURE dbo.sp_GetWeatherFromAPI
    @Latitude DECIMAL(10, 6) = 31,
    @Longitude DECIMAL(10, 6) = 28,
    @APIKey NVARCHAR(255),
    -- You can use a lookup table to store API keys if needed    
    @ResponseMessage NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @response NVARCHAR(MAX);
    DECLARE @url NVARCHAR(MAX);
    DECLARE @ErrorMessage NVARCHAR(MAX);

    BEGIN TRY
        -- Construct the API URL
        SET @url = 'https://api.openweathermap.org/data/2.5/weather?lat=' 
                 + CAST(@Latitude AS NVARCHAR(10)) 
                 + '&lon=' + CAST(@Longitude AS NVARCHAR(10)) 
                 + '&appid=' + @APIKey;
        
        -- Call the external REST API
        EXEC sp_invoke_external_rest_endpoint 
            @method = 'GET',
            @url = @url,
            @response = @response OUTPUT;
        
        -- Debug: Check if response is empty
        IF @response IS NULL OR @response = ''
        BEGIN
            SET @ResponseMessage = 'Error: No response received from API. Check URL: ' + @url;
            RETURN;
        END;
        
        -- Debug: Log raw response (optional - comment out if not needed)
        PRINT 'Raw API Response: ' + @response;
        
        -- Check if the response contains a valid city name
        DECLARE @City NVARCHAR(100) = JSON_VALUE(@response, '$.result.name');
        DECLARE @ApiCode INT = TRY_CAST(JSON_VALUE(@response, '$.result.cod') AS INT);
        
        -- Check for API errors (cod is not 200)
        IF @ApiCode IS NOT NULL AND @ApiCode != 200
        BEGIN
            SET @ResponseMessage = 'Error: API returned code ' + CAST(@ApiCode AS NVARCHAR(10)) + '. Response: ' + @response;
            RETURN;
        END;
        
        IF @City IS NULL
        BEGIN
            SET @ResponseMessage = 'Error: City information not found in API response. Raw response: ' + @response;
            RETURN;
        END;
        
        -- Insert the parsed JSON response into the table
        INSERT INTO dbo.OpenWeatherMap
        (
        City,
        Country,
        Latitude,
        Longitude,
        Temperature,
        FeelsLike,
        TempMin,
        TempMax,
        Pressure,
        Humidity,
        Visibility,
        CloudCoverage,
        WindSpeed,
        WindDirection,
        WindGust,
        WeatherCondition,
        WeatherDescription,
        WeatherIcon,
        Sunrise,
        Sunset,
        Timezone,
        APIResponseCode,
        RecordedAt
        )
    SELECT
        @City AS City,
        JSON_VALUE(@response, '$.result.sys.country') AS Country,
        JSON_VALUE(@response, '$.result.coord.lat') AS Latitude,
        JSON_VALUE(@response, '$.result.coord.lon') AS Longitude,
        CAST(JSON_VALUE(@response, '$.result.main.temp') AS DECIMAL(5, 2)) AS Temperature,
        CAST(JSON_VALUE(@response, '$.result.main.feels_like') AS DECIMAL(5, 2)) AS FeelsLike,
        CAST(JSON_VALUE(@response, '$.result.main.temp_min') AS DECIMAL(5, 2)) AS TempMin,
        CAST(JSON_VALUE(@response, '$.result.main.temp_max') AS DECIMAL(5, 2)) AS TempMax,
        CAST(JSON_VALUE(@response, '$.result.main.pressure') AS INT) AS Pressure,
        CAST(JSON_VALUE(@response, '$.result.main.humidity') AS INT) AS Humidity,
        CAST(JSON_VALUE(@response, '$.result.visibility') AS INT) AS Visibility,
        CAST(JSON_VALUE(@response, '$.result.clouds.all') AS INT) AS CloudCoverage,
        CAST(JSON_VALUE(@response, '$.result.wind.speed') AS DECIMAL(5, 2)) AS WindSpeed,
        CAST(JSON_VALUE(@response, '$.result.wind.deg') AS INT) AS WindDirection,
        CAST(JSON_VALUE(@response, '$.result.wind.gust') AS DECIMAL(5, 2)) AS WindGust,
        JSON_VALUE(@response, '$.result.weather[0].main') AS WeatherCondition,
        JSON_VALUE(@response, '$.result.weather[0].description') AS WeatherDescription,
        JSON_VALUE(@response, '$.result.weather[0].icon') AS WeatherIcon,
        CAST(JSON_VALUE(@response, '$.result.sys.sunrise') AS BIGINT) AS Sunrise,
        CAST(JSON_VALUE(@response, '$.result.sys.sunset') AS BIGINT) AS Sunset,
        CAST(JSON_VALUE(@response, '$.result.timezone') AS INT) AS Timezone,
        CAST(JSON_VALUE(@response, '$.result.cod') AS INT) AS APIResponseCode,
        GETDATE() AS RecordedAt;
        
        SET @ResponseMessage = 'Weather data successfully retrieved and stored. API Response Code: ' 
                             + CAST(JSON_VALUE(@response, '$.result.cod') AS NVARCHAR(10));
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE();
        SET @ResponseMessage = 'Error occurred: ' + @ErrorMessage;
        
        THROW;
    END CATCH
END;
