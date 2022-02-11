data "azurerm_subscription" "primary" {
}
data "azurerm_client_config" "current" {}

data "azurerm_subnet" "pe_snet" {
 depends_on = [azurerm_virtual_network.network]
  name                 = "snet-privsateendpoints"
  resource_group_name  = var.rgname
  virtual_network_name =var.vnet_name
}

data "azurerm_role_definition" "kv_role" {
  depends_on = [azurerm_role_definition.kv_role]
  name  = var.kv_role_name
  scope = data.azurerm_subscription.primary.id
}


data "azurerm_role_definition" "stg_role" {
  depends_on = [azurerm_role_definition.storage_role]
  name  = var.stg_role_name
  scope = data.azurerm_subscription.primary.id
}

data "azurerm_role_definition" "appser_role" {
  depends_on = [azurerm_role_definition.appser_role]
  name  = var.appser_role_name
  scope = data.azurerm_subscription.primary.id
}