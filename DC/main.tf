# Define Terraform provider
terraform {
  required_version = "~> 1.3"
}

# Configure the Azure provider
provider "azurerm" { 
  features {}  
  
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}

resource "azurerm_resource_group" "infra-rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create the network VNET
resource "azurerm_virtual_network" "infra-vnet" {
  name = "infra-vnet"
  address_space = [var.infra-vnet-cidr]
  resource_group_name = azurerm_resource_group.infra-rg.name
  location = azurerm_resource_group.infra-rg.location
}

# Create a subnet for VM
resource "azurerm_subnet" "infra-subnet" {
  name = "vm-subnet"
  address_prefixes = [var.infra-vm-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.infra-vnet.name
  resource_group_name  = azurerm_resource_group.infra-rg.name
}

# Create the VM Public IP Address
resource "azurerm_public_ip" "vm_public_ip" {
  name                    = var.vm_public_ip_address_name
  location                = azurerm_resource_group.infra-rg.location
  resource_group_name     = azurerm_resource_group.infra-rg.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}

# Create the VM Nework Interface
resource "azurerm_network_interface" "vm-nic" {
  name                    = "${var.vm_name}-nic"
  location                = azurerm_resource_group.infra-rg.location
  resource_group_name     = azurerm_resource_group.infra-rg.name
  internal_dns_name_label = var.vm_name

  # Add IP Configuration to the NIC
  ip_configuration {
    name                          = "${var.vm_name}-ip-config"
    subnet_id                     = azurerm_subnet.infra-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.vm_private_ip_address
	public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

# Virtual machine
resource "azurerm_windows_virtual_machine" "srv-vm" {
 
  name                = "${var.vm_name}-vm"
  computer_name       = "${var.vm_name}-vm"
  location            = azurerm_resource_group.infra-rg.location
  resource_group_name = azurerm_resource_group.infra-rg.name

  size           = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password
  license_type   = var.vm_license_type

  network_interface_ids = [azurerm_network_interface.vm-nic.id]

  os_disk {
    name                 = "${var.vm_name}-vm-os-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows_2022_sku
    version   = "latest"
  }

  enable_automatic_updates = true
  provision_vm_agent       = true
}


# Local variables for Domain Controller
locals {
  dc1_fqdn = "${var.vm_name}.${var.ad_domain_name}"
  
  dc1_prereq_ad_1 = "Import-Module ServerManager"
  dc1_prereq_ad_2 = "Install-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools"
  dc1_prereq_ad_3 = "Install-WindowsFeature DNS -IncludeAllSubFeature -IncludeManagementTools"
  dc1_prereq_ad_4 = "Import-Module ADDSDeployment"
  dc1_prereq_ad_5 = "Import-Module DnsServer"

  dc1_install_ad_1         = "Install-ADDSForest -DomainName ${var.ad_domain_name} -DomainNetbiosName ${var.ad_domain_netbios_name} -DomainMode ${var.ad_domain_mode} -ForestMode ${var.ad_domain_mode} "
  dc1_install_ad_2         = "-DatabasePath ${var.ad_database_path} -SysvolPath ${var.ad_sysvol_path} -LogPath ${var.ad_log_path} -NoRebootOnCompletion:$false -Force:$true "
  dc1_install_ad_3         = "-SafeModeAdministratorPassword (ConvertTo-SecureString ${var.ad_safe_mode_administrator_password} -AsPlainText -Force)"
  
  dc1_shutdown_command     = "shutdown -r -t 10"
  dc1_exit_code_hack       = "exit 0"
  dc1_powershell_command   = "${local.dc1_prereq_ad_1}; ${local.dc1_prereq_ad_2}; ${local.dc1_prereq_ad_3}; ${local.dc1_prereq_ad_4}; ${local.dc1_prereq_ad_5}; ${local.dc1_install_ad_1}${local.dc1_install_ad_2}${local.dc1_install_ad_3}; ${local.dc1_shutdown_command}; ${local.dc1_exit_code_hack}"
}

resource "azurerm_virtual_machine_extension" "srv-vm-extension" {
  depends_on=[azurerm_windows_virtual_machine.srv-vm]

  name                 = "${var.vm_name}-vm-active-directory"
  virtual_machine_id   = azurerm_windows_virtual_machine.srv-vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"  
  settings = <<SETTINGS
  {
    "commandToExecute": "powershell.exe -Command \"${local.dc1_powershell_command}\""
  }
  SETTINGS
}
