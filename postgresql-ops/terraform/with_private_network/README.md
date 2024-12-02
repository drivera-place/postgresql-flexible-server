# Prerequisites

_If you don't have previous tools installed, read:_

[How to install Terraform](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli)

[How to install Azure CLI]([Prerequisites](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt#install-azure-cli))

Some Resource Providers you may need to enable first in your Azure Subscription:

- Microsoft.Network
- Microsoft.DBforPostgreSQL

[How to register resource provider](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-providers-and-types#register-resource-provider)

## Operations

Initialize Terraform

```bash
terraform init -upgrade
```

Create plan

```bash
terraform plan -out main.tfplan -var="start_ip_address=0.0.0.0" -var="end_ip_address=0.0.0.0"
```

Apply a Terraform execution plan

```bash
terraform apply main.tfplan
```

Verify the results

```bash
az postgres flexible-server db show --resource-group <resource_group_name> --server-name <server_name> --database-name <database_name>
```

Clean up resources

```bash
terraform plan -destroy -out main.destroy.tfplan
```

Applying destroy !Warning

```bash
terraform apply "main.destroy.tfplan"
```

## References

[Deploy a PostgreSQL Flexible Server Database using Terraform](https://learn.microsoft.com/en-us/azure/developer/terraform/deploy-postgresql-flexible-server-database?tabs=azure-cli)
[Manages a PostgreSQL Flexible Server.](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server)
[Manages a PostgreSQL Flexible Server Firewall Rule.](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule)
[Resolve errors for resource provider registration](https://learn.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-register-resource-provider?tabs=azure-portal)
