resource "azurerm_network_security_group" "sg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name


  dynamic "security_rule" {
    for_each = var.allowed_ports
    content {
      name                       = "Allow-${security_rule.key}"
      priority                   = 100 + security_rule.key
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = join(",", security_rule.value.ports)
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
