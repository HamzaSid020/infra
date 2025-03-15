# main.tf

# Provider configuration
provider "azurerm" {
  features {}
  subscription_id = "0cb69517-b7d3-4bde-a4b7-3905c5b3d55c" # Your Azure subscription ID
}

# Variables for SSH key paths
variable "private_key_path" {
  description = "Path to the SSH private key"
  default     = "~/.ssh/terraform/terraform_key"  # Path from your earlier commands
}

variable "public_key_path" {
  description = "Path to the SSH public key"
  default     = "~/.ssh/terraform/terraform_key.pub"  # Path from your earlier commands
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

# Network Security Group (NSG) with additional ports
resource "azurerm_network_security_group" "maveric_nsg" {
  name                = "maveric-nsg"
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name

  # Rule for SSH (port 22)
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

  # Rule for port 3000 (Frontend)
  security_rule {
    name                       = "allow-port-3000"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Rule for port 4004 (Caretaker Service)
  security_rule {
    name                       = "allow-port-4004"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4004"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Rule for port 4005 (Reminder Service)
  security_rule {
    name                       = "allow-port-4005"
    priority                   = 125
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4005"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Rule for port 4006 (Scraper Service)
  security_rule {
    name                       = "allow-port-4006"
    priority                   = 126
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4006"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Rule for port 4000 (Auth Service)
  security_rule {
    name                       = "allow-port-4000"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "4000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

