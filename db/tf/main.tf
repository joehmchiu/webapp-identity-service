provider "azurerm" {
   features {}
}

data "azurerm_resource_group" "example" {
  name = "new-transformer-dev2-identity-app-rg"
}

data "azurerm_virtual_network" "example" {
  name                = "vnet-new-transformer-dev2-001"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_subnet" "example" {
  name                 = "subnet-db-001"
  resource_group_name  = data.azurerm_resource_group.example.name
  virtual_network_name = data.azurerm_virtual_network.example.name
  # enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_mssql_server" "example" {
  name                         = "new-transformer-dev2-db-server"
  resource_group_name          = data.azurerm_resource_group.example.name
  location                     = "West US"
  version                      = "12.0"
  administrator_login          = "new-transformer-sql-admin"
  administrator_login_password = "Passw0rd"
  public_network_access_enabled = false

  tags = {
    environment = "dev2"
  }
}

# need this database to save the users and predefined data
resource "azurerm_mssql_database" "example" {
  name           = "new-transformer-dev2-database"
  server_id      = azurerm_mssql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 250
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false

  tags = {
    foo = "bar"
  }
}

resource "azurerm_private_endpoint" "example" {
  name                = "${azurerm_mssql_server.example.name}-pe"
  location            = "West US"
  resource_group_name = data.azurerm_resource_group.example.name
  subnet_id           = data.azurerm_subnet.example.id

  private_service_connection {
    name                           = "${azurerm_mssql_server.example.name}-psc"
    private_connection_resource_id = azurerm_mssql_server.example.id
    subresource_names              = [ "sqlServer" ]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_zone" "example" {
  name                = "privatelink.database.windows.net"
  resource_group_name = data.azurerm_resource_group.example.name
}

data "azurerm_private_endpoint_connection" "example" {
  name                = azurerm_private_endpoint.example.name
  resource_group_name = data.azurerm_resource_group.example.name
}

resource "azurerm_private_dns_a_record" "example" {
  name                = azurerm_mssql_server.example.name
  zone_name           = azurerm_private_dns_zone.example.name
  resource_group_name = data.azurerm_resource_group.example.name
  ttl                 = 300
  records             = ["${data.azurerm_private_endpoint_connection.example.private_service_connection.0.private_ip_address}"]
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "new-transformer-vnet-link"
  resource_group_name   = data.azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = data.azurerm_virtual_network.example.id
}

output "private_link_endpoint_ip" {
  value = "${data.azurerm_private_endpoint_connection.example.private_service_connection.0.private_ip_address}"
}
