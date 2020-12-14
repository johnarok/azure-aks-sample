resource "azurerm_container_registry" "acr" {
  count = var.registry_enabled ? 1 : 0

  name                     = replace(var.aks_cluster_name, "/-/", "")
  resource_group_name      = azurerm_resource_group.primary.name
  location                 = azurerm_resource_group.primary.location
  sku                      = "Premium"
  admin_enabled            = false
  georeplication_locations = ["East US", "West Europe"]
}


