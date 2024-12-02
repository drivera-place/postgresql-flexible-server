variable "name_prefix" {
  default = "tmp"
}

variable "resource_group_location" {
  default = "westus"
}

variable "resource_group_name" {
  default = "rg"
}

variable "address_space" {
  default = "10.0.0.0/16"
  type    = string
}
