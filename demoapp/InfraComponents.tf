
# Resource Group Creation
module "SampleRsg" {
  source = "../Modules/ResourceGroup"
  resource_group_name = var.rgname
  location = var.location
  tags = var.tags
}

#Creation of storage account
# storage account creation- 1 SPA
resource "azurerm_storage_account" "storage" {
    depends_on = [
      module.SampleRsg
    ]
  name                      = var.storageAcctName
  resource_group_name       = var.rgname
  location                  = var.location
  account_tier              = var.storage_accounttype
  account_replication_type  = var.storage_account_replication_type
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  tags                      = var.tags
}

#Private End point creation
resource "azurerm_private_endpoint" "stg_PEndpoint" {
  depends_on = [
    azurerm_storage_account.storage, azurerm_virtual_network.network 
  ]
  name                = "pe-storage-dev-eastus-01"
  resource_group_name = var.rgname
  location            = var.location
  subnet_id           = data.azurerm_subnet.pe_snet.id
  private_service_connection {
    name                           = "storage-dev-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names              = ["configurationStores"]
  }
}


#Vnet creation
resource "azurerm_network_security_group" "nsg" {
  name                = "sampleinfra-nsg-group"
  location            = var.location
  resource_group_name = var.rgname
}

resource "azurerm_virtual_network" "network" {
    depends_on = [
     module.SampleRsg
  ]
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rgname
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "snet-vms"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "snet-genearal"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.nsg.id
  }
  
  subnet {
    name           = "snet-privsateendpoints"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.nsg.id
  }

}

#keyvault
resource "azurerm_key_vault" "keyvault" {
  depends_on = [ module.SampleRsg ]
  name                        = "sikeyvault"
  location                    = var.location
  resource_group_name         = var.rgname
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_private_endpoint" "keyvault_PEndpoint" {
  depends_on = [
    azurerm_key_vault.keyvault, azurerm_virtual_network.network
  ]
  name                = "pe-keyvault-dev-eastus-01"
  resource_group_name = var.rgname
  location            = var.location
  subnet_id           = data.azurerm_subnet.pe_snet.id
  private_service_connection {
    name                           = "keyvault-dev-privateserviceconnection"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["configurationStores"]
  }
}

#App Service plan
# Create the Linux App Service Plan
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "linuxwebapp-asp-demo"
  location            = var.location
  resource_group_name = var.rgname
  sku {
    tier = "Free"
    size = "F1"
  }
}
# Create the web app, pass in the App Service Plan ID, and deploy code from a public GitHub repo
resource "azurerm_app_service" "webapp" {
  name                = "lnxwebapp-demo999778"
  location            = var.location
  resource_group_name = var.rgname
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id
  source_control {
    repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
    branch             = "master"
    manual_integration = true
    use_mercurial      = false
  }
}


resource "azurerm_private_endpoint" "appservice_PEndpoint" {
  depends_on = [
     azurerm_app_service.webapp , azurerm_virtual_network.network
  ]
  name                = "pe-appser-dev-eastus-01"
  resource_group_name = var.rgname
  location            = var.location
  subnet_id           = data.azurerm_subnet.pe_snet.id
  private_service_connection {
    name                           = "appser-dev-privateserviceconnection"
    private_connection_resource_id = azurerm_app_service.webapp.id
    is_manual_connection           = false
    subresource_names              = ["configurationStores"]
  }
}
