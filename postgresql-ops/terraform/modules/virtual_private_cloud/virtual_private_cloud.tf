resource "azurerm_virtual_network" "this" {
  name                = "${var.name_prefix}-vnet"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["${var.address_space}"]
}
