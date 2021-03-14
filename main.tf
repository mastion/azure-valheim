provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

#
# Core management resources
#
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.region
}

# Holds Terraform shared state (already exists, created by bootstrap.sh)
resource "azurerm_storage_account" "state_storage" {
  name                     = var.state_storage
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  allow_blob_public_access = false
}
