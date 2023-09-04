variable "azure_client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "azure_client_secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "azure_tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

variable "azure_subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name"
}

variable "location" {
  type        = string
  description = "Azure region for the resource group"
  default     = "north europe"
}

#########################
#     VM Variables      #
#########################

#VNet CIDR
variable "infra-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
}

#Subnet CIDR
variable "infra-vm-subnet-cidr" {
  type        = string
  description = "The CIDR for the VM network subnet"
}

#Virtual Machine name
variable "vm_name" {
  type        = string
  description = "This variable defines the name of Virtual Machine"
}

#Virtual Machine private IP address
variable "vm_private_ip_address" {
  type        = string
  description = "This variable defines the private IP address of Virtual Machine"
}

#Virtual Machine public IP address
variable "vm_public_ip_address_name" {
  type        = string
  description = "This variable defines the public IP address name of Virtual Machine"
}

# local administrator username
variable "admin_username" {
  type        = string
  description = "The username associated with the local administrator account on the virtual machine"
}

# local administrator password
variable "admin_password" {
  type        = string
  description = "The password associated with the local administrator account on the virtual machine"
}

# Windows Server 2022 SKU used to build VMs
variable "windows_2022_sku" {
  type        = string
  description = "Windows Server 2022 SKU used to build VMs"
  default     = "2022-Datacenter"
}

# Windows Server 2019 SKU used to build VMs
variable "windows_2019_sku" {
  type        = string
  description = "Windows Server 2019 SKU used to build VMs"
  default     = "2019-Datacenter"
}

# Virtual Machine Size
variable "vm_size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create"
  default     = "Standard_B4ms"
}

#Virtual Machine license Type
variable "vm_license_type" {
  type        = string
  description = "Specifies the BYOL type for the virtual machine. Possible values are 'Windows_Client' and 'Windows_Server' if set"
  default     = null
}

# active directory domain name
variable "ad_domain_name" {
  type        = string
  description = "This variable defines the name of Active Directory domain, for example micronotix.fr"
}

# active directory domain NetBIOS name
variable "ad_domain_netbios_name" {
  type        = string
  description = "This variable defines the NETBIOS name of Active Directory domain, for example micronotix"
}

# active directory domain mode
variable "ad_domain_mode" {
  type        = string
  description = "This variable defines the mode of Active Directory domain and forest functional level"
  default     = "WinThreshold" # Windows Server 2016
}

# active directory database path
variable "ad_database_path" {
  type        = string
  description = "The active directory database path"
  default     = "C:/Windows/NTDS"
}

# active directory sysvol path
variable "ad_sysvol_path" {
  type        = string
  description = "The active directory SYSVOL path"
  default     = "C:/Windows/SYSVOL"
}

# active directory log path
variable "ad_log_path" {
  type        = string
  description = "The active directory log path"
  default     = "C:/Windows/NTDS"
}

# active directory safe mode administrator password
variable "ad_safe_mode_administrator_password" {
  type        = string
  description = "The active directory safe mode administrator password"
}
