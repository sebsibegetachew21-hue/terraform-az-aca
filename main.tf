locals {
  # short random suffix to keep names globally unique
  suffix = random_id.suffix.hex
  rg_name = "${var.name_prefix}-rg-${local.suffix}"
}

resource "random_id" "suffix" {
  byte_length = 2
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.name_prefix}-law-${local.suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Container Apps Environment (the shared "network + runtime" boundary for your apps)
resource "azurerm_container_app_environment" "env" {
  name                = "${var.name_prefix}-env-${local.suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Recommended so you can see logs/metrics in Azure
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
}

# A single public Container App ("hello") with ingress enabled
resource "azurerm_container_app" "hello" {
  name                         = "${var.name_prefix}-hello-${local.suffix}"
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.env.id

  revision_mode = "Single"

  ingress {
    external_enabled = true
    target_port      = var.target_port

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  template {
    container {
      name   = "hello"
      image  = var.container_image

      # Small + cheap starter sizing (Consumption)
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}
