# Configure the Azure provider
terraform {
  backend "azurerm" {
    resource_group_name = "adamlash-tfstate"
    storage_account_name = "adamlashtfstate"
    container_name = "state"
    key = "3-cicd.tfstate"
  } 
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "alashtfrg-cicd"
  location = "westus2"
}

resource "azurerm_storage_account" "storage" {
  name                     = "alashtfstoragecicd"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}