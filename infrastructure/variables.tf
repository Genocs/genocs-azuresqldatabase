variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?$", var.sql_server_name))
    error_message = "SQL Server name must be lowercase, contain only alphanumeric characters and hyphens, and be between 1-63 characters."
  }
}

variable "sql_database_name" {
  description = "The name of the SQL Database"
  type        = string
}

variable "sql_admin_username" {
  description = "The administrator username for the SQL Server"
  type        = string
  sensitive   = true
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL Server"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.sql_admin_password) >= 8 && can(regex("[0-9]", var.sql_admin_password)) && can(regex("[A-Z]", var.sql_admin_password))
    error_message = "Password must be at least 8 characters, contain at least one number, and contain at least one uppercase letter."
  }
}

variable "database_collation" {
  description = "The collation for the database"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "database_edition" {
  description = "The edition of the database (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "database_sku" {
  description = "The SKU/performance level of the database"
  type        = string
  default     = "S0"
}

variable "client_ip_address" {
  description = "The client IP address to allow access to the SQL Server. Default '0.0.0.0' allows connections from any IP and is intended for development/testing only; override this value with a restricted IP or range for production."
  type        = string
  default     = "0.0.0.0"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default = {
    environment = "dev"
    project     = "genocs-sqldatabase"
  }
}
