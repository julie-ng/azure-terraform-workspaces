output "workspace_suffix" {
	value = random_string.workspace_suffix.result
}

output "workspace_resource_group_name" {
  value = azurerm_resource_group.workspace_rg.name
}

output "workspace_tf_state_storage_account" {
  value = azurerm_storage_account.tfstate.name
}

# Credentials needed for DevOps

output "sp_app_id" {
	value = azuread_application.arm_client.application_id
}

output "object_id" {
	value = azuread_application.arm_client.object_id
}

output "sp_client_secret" {
	value = random_password.arm_secret.result
}

output "sp_role_assignment_id" {
	value = azurerm_role_assignment.arm_sp.id
}
