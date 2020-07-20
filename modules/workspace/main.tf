# Workspace Module
# ----------------

# RESOURCE GROUP

resource "azurerm_resource_group" "workspace_rg" {
  name     = "${var.workspace_name}-rg"
  location = var.location
}


# TF STATE BACKEND - STORAGE ACCOUNT

resource "azurerm_storage_account" "tfstate" {
	# replace("1 + 2 + 3", "non-alphanumberic", "")
  name                     = "${var.workspace_name}tfstate"
  resource_group_name      = azurerm_resource_group.workspace_rg.name
  location                 = azurerm_resource_group.workspace_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Todo: create container

# SERVICE_PRINCIPAL

resource "azuread_application" "arm_client" {
  name = "${var.workspace_name}-${random_string.workspace_suffix.result}-sp"

	depends_on = [
    azurerm_resource_group.workspace_rg
  ]
}

resource "random_password" "arm_secret" {
  length           = 36
  special          = true
  min_special      = 4
  override_special = "-_%@?"
}

resource "azuread_application_password" "arm_client_secret" {
  application_object_id = azuread_application.arm_client.object_id
  value                 = random_password.arm_secret.result
  end_date_relative     = "8760h" # 1 year
}

resource "azuread_service_principal" "arm_sp" {
  application_id = azuread_application.arm_client.application_id
}

# RBAC - scope service principal to resource group

resource "azurerm_role_assignment" "arm_sp" {
  scope                = azurerm_resource_group.workspace_rg.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.arm_sp.id
}
