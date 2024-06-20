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