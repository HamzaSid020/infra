# Outputs
output "vm_public_ip" {
  value = azurerm_public_ip.maveric_public_ip.ip_address
}

