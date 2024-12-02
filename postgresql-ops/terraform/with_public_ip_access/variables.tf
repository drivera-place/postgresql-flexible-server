variable "name_prefix" {
  default     = "postgresqlfs"
  description = "Prefix of the resource name."
}

variable "location" {
  default     = "westus"
  description = "Location of the resource."
}

variable "start_ip_address" {
}

variable "end_ip_address" {
}

variable "public_network_access_enabled" {
  default = true
}
