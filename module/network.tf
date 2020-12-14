resource "azurerm_virtual_network" "cluster" {
  name                = "aks-vnet"
  location            = azurerm_resource_group.primary.location
  resource_group_name = azurerm_resource_group.primary.name
  address_space       = ["${var.cidr}/16"]
}

resource "azurerm_subnet" "cluster" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.primary.name
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.cluster.name
  service_endpoints    = var.service_endpoints

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "aci" {
  name                 = "aci-subnet"
  virtual_network_name = azurerm_virtual_network.cluster.name
  resource_group_name  = azurerm_resource_group.primary.name
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "aciDelegation"
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
