
provider "azurerm" {
  features {}
}


# Create a resource group
resource "azurerm_resource_group" "rg" {
  location = "East Asia"
  name     = "aujung-rg"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name = "aujung-vnet"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a subnet
resource "azurerm_subnet" "subnet" {
  name                 = "aujung-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]

}

# Create a public IP
resource "azurerm_public_ip" "ip" {
  location                = azurerm_resource_group.rg.location
  name                    = "aujung-ip"
  resource_group_name     = azurerm_resource_group.rg.name
  allocation_method       = "Dynamic"
}

# Create a network interface
resource "azurerm_network_interface" "nic" {
  location            = azurerm_resource_group.rg.location
  name                = "aujung-nic"
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "aujung-ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.ip.id
  }
}

# Setup inbound security rules
resource "azurerm_network_security_group" "nsg" {
  location            = azurerm_resource_group.rg.location
  name                = "aujung-nsg"
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Apply the network security group to vm's network interface
resource "azurerm_network_interface_security_group_association" "sg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create a vm
resource "azurerm_linux_virtual_machine" "vm" {
  admin_username      = "aujung"
  location            = azurerm_resource_group.rg.location
  name                = "aujung-vm"
  network_interface_ids = [azurerm_network_interface.nic.id]
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1ls"

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






