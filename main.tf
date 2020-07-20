# Root Module

# Something like create workspace for

# - "my-demo-fruit"
# - "somethingelse"


module "workspace_demo" {
  source = "./modules/workspace"

  workspace_name = "jngtftest"
}

output "workspace" {
	value = {
		workspace 				= module.workspace_demo.workspace
		service_principal = module.workspace_demo.service_principal
		rbac							= module.workspace_demo.service_principal_role
	}
}
