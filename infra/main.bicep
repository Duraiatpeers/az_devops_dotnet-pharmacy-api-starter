param environmentName string
param location string = resourceGroup().location

resource appPlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'asp-pharmacyapi-${environmentName}'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource webApp 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-pharmacyapi-${environmentName}'
  location: location
  properties: {
    serverFarmId: appPlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
    }
  }
}