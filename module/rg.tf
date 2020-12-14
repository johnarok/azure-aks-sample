resource "azurerm_resource_group" "primary" {
  location = var.location
  name     = var.resource_group_name
}