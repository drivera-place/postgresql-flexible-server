# Flexible PostgreSQL
resource "azurerm_postgresql_flexible_server" "this" {
  name                = "${var.name_prefix}-server"
  resource_group_name = var.resource_group_name
  location            = var.location
  administrator_login = "adminTerraform"
  administrator_password = var.administrator_password
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