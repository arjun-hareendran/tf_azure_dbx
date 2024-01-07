terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    databricks = {
      source = "databricks/databricks"
      version = ">= 0.14"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}


resource "azurerm_resource_group" "rg-dbx" {
  name     = "databricks-rg"
  location = var.region
}

resource "azurerm_databricks_workspace" "dbx-poc-1" {
  name                = "tf_dbx_workspace_1"
  resource_group_name = azurerm_resource_group.rg-dbx.name
  location            = azurerm_resource_group.rg-dbx.location

  sku                         = "premium"
  managed_resource_group_name = "databricks-rg"

  custom_parameters {
    machine_learning_workspace_id = ""
  }

  tags = {
    process = "unity catalog demo"

  }
}

output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.dbx-poc-1.workspace_url}/"
}


resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = "Shared Autoscaling"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 10
  autoscale {
    min_workers = 1
    max_workers = 2
  }

  depen
}
