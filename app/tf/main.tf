terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}
provider "azurerm" {
  features {}
}
data "azurerm_resource_group" "webapp" {
  name = "new-transformer-dev2-identity-app-rg"
  # location = "westus"
}
resource "azurerm_app_service_plan" "webapp" {
  name                = "new-transformer-dev2-identity-app-plan"
  location            = "westus"
  resource_group_name = data.azurerm_resource_group.webapp.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = "new-transformer-dev2-identity-app-server"
  location            = "westus"
  resource_group_name = data.azurerm_resource_group.webapp.name
  app_service_plan_id = azurerm_app_service_plan.webapp.id

  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = "foo",
    "WEBSITE_NODE_DEFAULT_VERSION" = "6.9.1"
  }
}
