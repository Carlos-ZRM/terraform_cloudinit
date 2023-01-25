#  az account list
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  required_version = "~> 1.2"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "0f894518-5188-4dd1-9ecd-0e1c9b5f6fc2"
  tenant_id       = "cbcb2ff2-f24c-4e4c-be46-435b2fd3ea7a"
}
