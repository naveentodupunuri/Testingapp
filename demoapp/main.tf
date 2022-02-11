
#Terraform Provider configurations

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.91.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}