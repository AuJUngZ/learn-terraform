provider "azurerm" {
  features {}
}

#create a resource group`
resource "azurerm_resource_group" "rg" {
  name     = "rg-learnTerraform"
  location = "East Asia"
}

#create a Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = "aujungterraformstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2" // StorageV2 is required for static website hosting

  static_website {
    index_document = "index.html"
  }
}

#add index.html file
resource "azurerm_storage_blob" "blob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type = "text/html"
  source_content = "<html><body><h1>Hello, Terraform! from AuJung</h1></body></html>"
}