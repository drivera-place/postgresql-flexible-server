variable "name_prefix" {
  default = "tmp"
}

variable "virtual_network_name" {
}

variable "resource_group_name" {
}

variable "address_prefixes" {
  default = "10.0.2.0/24"
  type = string
}
