
provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
  location = "East Asia"
  name     = "aujung-terraform-module-rg"
}

module "create_VM" {
  source                 = "../modules/vm"
  location               = "East US"
  resource_group_name    = azurerm_resource_group.rg.name
  vm_name                = "vm-module"
  vm_size                = "Standard_B2s"
  admin_username         = "aujung"
  admin_ssh_key = file("~/.ssh/id_rsa.pub")
  virtual_network_name   = "vnet-module"
  subnet_name            = "subnet-module"
  public_ip_name         = "publicip-module"
  network_interface_name = "nic-module"
  sg-name = "sg-module"
}