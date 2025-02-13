# Configure the Azure provider
provider "azurerm" {
  features {}
  subscription_id = "0cb69517-b7d3-4bde-a4b7-3905c5b3d55c" # Your Subscription ID
}

# Create a resource group
resource "azurerm_resource_group" "maveric" {
  name     = "Maveric"
  location = "East US"
}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "maveric-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name
}

# Create a Public Subnet
resource "azurerm_subnet" "public_subnet" {
  name                 = "public-subnet"
  resource_group_name  = azurerm_resource_group.maveric.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Public IP for the VM
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "vm-public-ip"
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name
  allocation_method   = "Static" # Required for Standard SKU
  sku                 = "Standard" # Set SKU to Standard
}

# Create a Network Interface for the VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "vm-nic"
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

# Create an Ubuntu VM
resource "azurerm_linux_virtual_machine" "ubuntu_vm" {
  name                = "ubuntu-vm"
  resource_group_name = azurerm_resource_group.maveric.name
  location            = azurerm_resource_group.maveric.location
  size                = "Standard_B1s" # VM size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub") # Path to your SSH public key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS" # Ubuntu version
    version   = "latest"
  }
}
