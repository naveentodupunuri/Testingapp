# terraform {
#   backend "azurerm" {
#     resource_group_name  = "vmgroup" 
#     storage_account_name = "blobdemo88"
#     container_name       = "tfbackup"
#     key                  = "sampleinfra.terraform.tfstate"
#   }
# }