-- Create table to store OpenWeather API responses
CREATE TABLE dbo.OpenWeatherMap
(
    WeatherID INT PRIMARY KEY IDENTITY(1,1),
    City NVARCHAR(100) NOT NULL,
    Country NVARCHAR(50),
    Latitude DECIMAL(10, 6),
    Longitude DECIMAL(10, 6),
    Temperature DECIMAL(5, 2),
    FeelsLike DECIMAL(5, 2),
    TempMin DECIMAL(5, 2),
    TempMax DECIMAL(5, 2),
    Pressure INT,
    Humidity INT,
    Visibility INT,
    CloudCoverage INT,
    WindSpeed DECIMAL(5, 2),
    WindDirection INT,
    WindGust DECIMAL(5, 2),
    WeatherCondition NVARCHAR(100),
    WeatherDescription NVARCHAR(255),
    WeatherIcon NVARCHAR(10),
    Sunrise BIGINT,
    Sunset BIGINT,
    Timezone INT,
    APIResponseCode INT,
    RecordedAt DATETIME2 DEFAULT GETDATE()
);
GO

-- Create index on City and RecordedAt for common queries
CREATE INDEX IDX_OpenWeatherMap_City_RecordedAt ON dbo.OpenWeatherMap(City, RecordedAt DESC);