# Resource group name is output when execution plan is applied.
resource "azurerm_resource_group" "sh" {
  name     = var.rg_name
  location = var.resource_group_location
}

# Create AVD workspace
resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = var.workspace
  resource_group_name = azurerm_resource_group.sh.name
  location            = azurerm_resource_group.sh.location
  friendly_name       = "${var.prefix} Workspace"
  description         = "${var.prefix} Workspace"
}

# Create AVD host pool
resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  resource_group_name      = azurerm_resource_group.sh.name
  location                 = azurerm_resource_group.sh.location
  name                     = var.hostpool
  friendly_name            = var.hostpool
  validate_environment     = true
  custom_rdp_properties    = "drivestoredirect:s:;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:0;redirectprinters:i:0;devicestoredirect:s:;redirectcomports:i:0;redirectsmartcards:i:0;usbdevicestoredirect:s:;enablecredsspsupport:i:1;redirectwebauthn:i:0;use multimon:i:1;enablerdsaadauth:i:1;redirectlocation:i:0;"
  description              = "${var.prefix} Terraform HostPool"
  type                     = "Personal"
  load_balancer_type       = "Persistent"
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool.id
  expiration_date = var.rfc3339
}

# Create AVD DAG
resource "azurerm_virtual_desktop_application_group" "dag" {
  resource_group_name = azurerm_resource_group.sh.name
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool.id
  location            = azurerm_resource_group.sh.location
  type                = "Desktop"
  name                = "${var.prefix}-dag"
  friendly_name       = "Desktop AppGroup"
  description         = "AVD application group"
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool, azurerm_virtual_desktop_workspace.workspace]
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag" {
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}