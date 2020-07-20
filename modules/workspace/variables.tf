variable "name" {
  type				= string
  description = "Base name of your workspace that will be used in resource names. Please use lowercase with dashes"
}

variable "location" {
  type				= string
  description	= "Azure Region for resources. Defaults to Western Europe."
  default			= "westeurope"
}

locals {
  name								 = lower(var.name)
  storage_account_name = replace(local.name, "-", "")
}
