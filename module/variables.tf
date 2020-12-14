variable "aks_cluster_name"  {
  default = "aks-dummy"
}

variable "location" {
  default = "centralus"
}

variable "resource_group_name" {
  default = "bdummy"
}

variable "hide_ip_addresses" {
  type = list
  default = [ "24.245.37.95/32"]
}

variable "aks_admin_group" {
  default = "bdummy-administrators"
}

variable "aks_user_nodepool_node_size" {
  default = "Standard_DS2_v2"
}

variable "aks_user_nodepool_node_os_disk_gb" {
  default = 100
}

variable "aks_user_nodepool_node_max_count" {
  default = 3
}

variable "aks_cluster_version" {
  default = "1.18.10"
}

variable "aks_agent_version" {
  default = "1.18.10"
}

variable "registry_enabled" {
  default = false
}

variable "usernodepool_enabled" {
  default = false
}

variable "cidr" {
  default = "10.0.0.0"
}

variable "service_endpoints" {
  type = list
  default = [
    "Microsoft.Sql", 
    "Microsoft.Storage", 
    "Microsoft.EventHub", 
    "Microsoft.KeyVault",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Web"]
}

/*
variable "fwprivate_ip" {
  description = "The IP address packets should be forwarded to when using the VirtualAppliance hop type."
}
*/