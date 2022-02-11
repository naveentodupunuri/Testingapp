variable "resource_group_name" {
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
