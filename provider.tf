provider "azurerm" {
  version = "=2.16.0"
  features {}
}

terraform {
  backend "azurerm" {
  }
}

data "azurerm_client_config" "current" {}
