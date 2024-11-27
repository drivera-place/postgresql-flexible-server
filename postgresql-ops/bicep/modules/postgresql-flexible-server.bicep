@secure()
param administratorLoginPassword string
param location string = 'westus'
param serverName string = 'postgres-fs-poc'
param serverEdition string = 'GeneralPurpose'
param skuSizeGB int = 32
param dbInstanceType string = 'Standard_D2s_v3'
param haMode string = 'Disabled'
param version string = '13'
param virtualNetworkExternalId string = ''
param subnetName string = ''
param privateDnsZoneArmResourceId string = ''
param administratorLogin string = 'bicepAdmin'
param allowedIps array = ['0.0.0.0'] // Add Devs IPs

resource postgresqlFlexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2021-06-01' = {
  name: serverName
  location: location
  sku: {
    name: dbInstanceType
    tier: serverEdition
  }
  properties: {
    version: version
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    network: {
      delegatedSubnetResourceId: (empty(virtualNetworkExternalId) ? json('null') : json('\'${virtualNetworkExternalId}/subnets/${subnetName}\''))
      privateDnsZoneArmResourceId: (empty(virtualNetworkExternalId) ? json('null') : privateDnsZoneArmResourceId)
    }
    highAvailability: {
      mode: haMode
    }
    storage: {
      storageSizeGB: skuSizeGB
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
  }
  resource firewallSingle 'firewallRules' = [for ip in allowedIps: {
    name: 'allow-single-${replace(ip, '.', '')}'
    properties: {
        startIpAddress: ip
        endIpAddress: ip
    }
  }]
}
