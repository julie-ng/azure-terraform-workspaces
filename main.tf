resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

module "workspace_demo" {
  source = "./modules/workspace"
  name   = "jng-${random_string.suffix.result}"
}

output "workspace" {
  value = {
    workspace         = module.workspace_demo.workspace
    service_principal = module.workspace_demo.service_principal
    rbac              = module.workspace_demo.service_principal_role
  }
}
