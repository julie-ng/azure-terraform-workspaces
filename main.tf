# Root Module

# Something like create workspace for

# - "my-demo-fruit"
# - "somethingelse"


module "workspace_demo" {
  source = "./modules/workspace"

  workspace_name = "jngtftest"
}

# todo - put all of this into an oject, instead of individual properties
output "workspace_suffix" {
	value = module.workspace_demo.workspace_suffix
}

output "workspace_rg" {
	value = module.workspace_demo.workspace_resource_group_name
}

output "workspace_storage_account_name" {
	value = module.workspace_demo.workspace_tf_state_storage_account
}

output "workspace_sp_app_id" {
	value = module.workspace_demo.sp_app_id
}

output "workspace_sp_object_id" {
	value = module.workspace_demo.object_id
}

output "workspace_sp_client_secret" {
	value = module.workspace_demo.sp_client_secret
}

output "workspace_role_assignment_id" {
	value = module.workspace_demo.sp_role_assignment_id
}