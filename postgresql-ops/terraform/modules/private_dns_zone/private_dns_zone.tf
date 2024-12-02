resource "azurerm_private_dns_zone" "this" {
  name                = "${var.name_prefix}-pdz.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}
