param locationWestUS string = 'West US'
param locationEastUS string = 'East US'
param resourceGroupName string
param sku string = 'S1'

var prefix = toLower(substring(uniqueString(resourceGroupName), 0, 6)) // Using a part of the resource group name as a unique string

resource appServicePlanWestUS 'Microsoft.Web/serverfarms@2018-11-01' = {
  name: '${prefix}-asp-westus'
  location: locationWestUS
  sku: {
    name: sku
  }
}

resource webAppWestUS 'Microsoft.Web/sites@2019-08-01' = {
  name: '${prefix}-webapp-westus'
  location: locationWestUS
  properties: {
    serverFarmId: appServicePlanWestUS.id
  }
  dependsOn: [
    appServicePlanWestUS
  ]
}

resource appServicePlanEastUS 'Microsoft.Web/serverfarms@2018-11-01' = {
  name: '${prefix}-asp-eastus'
  location: locationEastUS
  sku: {
    name: sku
  }
}

resource webAppEastUS 'Microsoft.Web/sites@2019-08-01' = {
  name: '${prefix}-webapp-eastus'
  location: locationEastUS
  properties: {
    serverFarmId: appServicePlanEastUS.id
  }
  dependsOn: [
    appServicePlanEastUS
  ]
}
