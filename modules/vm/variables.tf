
variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created."
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be created."
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "admin_username" {
  description = "The username of the administrator of the virtual machine."
  type        = string
}

variable "admin_ssh_key" {
  description = "The public key of the administrator of the virtual machine."
  type        = string
}

variable "network_interface_name" {
  description = "The name of the network interface."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "public_ip_name" {
  description = "The name of the public IP."
  type        = string
}

variable "sg-name" {
  description = "The name of the network security group."
  type        = string
}