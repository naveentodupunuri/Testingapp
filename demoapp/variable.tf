variable "subscription_id" {}

variable "rgname" {
  type = string
}

variable "location" {
  type = string
}



variable "tags" {
  description = "A mapping of tags which should be assigned to the Resource Group."
  type        = map(string)
  default     = {}
}

#storage details
variable "storageAcctName" {
  type=string
}

variable "storage_accounttype" {
  type=string
}

variable "storage_account_replication_type" {
  type=string
}


#VNet details

variable "vnet_name" {
  type = string
}

variable "kv_role_name" {
  type = string
}

variable "stg_role_name" {
  type = string
}

variable "appser_role_name" {
  type = string
}
