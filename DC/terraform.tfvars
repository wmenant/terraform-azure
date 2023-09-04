# Authentication #
azure_tenant_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azure_subscription_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azure_client_id       = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
azure_client_secret   = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Common Variables #
location = "francecentral"
resource_group_name = "InfraAzRG"

# Network #
infra-vnet-cidr           = "10.10.0.0/16"
infra-vm-subnet-cidr      = "10.10.1.0/24"

# VM Settings
vm_name       					= "SRV2K22"
vm_private_ip_address 			= "10.10.1.11"
vm_public_ip_address_name 		= "SRV2K22_Public_IP"
vm_size       					= "Standard_B4ms"

admin_username	= "localadminuser"
admin_password 	= "Pa$$w0rd123"

# Active Directory #
ad_domain_name                      = "micronotix.fr"
ad_domain_netbios_name              = "micronotix"
ad_safe_mode_administrator_password = "Pa$$w0rd123"

