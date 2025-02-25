provider "azurerm" {
  features {}
  subscription_id = "dfaf27e3-3448-4dbd-a4a8-2016aed9f693" # Replace with your Azure subscription ID
}

# Resource Group
resource "azurerm_resource_group" "maveric" {
  name     = "maveric"
  location = "East US" # Choose a cost-friendly region
}

# Virtual Network
resource "azurerm_virtual_network" "maveric_vnet" {
  name                = "maveric-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name
}

# Subnet
resource "azurerm_subnet" "maveric_subnet" {
  name                 = "maveric-subnet"
  resource_group_name  = azurerm_resource_group.maveric.name
  virtual_network_name = azurerm_virtual_network.maveric_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Public IP (Standard SKU with Static Allocation)
resource "azurerm_public_ip" "maveric_public_ip" {
  name                = "maveric-public-ip"
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name
  allocation_method   = "Static" # Required for Standard SKU
  sku                 = "Standard" # Use Standard SKU
}

# Network Security Group (NSG) to allow SSH traffic
resource "azurerm_network_security_group" "maveric_nsg" {
  name                = "maveric-nsg"
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*" # Allow all IPs (or specify your IP)
    destination_address_prefix = "*"
  }
}

# Associate NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "maveric_nsg_assoc" {
  subnet_id                 = azurerm_subnet.maveric_subnet.id
  network_security_group_id = azurerm_network_security_group.maveric_nsg.id
}

# Network Interface
resource "azurerm_network_interface" "maveric_nic" {
  name                = "maveric-nic"
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.maveric_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.maveric_public_ip.id # Associate Public IP
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "maveric_vm" {
  name                = "maveric-vm"
  resource_group_name = azurerm_resource_group.maveric.name
  location            = azurerm_resource_group.maveric.location
  size                = "Standard_B1s" # Cost-friendly VM size
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.maveric_nic.id, # Use the correct NIC
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/week1-dev.pub") # Use the public key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS" # Cost-friendly storage
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS" # Free tier eligible
    version   = "latest"
  }
}

# Azure Container Registry (ACR)
resource "azurerm_container_registry" "maveric_acr" {
  name                = "mavericacr"
  resource_group_name = azurerm_resource_group.maveric.name
  location            = azurerm_resource_group.maveric.location
  sku                 = "Basic" # Cost-friendly ACR SKU
  admin_enabled       = true
}

