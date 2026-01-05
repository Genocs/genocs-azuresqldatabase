-- Enable external REST endpoint in SQL Server using sp_configure

-- First, enable the advanced options
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

-- Enable external rest endpoint
EXEC sp_configure 'external rest endpoint enabled', 1;
RECONFIGURE;

-- Verify the configuration
SELECT
    name,
    value,
    value_in_use
FROM sys.configurations
WHERE name IN ('show advanced options', 'external rest endpoint enabled')
ORDER BY name;
