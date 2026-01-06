# Genocs - Azure SQL Database Demo project

This repository contains a demo project for deploying an Azure SQL Database using Infrastructure as Code (IaC) principles. The project showcases how to set up a SQL project by using VS code, to deploy an Azure SQL Database instance using Terraform and to update the database schema using SQL migration scripts.

## Prerequisites
To deploy the resources in this project, you will need the following prerequisites:
- An active Azure subscription. If you don't have one, you can create a free account at [Azure Free Account](https://azure.microsoft.com/free/).
- Install the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
- Install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).
- Create a Service Principal for GitHub Actions

## Configure GitHub Actions

You can use GitHub Action to automate the deployment of the Azure SQL Database using SqlDatabase Project.

### 1. Create Azure Service Principal
To allow GitHub Actions to deploy resources to your Azure subscription, you need to create a Service Principal. You can do this using the Azure CLI with the following command:

```bash
# Create a Service Principal for GitHub Actions
az ad sp create-for-rbac --name "GitHubActions" --role contributor --scopes /subscriptions/<your_subscription_id>/resourceGroups/<your_resource_group_name>
```

Save the output of this command, as it contains the necessary credentials for GitHub Actions to authenticate with Azure.

Sample Output:
```JSON
{
  "appId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "displayName": "GitHubActions",
  "name": "http://GitHubActions",
  "password": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
 ```

### 2. Set up GitHub Secrets

Setup the following GitHub Secrets:
- `AZURE_SQL_CONNECTION_STRING` - The connection string for your Azure SQL Database.
- `AZURE_CREDENTIALS` - The JSON structure containing the Service Principal details.

In order to allow GitHub Actions to authenticate with Azure, you need to set up the necessary secrets in your GitHub repository. Follow these steps:

1. Navigate to your GitHub repository.
2. Go to `Settings` > `Secrets and variables` > `Actions`.
3. Click on `New repository secret`.
4. Setup the following JSON structure with the details from the Service Principal created above:

```JSON    
{
  "clientId": <your_service_principal_appId>,
  "clientSecret": <your_service_principal_password>,
  "tenantId": <your_service_principal_tenant>,
  "subscriptionId": <your_subscription_id>
}
```

This JSON structure will be used to set up the GitHub secret named `AZURE_CREDENTIALS`.

Do the same for the `AZURE_SQL_CONNECTION_STRING` secret by providing the connection string to your Azure SQL Database.

Below are commands to verify the creation of the Service Principal:
```bash
# Use this command to list all service principals
az ad sp list --display-name "GitHubActions"

# Use this command to get information about the service principal
az ad sp show --id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```


TO Be confirmed:
>
> Replace `<your_subscription_id>` and `<your_resource_group_name>` with your actual subscription ID and resource group name.
> - Note down the `appId`, `password`, `tenant`, and `subscriptionId` from the output of the above command. These will be used for authentication in Terraform.
- Configure your GitHub repository secrets with the following keys:
  - `AZURE_CLIENT_ID` - The `appId` from the Service Principal.
  - `AZURE_CLIENT_SECRET` - The `password` from the Service Principal.
  - `AZURE_TENANT_ID` - The `tenant` from the Service Principal.
  - `AZURE_SUBSCRIPTION_ID` - Your Azure subscription ID.