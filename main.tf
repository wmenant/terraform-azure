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
