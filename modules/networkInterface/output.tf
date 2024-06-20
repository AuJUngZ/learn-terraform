
output "network_interface_id" {
  description = "The ID of the created network interface"
  value       = azurerm_network_interface.nic.id
}

output "public_ip_address" {
  description = "The public IP address of the VM"
  value       = azurerm_public_ip.ip.ip_address
}
