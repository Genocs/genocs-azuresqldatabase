DECLARE @response NVARCHAR(MAX);
DECLARE @apiKey NVARCHAR(256);
DECLARE @url NVARCHAR(MAX);

-- TODO: Retrieve the API key from a secure location (for example, a configuration table or parameter)
-- Example (uncomment and adapt to your environment):
-- SELECT @apiKey = [Value]
-- FROM dbo.Configuration
-- WHERE [Key] = 'OpenWeatherMapApiKey';

SET @url = 'https://api.openweathermap.org/data/2.5/weather?lat=31&lon=28&appid=' + @apiKey;

EXEC sp_invoke_external_rest_endpoint 
    @method = 'GET',
    @url = @url,
    @response = @response OUTPUT;

/**
    * 
    {
        "coord": {
            "lon": 28,
            "lat": 31
        },
        "weather": [
            {
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01d"
            }
        ],
        "base": "stations",
        "main": {
            "temp": 290.84,
            "feels_like": 289.53,
            "temp_min": 290.84,
            "temp_max": 290.84,
            "pressure": 1013,
            "humidity": 33,
            "sea_level": 1013,
            "grnd_level": 1005
        },
        "visibility": 10000,
        "wind": {
            "speed": 8.58,
            "deg": 253,
            "gust": 10.78
        },
        "clouds": {
            "all": 0
        },
        "dt": 1767176595,
        "sys": {
            "country": "EG",
            "sunrise": 1767157551,
            "sunset": 1767194148
        },
INSERT INTO dbo.OpenWeatherMap (City, Temperature, WeatherCondition, RecordedAt)
        "id": 352733,
        "name": "Marsá Maţrūḩ",
        "cod": 200
    }
    * 
    */




INSERT INTO OpenWeatherMap (City, Temperature, Condition, Timestamp)
SELECT 
    JSON_VALUE(@response, '$.name'),
    JSON_VALUE(@response, '$.main.temp'),
    JSON_VALUE(@response, '$.weather[0].description'),
    GETDATE();