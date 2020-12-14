module "aks_cluster" {
      source = "../module"
      aks_cluster_name = "aks-b59"
      aks_cluster_version = "1.19.3"
      aks_agent_version = "1.19.3"
      location = "centralus"
      resource_group_name = "b59"
      aks_admin_group = "aks-b59-administrators"
      hide_ip_addresses = [
        "22.22.22.22/32"
      ]
      aks_user_nodepool_node_size = "Standard_D2_v2"
      aks_user_nodepool_node_os_disk_gb = 100
      aks_user_nodepool_node_max_count = 2
}

output "kube_config" {
    value = module.aks_cluster.kube_config
}

output "api_server" {
    value = module.aks_cluster.api_server
}