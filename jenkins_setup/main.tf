
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  location = "East Asia"
  name     = "rg-terraform-jenkins"
}

