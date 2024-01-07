terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">= 0.14"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.env}"
  location = "West Europe"
  tags = {
    environment = "${var.env}-uc"
  }
}


resource "azurerm_key_vault" "kv" {
  name                = "kv-uc-${var.env}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tenant_id           = var.tenant_id
  sku_name            = "standard"
  tags = {
    environment = "${var.env}-uc"
  }
}

resource "azurerm_storage_account" "stg" {
  name                     = "stgdbxuc${var.env}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "${var.env}-uc"
  }
}

resource "azurerm_databricks_workspace" "dbx" {
  name                = "dbx-${var.env}-workspace"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "premium"
  tags = {
    environment = "${var.env}-uc"
  }
}