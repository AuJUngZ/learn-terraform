module "networkInterface" {
  source = "../networkInterface"
  virtual_network_name = var.virtual_network_name
  subnet_name = var.subnet_name
  public_ip_name = var.public_ip_name
  network_interface_name = var.network_interface_name
  location = var.location
  resource_group_name = var.resource_group_name
}

module "sg" {
  source              = "../sg"
  name                = var.sg-name
  location            = var.location
  resource_group_name = var.resource_group_name
  allowed_ports = [
    { name = "HTTP", ports = [80] },
    { name = "HTTP", ports = [8080] },
    { name = "HTTPS", ports = [443] },
    { name = "SSH", ports = [22] }
  ]
}

resource "azurerm_network_interface_security_group_association" "sg_association" {
  network_interface_id      = module.networkInterface.network_interface_id
  network_security_group_id = module.sg.network_security_group_id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [module.networkInterface.network_interface_id]
  size                = var.vm_size
  admin_username      = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
