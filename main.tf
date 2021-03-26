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

resource "azurerm_storage_share" "config" {
  name                 = "valhiemconfig"
  storage_account_name = azurerm_storage_account.state_storage.name
  quota                = 50
}

resource "azurerm_container_group" "valhiem" {
  name                = "valheim"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "public"
  dns_name_label      = "az-valheim"
  os_type             = "Linux"

  container {
    name   = "valheim-server"
    image  = "lloesche/valheim-server"
    cpu    = "4"
    memory = "8"

    ports {
          port     = 2456
          protocol = "UDP"
      }
      
    ports {
          port     = 2457
          protocol = "UDP"
      }

    environment_variables = {
       SERVER_NAME = "azure-valhiem"
       WORLD_NAME = "azure-valheim-test"
       SERVER_PUBLIC = "false"
       SERVER_PASS = var.valheim_password
    }

    volume {
      name       = "config"
      mount_path = "/config"
      read_only  = false
      share_name = azurerm_storage_share.config.name

      storage_account_name = azurerm_storage_account.state_storage.name
      storage_account_key  = azurerm_storage_account.state_storage.primary_access_key
    }
  }
}
