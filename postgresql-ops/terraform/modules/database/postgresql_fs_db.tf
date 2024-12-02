resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = "${var.name_prefix}-db"
  server_id = var.server_id
  collation = "en_US.utf8"
  charset   = "UTF8"
}
