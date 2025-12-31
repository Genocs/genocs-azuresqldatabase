# Genocs - Azure SQL Database Demo project

This repository contains a demo project for deploying an Azure SQL Database using Infrastructure as Code (IaC) principles. The project showcases how to set up and configure an Azure SQL Database instance using Terraform.

## Prerequisites
To deploy the resources in this project, you will need the following prerequisites:
- An active Azure subscription. If you don't have one, you can create a free account at [Azure Free Account](https://azure.microsoft.com/free/).
- Install the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).
- Create a Service Principal for Terraform to use with the following command:

```bash
az ad sp create-for-rbac --name "GitHubActions" --role contributor --scopes /subscriptions/<your_subscription_id>/resourceGroups/<your_resource_group_name>
```

>
> Replace `<your_subscription_id>` and `<your_resource_group_name>` with your actual subscription ID and resource group name.
> - Note down the `appId`, `password`, `tenant`, and `subscriptionId` from the output of the above command. These will be used for authentication in Terraform.
- Configure your GitHub repository secrets with the following keys:
  - `AZURE_CLIENT_ID` - The `appId` from the Service Principal.
  - `AZURE_CLIENT_SECRET` - The `password` from the Service Principal.
  - `AZURE_TENANT_ID` - The `tenant` from the Service Principal.
  - `AZURE_SUBSCRIPTION_ID` - Your Azure subscription ID.