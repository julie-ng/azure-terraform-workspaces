# Workspace Module
# ----------------

# RESOURCE GROUP

resource "azurerm_resource_group" "workspace_rg" {
  name     = "${local.name}-rg"
  location = var.location
}

# TF STATE BACKEND - STORAGE ACCOUNT

resource "azurerm_storage_account" "tfstate" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.workspace_rg.name
  location                 = azurerm_resource_group.workspace_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Todo: create container

# SERVICE_PRINCIPAL

resource "azuread_application" "arm_client" {
  name = "${local.name}-sp"

  depends_on = [
    azurerm_resource_group.workspace_rg
  ]
}

resource "random_password" "arm_secret" {
  length           = 36
  special          = true
  min_numeric      = 5
  min_special      = 3
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
