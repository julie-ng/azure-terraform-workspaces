provider "azurerm" {
  version = "=2.16.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-workspaces-rg"
    storage_account_name = "tfworkspacestfstate"
    container_name       = "resourcegroups"
    key                  = "workspaces.tfstate"
  }
}

data "azurerm_client_config" "current" {}
