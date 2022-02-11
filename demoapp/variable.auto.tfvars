

#Subscription Details
subscription_id = "b0d0f156-7f5a-402c-ab85-e9e4fd4bd2ab"

#Resource Group Details
rgname ="rg-sampleinfra-eastus-01"
location ="eastus"
tags = {
  "version"                   = "1.0"
  "created by"                = "Naveen"
  "Owner"                     = "Sample Infra"
  "Environment"               = "dev"
  "Deployment Method"         = "Terraform"
}

storageAcctName                  = "demostorage9999"
storage_accounttype              = "Standard"
storage_account_replication_type = "LRS"


vnet_name ="sampleinfra-network"

kv_role_name = "kvappusers-custom"
stg_role_name = "stgappusers-custom"
appser_role_name = "appserappusers-custom"