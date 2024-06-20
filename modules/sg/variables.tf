variable "name" {
  description = "Name of the network security group"
}

variable "location" {
  description = "Location of the resource"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "allowed_ports" {
  description = "List of ports to allow traffic for"
  type        = list(object({
    name  = string
    ports = list(number)
  }))
}
