CREATE TABLE WeatherData
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    City NVARCHAR(100),
    Temperature DECIMAL(5,2),
    Condition NVARCHAR(50),
    Timestamp DATETIME
);
