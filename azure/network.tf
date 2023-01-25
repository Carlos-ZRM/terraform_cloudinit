resource "azurerm_virtual_network" "main" {
  name                = "${var.project}-network"
  address_space       = var.azure_vn_cidr
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}


resource "azurerm_subnet" "internal" {
  count = length(var.azure_vn_subnet)
  name                 = "${var.project}-subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.azure_vn_subnet[count.index]
}

resource "azurerm_public_ip" "public_ip" {
  count = var.count_vm
  name                = "${var.project}-publicip-${count.index}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"

}


resource "azurerm_network_interface" "interface_0" {
  count = var.count_vm
  name                = "${var.project}-nic-${count.index}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "${var.project}-${count.index}-nic-config"
    subnet_id                     = azurerm_subnet.internal[0].id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_network_interface" "interface_1" {
  count = var.count_vm
  name                = "${var.project}-nic-${count.index}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "${var.project}-${count.index}-nic-config"
    subnet_id                     = azurerm_subnet.internal[0].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip[count.index].id
  }
}

resource "azurerm_network_security_group" "network_security_group" {
  name                = "${var.project}-network-security-group"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "ssh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
 security_rule {
    name                       = "cockpit"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9090"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface_security_group_association" "network_security_group_association" {
  count = var.count_vm
  network_interface_id      = azurerm_network_interface.interface_1[count.index].id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}