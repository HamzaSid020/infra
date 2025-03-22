# Outputs
output "vm_public_ip" {
  value = azurerm_public_ip.maveric_public_ip.ip_address
}

output "acr_login_server" {
  value = azurerm_container_registry.maveric_acr.login_server
}