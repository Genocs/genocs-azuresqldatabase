# Terraform Infrastructure for Genocs SQL Database

This directory contains Terraform configuration files for deploying an Azure SQL Database infrastructure.

## Files Overview

- **provider.tf** - Terraform provider configuration for Azure
- **variables.tf** - Variable definitions for the Terraform configuration
- **main.tf** - Main resource definitions (Resource Group, SQL Server, Database, Firewall Rules)
- **outputs.tf** - Output values for deployed resources
- **terraform.tfvars.example** - Example values file (rename to terraform.tfvars before use)

## Prerequisites

1. **Azure CLI** - Install from https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
2. **Terraform** - Install from https://www.terraform.io/downloads.html
3. **Azure Subscription** - An active Azure subscription with appropriate permissions

## Setup Instructions

### 1. Authenticate with Azure

```bash
az login
az account set --subscription "YOUR_SUBSCRIPTION_ID"
```

### 2. Create Variables File

Copy the example variables file and update it with your values:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your specific values:
- `resource_group_name` - Name of the Azure resource group
- `location` - Azure region (e.g., "East US", "West Europe")
- `sql_server_name` - Name of the SQL Server (must be globally unique)
- `sql_database_name` - Name of the database
- `sql_admin_username` - Admin username for SQL Server
- `sql_admin_password` - Admin password (must meet complexity requirements)
- `client_ip_address` - Your IP address for firewall access (or use "0.0.0.0" for testing)

### 3. Initialize Terraform

```bash
terraform init
```

This will download the required Azure provider and initialize the working directory.

### 4. Plan the Deployment

```bash
terraform plan -out=tfplan
```

Review the proposed changes. This command will show you all resources that will be created.

### 5. Apply the Configuration

```bash
terraform apply tfplan
```

Confirm the deployment when prompted.

## Useful Commands

### View Current State
```bash
terraform show
```

### View Outputs
```bash
terraform output
```

### Get Connection String
```bash
terraform output sql_connection_string
```

### Destroy Resources
```bash
terraform destroy
```

**Warning:** This will delete all resources managed by Terraform. Use with caution.

### Refresh State
```bash
terraform refresh
```

## Security Best Practices

1. **Do not commit `terraform.tfvars`** - This file may contain sensitive information (passwords)
2. **Use Azure Key Vault** - Store sensitive values in Key Vault and reference them in Terraform
3. **Use Managed Identity** - Consider using managed identities instead of storing credentials
4. **Restrict Firewall Rules** - Set `client_ip_address` to your specific IP instead of "0.0.0.0" in production
5. **Enable Encryption** - The configuration includes encryption for data in transit

## Resource Details

### Azure Resources Created

1. **Resource Group** - Container for all resources
2. **SQL Server** - Managed SQL Server instance (v12.0)
3. **SQL Database** - Database with configurable SKU
4. **Firewall Rules** - Two rules:
   - Allow specified client IP
   - Allow Azure services to access the database

### Outputs

The configuration provides several outputs:
- `resource_group_name` - Name of the resource group
- `sql_server_name` - FQDN of the SQL Server
- `sql_database_name` - Name of the database
- `sql_connection_string` - Connection string for the database (masked password)
- `sql_connection_string_no_password` - Connection string without password for reference

## Cost Optimization

The default configuration uses `Standard S0` SKU which is one of the lowest-cost options. To reduce costs further:
- Use `Basic` edition with `B` SKU for development environments
- Set `zone_redundant = false` (default)
- Set `read_scale_out_enabled = false` (default)

For production environments, consider upgrading to higher SKUs.

## Troubleshooting

### Terraform Plan Shows No Changes
```bash
terraform refresh
```

### Connection Issues
- Check firewall rules: `terraform output`
- Verify client IP address is correct
- Ensure SQL Server is fully deployed (may take a few minutes)

### Authentication Errors
```bash
az login
terraform init -upgrade
```

## Next Steps

After deploying the infrastructure:
1. Connect to the database using the connection string
2. Run SQL scripts to initialize the database schema
3. Configure continuous deployment pipelines
4. Set up monitoring and backups

## Additional Resources

- [Azure Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Best Practices](https://www.terraform.io/docs/language/index.html)
- [Azure SQL Database Documentation](https://docs.microsoft.com/en-us/azure/azure-sql/database/)
