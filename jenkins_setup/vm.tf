
resource "azurerm_linux_virtual_machine" "vm" {
  admin_username      = "aujung"
  location            = azurerm_resource_group.rg.location
  name                = "vm-terraform-jenkins"
  network_interface_ids = [azurerm_network_interface.nic.id]
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_DS1_v2"

  admin_ssh_key {
    public_key = file("~/.ssh/id_rsa.pub")
    username   = "aujung"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}