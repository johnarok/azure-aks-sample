### Sample AKS Module


### Parameters (In Progress)

| Title      | Default | Explanation   |
| :---        |    :----:   |          ---: |
| aks_cluster_name      | n/a       | ...   |
| aks_cluster_version   | n/a        | And more      |
| aks_agent_version   | n/a        | And more      |
| location   | n/a        | And more      |
| resource_group_name   | n/a        | And more      |
| aks_admin_group   | n/a        | And more      |
| hide_ip_addresses   | n/a        | Put your local Ip Address to connect   |
| aks_user_nodepool_node_size   | n/a        | And more      |
| aks_user_nodepool_node_os_disk_gb   | n/a        | And more      |
| aks_user_nodepool_node_max_count   | n/a        | And more      |


### Privileges

Need Access at the Subscription Level.

Set credentials for Azure RM in your environment

```
export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
export ARM_SUBSCRIPTION_ID=""
export ARM_TENANT_ID=""
```

### Usage

See test directory for a complete sample

### Dependencies

1. AD Group

```
resource "azuread_group" "aks_administrators" {
  name        = aks-b59-administrators"
  description = "Kubernetes administrators for the aks-b59 cluster."
}
```
