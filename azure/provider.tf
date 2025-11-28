terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "0c793f29-ae42-4a52-9649-c0e61f28d1de"
  tenant_id       = "347d1228-8668-4cf4-bf10-bb7b3abf9ccc"
}

