resource "random_pet" "name_prefix" {
  prefix = var.name_prefix
  length = 1
}

resource "random_password" "pass" {
  length = 20
}

# create the resource group
module "resource_group" {
  source      = "../modules/resource_group"
  location    = var.location
  name_prefix = var.name_prefix
}

# create virtual network
module "vpc" {
  source                  = "../modules/virtual_private_cloud"
  address_space           = "10.0.0.0/16"
  name_prefix             = var.name_prefix
  resource_group_location = var.location
  resource_group_name     = module.resource_group.name
  depends_on              = [module.resource_group]
}

# create a security group
module "security_group" {
  source              = "../modules/network_security_group"
  name_prefix         = var.name_prefix
  location            = var.location
  resource_group_name = module.resource_group.name
  security_rule_name  = "TCPInbound"
  depends_on          = [module.resource_group]
}

# create a subnet
module "subnet" {
  source               = "../modules/subnet"
  address_prefixes     = "10.0.2.0/24"
  name_prefix          = var.name_prefix
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.vpc.virtual_network_name
  depends_on           = [module.vpc]
}

# associate subnet and nsg
module "subnet_nsg_association" {
  source                    = "../modules/subnet_nsg_association"
  network_security_group_id = module.security_group.id
  subnet_id                 = module.subnet.id
  depends_on = [
    module.subnet,
    module.security_group
  ]
}

# create a dns
module "private_dns_zone" {
  source              = "../modules/private_dns_zone"
  name_prefix         = var.name_prefix
  resource_group_name = module.resource_group.name
  depends_on          = [module.subnet_nsg_association]
}

module "virtual_network_link" {
  source                = "../modules/virtual_network_link"
  name_prefix           = var.name_prefix
  resource_group_name   = module.resource_group.name
  virtual_network_id    = module.vpc.virtual_network_id
  private_dns_zone_name = module.private_dns_zone.private_dns_zone_name
}

# create the postgresql flexible server
module "postgresql_flexible_server" {
  source                        = "../modules/postgresql_flexible_server"
  resource_group_name           = module.resource_group.name
  location                      = module.resource_group.location
  name_prefix                   = var.name_prefix
  administrator_password        = random_password.pass.result
  public_network_access_enabled = var.public_network_access_enabled
  depends_on = [
    module.resource_group,
    random_password.pass,
    module.virtual_network_link
  ]
}

# create the database
module "database" {
  source      = "../modules/database"
  name_prefix = var.name_prefix
  server_id   = module.postgresql_flexible_server.server_id
  depends_on  = [module.postgresql_flexible_server]
}

# Add firewall rule
module "firewall-rule" {
  source           = "../modules/firewall_rule"
  server_id        = module.postgresql_flexible_server.server_id
  start_ip_address = var.start_ip_address
  end_ip_address   = var.end_ip_address
  depends_on       = [module.postgresql_flexible_server]
}
