output "resource_group_id" {
  description = "The ID of the created resource group"
  value       = azurerm_resource_group.sql_rg.id
}

output "resource_group_name" {
  description = "The name of the created resource group"
  value       = azurerm_resource_group.sql_rg.name
}

output "sql_server_id" {
  description = "The ID of the created SQL Server"
  value       = azurerm_mssql_server.sql_server.id
}

output "sql_server_name" {
  description = "The fully qualified name of the SQL Server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_database_id" {
  description = "The ID of the created SQL Database"
  value       = azurerm_mssql_database.sql_database.id
}

output "sql_database_name" {
  description = "The name of the created SQL Database"
  value       = azurerm_mssql_database.sql_database.name
}

output "sql_connection_string" {
  description = "Connection string for the SQL Database"
  value       = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_database.name};Persist Security Info=False;User ID=${var.sql_admin_username};Password=****;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sensitive   = true
}

output "sql_connection_string_no_password" {
  description = "Connection string for the SQL Database (without password - for reference)"
  value       = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_database.name};User ID=${var.sql_admin_username};Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}
