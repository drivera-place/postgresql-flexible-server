output "resource_group_name" {
  value = module.resource_group.name
}

output "resource_group_location" {
  value = module.resource_group.location
}

output "postgresql_server_name" {
  value = module.postgresql_flexible_server.server_name
}

output "database_name" {
  value = module.database.name
}

output "postgresql_server_admin_password" {
  sensitive = true
  value     = module.postgresql_flexible_server.administrator_password
}