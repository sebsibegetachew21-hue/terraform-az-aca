output "resource_group" {
  value       = azurerm_resource_group.rg.name
  description = "Resource group name"
}

output "container_app_name" {
  value       = azurerm_container_app.hello.name
  description = "Container App name"
}

# FQDN is available after creation; use it as the app URL (HTTPS)
output "container_app_url" {
  value       = "https://${azurerm_container_app.hello.ingress[0].fqdn}"
  description = "Public URL of the Container App"
}

output "acr_name" {
  value       = azurerm_container_registry.acr.name
  description = "Container Registry name"
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "Container Registry login server"
}
