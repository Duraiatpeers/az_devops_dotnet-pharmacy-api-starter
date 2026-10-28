param environmentName string
param location string = resourceGroup().location

resource appPlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'asp-pharmacyapi-${environmentName}'
  location: location
  kind: 'linux'
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app-pharmacyapi-${environmentName}'
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appPlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
    }
  }
}