
output "vm_ip" {
    description = "The public IP address of the VM"
    value = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "vm_id" {
    description = "The ID of the VM"
    value = azurerm_linux_virtual_machine.vm.id
}

output "vm_admin_username" {
    description = "The admin username of the VM"
    value = azurerm_linux_virtual_machine.vm.admin_username
}