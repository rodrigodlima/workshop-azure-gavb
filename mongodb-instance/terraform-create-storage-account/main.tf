provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.0.0"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "terraformstate"
  location = "Brazil South"
}

resource "azurerm_storage_account" "terraform" {
  name                     = "terraformstateiac"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "terraform-blob-storage" {
  name                  = "terraformstate"
  storage_account_name  = azurerm_storage_account.terraform.name
  container_access_type = "private"
}