
variable "virtual_network_name" {
    description = "The name of the virtual network."
    type        = string
}

variable "subnet_name" {
    description = "The name of the subnet."
    type        = string
}

variable "public_ip_name" {
    description = "The name of the public IP."
    type        = string
}

variable "network_interface_name" {
    description = "The name of the network interface."
    type        = string
}

variable "location" {
    description = "The location/region of the virtual network."
    type        = string
    default     = "East US"
}

variable "resource_group_name" {
    description = "The name of the resource group."
    type        = string
}