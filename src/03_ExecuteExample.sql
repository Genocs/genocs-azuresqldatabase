-- Example usage of the stored procedure

-- Declare variable to capture output message
DECLARE @Message NVARCHAR(MAX);

-- Execute the stored procedure with parameters
EXEC dbo.sp_GetWeatherFromAPI
    @Latitude = 48.8566,
    @Longitude = 2.3522,
    @APIKey = '<your_actual_api_key>',  -- Replace with your actual API key
    @ResponseMessage = @Message OUTPUT;

-- Display the response message
SELECT @Message AS [Response Message];

-- Query the stored weather data
SELECT
    WeatherID,
    City,
    Country,
    Temperature,
    FeelsLike,
    Humidity,
    WindSpeed,
    WeatherCondition,
    WeatherDescription,
    RecordedAt
FROM dbo.OpenWeatherMap
ORDER BY RecordedAt DESC;
