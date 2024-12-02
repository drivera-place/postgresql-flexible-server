resource "random_pet" "name_prefix" {
  prefix = var.name_prefix
  length = 1
}

resource "random_password" "pass" {
  length = 20
}

# 1. create the resource group
module "resource_group" {
  source      = "../modules/resource_group"
  location    = var.location
  name_prefix = var.name_prefix
}

# 2. Create the flexible server
module "postgresql_flexible_server" {
  source                 = "../modules/postgresql_flexible_server"
  administrator_password = random_password.pass.result
  name_prefix            = var.name_prefix
  location               = module.resource_group.location
  resource_group_name    = module.resource_group.name
  depends_on = [
    module.resource_group,
    random_password.pass
  ]
}

# 4. Create the DB
module "database" {
  source      = "../modules/database"
  name_prefix = var.name_prefix
  server_id   = module.postgresql_flexible_server.server_id
  depends_on  = [module.postgresql_flexible_server]
}

# 5. Add firewall rule
module "firewall-rule" {
  source           = "../modules/firewall_rule"
  server_id        = module.postgresql_flexible_server.server_id
  start_ip_address = var.start_ip_address
  end_ip_address   = var.end_ip_address
  depends_on       = [module.postgresql_flexible_server]
}
