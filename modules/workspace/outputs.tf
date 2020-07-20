output "workspace" {
  value = {
    resource_group_name			 = azurerm_resource_group.workspace_rg.name
    tf_state_storage_account = azurerm_storage_account.tfstate.name
  }
}

# Credentials needed for DevOps

output "service_principal" {
  value = {
    display_name 	 = azuread_application.arm_client.name
    object_id 		 = azuread_application.arm_client.object_id
    application_id = azuread_application.arm_client.application_id
    client_secret  = random_password.arm_secret.result
  }
}

output "service_principal_role" {
  value = {
    name					= azurerm_role_assignment.arm_sp.role_definition_name
    scope					= azurerm_role_assignment.arm_sp.scope
    assignment_id = azurerm_role_assignment.arm_sp.id
  }
}
