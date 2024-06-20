
# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name = var.virtual_network_name
  address_space = ["10.0.0.0/16"]
  location = var.location
  resource_group_name = var.resource_group_name
}

# Create a subnet
resource "azurerm_subnet" "subnet" {
  name                 = "aujung-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]

}

# Create a public IP
resource "azurerm_public_ip" "ip" {
  location                = var.location
  name                    = "aujung-ip"
  resource_group_name     = var.resource_group_name
  allocation_method       = "Dynamic"
}

# Create a network interface
resource "azurerm_network_interface" "nic" {
  location            = var.location
  name                = "aujung-nic"
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "aujung-ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.ip.id
  }
}