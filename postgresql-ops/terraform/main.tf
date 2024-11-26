resource "random_pet" "name_prefix" {
  prefix = var.name_prefix
  length = 1
}

resource "azurerm_resource_group" "default" {
  name     = random_pet.name_prefix.id
  location = var.location
}

resource "random_password" "pass" {
  length = 20
}

# Flexible PostgreSQL
resource "azurerm_postgresql_flexible_server" "default" {
  name                = "${random_pet.name_prefix.id}-server"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  administrator_login = "adminTerraform"
  administrator_password = random_password.pass.result
  sku_name   = "GP_Standard_D2s_v3"
  version    = "13" # PostgreSQL Version
  storage_mb = 32768
  backup_retention_days = 7

  delegated_subnet_id = null 
  private_dns_zone_id = null

  lifecycle {
    ignore_changes = [administrator_password]
  }
}

# Firewall IP restriction.
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_local_pc" {
  name                = "allow-my-ip"
  server_id           = azurerm_postgresql_flexible_server.default.id
  start_ip_address    = "" # Use developer public IP
  end_ip_address      = "" # Use developer public IP
}
