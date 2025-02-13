# Resource Group Output
output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.maveric.name
}

# Virtual Network Output
output "virtual_network_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

# Public Subnet Output
output "public_subnet_name" {
  description = "Name of the public subnet"
  value       = azurerm_subnet.public_subnet.name
}

# Public IP Output
output "public_ip_address" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.vm_public_ip.ip_address
}

# Network Interface Output
output "network_interface_name" {
  description = "Name of the network interface"
  value       = azurerm_network_interface.vm_nic.name
}

# Virtual Machine Output
output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_linux_virtual_machine.ubuntu_vm.name
}

output "vm_admin_username" {
  description = "Admin username for the virtual machine"
  value       = azurerm_linux_virtual_machine.ubuntu_vm.admin_username
}