targetScope='subscription'

param resourceGroupName string = 'rg-pgs-poc'
param resourceGroupLocation string = 'westus'
param serverName string = 'postgres-fs-poc'
@secure()
param administratorLoginPassword string

resource default 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
  tags: {
    tagName1: 'Poc'
  }
}

module postgresqlFlexibleServer 'modules/postgresql-flexible-server.bicep' = {
  name: serverName
  scope: default
  params: {
    location: resourceGroupLocation
    administratorLoginPassword: administratorLoginPassword
  }
}
