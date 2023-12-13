param locationWestUS string = 'West US'
param locationEastUS string = 'East US'
param resourceGroupName string
param sku string = 'F1'

var uniqueString = toLower(substring(uniqueString(resourceGroupName), 0, 6)) // Using a part of the resource group name as a unique string

resource appServicePlanWestUS 'Microsoft.Web/serverfarms@2018-11-01' = {
  name: '${uniqueString}-asp-westus'
  location: locationWestUS
  sku: {
    name: sku
  }
}

resource webAppWestUS 'Microsoft.Web/sites@2019-08-01' = {
  name: '${uniqueString}-webapp-westus'
  location: locationWestUS
  properties: {
    serverFarmId: appServicePlanWestUS.id
  }
  dependsOn: [
    appServicePlanWestUS
  ]
}

resource appServicePlanEastUS 'Microsoft.Web/serverfarms@2018-11-01' = {
  name: '${uniqueString}-asp-eastus'
  location: locationEastUS
  sku: {
    name: sku
  }
}

resource webAppEastUS 'Microsoft.Web/sites@2019-08-01' = {
  name: '${uniqueString}-webapp-eastus'
  location: locationEastUS
  properties: {
    serverFarmId: appServicePlanEastUS.id
  }
  dependsOn: [
    appServicePlanEastUS
  ]
}
