provider "azurerm" {
	features {}
}


resource "azurerm_resource_group" "development" {
  name     = "development"
  location = "West Europe"
}

