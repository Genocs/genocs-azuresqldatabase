resource "azurerm_resource_group" "sql_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.sql_rg.name
  location                     = azurerm_resource_group.sql_rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password

  tags = var.tags
}

resource "azurerm_mssql_database" "sql_database" {
  name               = var.sql_database_name
  server_id          = azurerm_mssql_server.sql_server.id
  collation          = var.database_collation
  license_type       = "LicenseIncluded"
  sku_name           = var.database_sku
  zone_redundant     = false
  read_scale_out_enabled = false

  tags = var.tags
}

resource "azurerm_mssql_server_firewall_rule" "sql_firewall_rule" {
  name             = "AllowClientIP"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.client_ip_address
  end_ip_address   = var.client_ip_address
}

resource "azurerm_mssql_server_firewall_rule" "sql_firewall_rule_azure" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
