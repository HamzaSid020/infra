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

# Create a Bastion Subnet
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.maveric.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a Public IP for Bastion
resource "azurerm_public_ip" "bastion_ip" {
  name                = "bastion-public-ip"
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create a Public IP for VM
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "vm-public-ip"
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create Azure Bastion Host
resource "azurerm_bastion_host" "bastion" {
  name                = "maveric-bastion"
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}

# Create a Network Security Group
resource "azurerm_network_security_group" "vm_nsg" {
  name                = "vm-nsg"
  location            = azurerm_resource_group.maveric.location
  resource_group_name = azurerm_resource_group.maveric.name
}

# Allow SSH (Port 22) in NSG
resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "Allow-SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.maveric.name
  network_security_group_name = azurerm_network_security_group.vm_nsg.name
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