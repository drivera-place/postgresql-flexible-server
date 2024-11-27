# Use a Bicep file to create an Azure Database for PostgreSQL - Flexible Server instance

## Prerequisites

- Bicep CLI v0.31.92
- Azure CLI 2.67.0

Check your Bicep version:

```bash
az bicep version
```

If you don't have Bicep on Azure CLI, install it:

```bash
az bicep install
```

Deploy:

```bash
az deployment sub create --name deploy --location westus --template-file main.bicep --parameters main.parameters.json
```

Verify:

```bash
az resource list --resource-group rg-pgs-poc
```

Clean up resources:

```bash
az group delete --name rg-pgs-poc
```
