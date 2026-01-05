-- Enable external REST endpoint in SQL Server using sp_configure
-- Note: These script statements should be run separately outside of the SSDT project
-- in SQL Server Management Studio or Azure Data Studio with appropriate permissions.

/*
-- First, enable the advanced options
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
GO

-- Enable external rest endpoint
EXEC sp_configure 'external rest endpoint enabled', 1;
RECONFIGURE;
GO

-- Verify the configuration
SELECT
    name,
    value,
    value_in_use
FROM sys.configurations
WHERE name IN ('show advanced options', 'external rest endpoint enabled')
ORDER BY name;
*/