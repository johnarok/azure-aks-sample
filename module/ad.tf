data "azuread_group" "aks_administrators" {
  name        = var.aks_admin_group
}