resource "azurerm_kubernetes_cluster" "aks" {
  dns_prefix          = var.aks_cluster_name
  kubernetes_version  = var.aks_cluster_version
  location            = azurerm_resource_group.primary.location
  name                = var.aks_cluster_name
  node_resource_group = "${azurerm_resource_group.primary.name}-aks"
  resource_group_name = azurerm_resource_group.primary.name

  api_server_authorized_ip_ranges = var.hide_ip_addresses

  addon_profile {

    azure_policy { 
      enabled = true 
    }
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.insights.id
    }

    aci_connector_linux {
      enabled = true
      subnet_name = azurerm_subnet.aci.name
    }

    http_application_routing {
      enabled = false //TODO not supported from production deploy https://docs.microsoft.com/en-us/azure/aks/http-application-routing
    }

    kube_dashboard {
      enabled = false
    }

  }

  default_node_pool {
    availability_zones   = [1, 2, 3]
    enable_auto_scaling  = true
    max_count            = 3
    min_count            = 1
    name                 = "system"
    orchestrator_version = var.aks_agent_version
    os_disk_size_gb      = 30
    vm_size              = "Standard_D2_v2"

    vnet_subnet_id        = azurerm_subnet.cluster.id
    enable_node_public_ip = false
  }

  # service_principal {
  #   client_id     = var.client_id
  #   client_secret = var.client_secret
  # }

  network_profile {
    network_plugin = "azure" #or kubenet
    dns_service_ip     = "10.1.1.10"
    service_cidr       = "10.1.0.0/21"
    docker_bridge_cidr = "172.17.0.1/16"
    //pod_cidr = "172.40.0.0/16"
    //network_policy     = "calico"
    outbound_type     = "loadBalancer"
    load_balancer_sku = "Standard"

    # load_balancer_profile {
    #     managed_outbound_ip_count = []
    #     outbound_ip_address_ids   = []
    #     outbound_ip_prefix_ids    = [""]

    # }
  }

  identity { type = "SystemAssigned" }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed                = true
      admin_group_object_ids = [data.azuread_group.aks_administrators.object_id]
    }
  }
}

data "azurerm_user_assigned_identity" "aks_aci_identity" {
  name = "aciconnectorlinux-${azurerm_kubernetes_cluster.aks.name}"
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group

  depends_on = [ azurerm_kubernetes_cluster.aks ]
}

resource "azurerm_role_assignment" "vnet_permissions_aci" {
  principal_id         = data.azurerm_user_assigned_identity.aks_aci_identity.principal_id
  scope                = azurerm_virtual_network.cluster.id
  role_definition_name = "Contributor"
}

/*
only dev play
data "azurerm_user_assigned_identity" "aks_httprouting_identity" {
  name = "httpapplicationrouting-${azurerm_kubernetes_cluster.aks.name}"
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group

  depends_on = [ azurerm_kubernetes_cluster.aks ]
}

data "azurerm_dns_zone" "aks_dns_zone" {
  
  name                = azurerm_kubernetes_cluster.aks.addon_profile.0.http_application_routing.0.http_application_routing_zone_name
  resource_group_name = azurerm_kubernetes_cluster.aks.node_resource_group
  
  depends_on = [ azurerm_kubernetes_cluster.aks ]
}

resource "azurerm_role_assignment" "aks_dns_permissions_httprouting" {
  principal_id         = data.azurerm_user_assigned_identity.aks_httprouting_identity.principal_id
  scope                = data.azurerm_dns_zone.aks_dns_zone.id
  role_definition_name = "Contributor"
}
*/
