locals {
  location = var.location
  name     = var.name
  env      = var.env
  tags = {
    App         = local.name
    Environment = local.env
    ManagedBy   = "Terraform"
  }
  vm_size          = var.vm_size
  vm_os_publisher  = var.vm_os_publisher
  vm_os_offer      = var.vm_os_offer
  vm_os_sku        = var.vm_os_sku
  vm_os_version    = var.vm_os_version
  vm_ssh_pub_key   = var.vm_ssh_pub_key
  net_cidr         = var.net_cidr
  subnet_cidr      = var.subnet_cidr
  port             = var.port
  admin_username   = var.admin_username
  admin_password   = var.admin_password
  mysql_sku_name   = var.mysql_sku_name
  mysql_storage_gb = var.mysql_storage_gb
  mysql_version    = var.mysql_version
}

# Create a resource group
resource "azurerm_resource_group" "web-app" {
  name     = "${local.name}-rg"
  location = local.location

  tags = local.tags
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "web-app" {
  name                = "${local.name}-vnet"
  address_space       = [local.net_cidr]
  location            = azurerm_resource_group.web-app.location
  resource_group_name = azurerm_resource_group.web-app.name

  tags = local.tags
}

# Create subnet
resource "azurerm_subnet" "public" {
  name                 = "${local.name}-public-subnet"
  resource_group_name  = azurerm_resource_group.web-app.name
  virtual_network_name = azurerm_virtual_network.web-app.name
  address_prefixes     = [local.subnet_cidr]
}

# Create a public IP address
resource "azurerm_public_ip" "web-app" {
  name                = "${local.name}-public-ip"
  location            = azurerm_resource_group.web-app.location
  resource_group_name = azurerm_resource_group.web-app.name
  allocation_method   = "Static"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "web-app" {
  name                = "${local.name}-nsg"
  location            = azurerm_resource_group.web-app.location
  resource_group_name = azurerm_resource_group.web-app.name

  dynamic "security_rule" {
    for_each = local.port
    content {
      name                       = "Web-${security_rule.key}"
      priority                   = security_rule.key
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.key
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  tags = local.tags
}

# Create network interface
resource "azurerm_network_interface" "web-app" {
  name                = "${local.name}-nic"
  location            = azurerm_resource_group.web-app.location
  resource_group_name = azurerm_resource_group.web-app.name

  ip_configuration {
    name                          = "${local.name}-ip-config"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web-app.id
  }

  tags = local.tags
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "web-app" {
  network_interface_id      = azurerm_network_interface.web-app.id
  network_security_group_id = azurerm_network_security_group.web-app.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "web-app" {
  name                  = "${local.name}-vm"
  location              = azurerm_resource_group.web-app.location
  resource_group_name   = azurerm_resource_group.web-app.name
  network_interface_ids = [azurerm_network_interface.web-app.id]
  size                  = local.vm_size
  tags                  = local.tags
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = local.vm_os_publisher
    offer     = local.vm_os_offer
    sku       = local.vm_os_sku
    version   = local.vm_os_version
  }

  computer_name                   = "${local.name}-vm"
  admin_username                  = local.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = local.admin_username
    public_key = file(local.vm_ssh_pub_key)
  }

  boot_diagnostics {
    storage_account_uri = null
  }
}

# Create MySQL server
resource "azurerm_mysql_flexible_server" "web-app" {
  name                = "${local.name}-mysql"
  location            = azurerm_resource_group.web-app.location
  resource_group_name = azurerm_resource_group.web-app.name

  tags = local.tags

  administrator_login    = local.admin_username
  administrator_password = local.admin_password

  sku_name = local.mysql_sku_name
  version  = local.mysql_version
  storage {
    auto_grow_enabled = true
    size_gb           = local.mysql_storage_gb
  }

  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
}

# Create MySQL database
resource "azurerm_mysql_flexible_database" "web-app" {
  name                = "${local.name}-db"
  resource_group_name = azurerm_resource_group.web-app.name
  server_name         = azurerm_mysql_flexible_server.web-app.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Configure MySQL server firewall rule to allow access from the web application's virtual server
resource "azurerm_mysql_flexible_server_firewall_rule" "web-app" {
  name                = "${local.name}-firewall-rule"
  resource_group_name = azurerm_resource_group.web-app.name
  server_name         = azurerm_mysql_flexible_server.web-app.name
  start_ip_address    = azurerm_linux_virtual_machine.web-app.private_ip_address
  end_ip_address      = azurerm_linux_virtual_machine.web-app.private_ip_address
}
