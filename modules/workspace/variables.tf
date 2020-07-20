variable "workspace_name" {
  type    = string
}

variable "location" {
  type    = string
	default = "westeurope"
}

# variable "suffix_length" {
#   type    = integer
# 	default = 6
# }


resource "random_string" "workspace_suffix" {
  length  = 6
  special = false
  upper   = false
}

# variable "workspace_suffix" {
# 	value = random_string.suffix.result
# }