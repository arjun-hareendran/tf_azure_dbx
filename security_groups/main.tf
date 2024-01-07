terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
}


provider "azuread" {
  tenant_id = var.tenant_id
}


resource "azuread_group" "dbx-engineer" {
  display_name = "dbx-engineer"
  owners = [
    var.user_master_owner
  ]
  security_enabled = true
}

resource "azuread_group" "dbx-analyst" {
  display_name = "dbx-analyst"
  owners = [
    var.user_master_owner
  ]
  security_enabled = true
}

resource "azuread_group" "dbx-admin" {
  display_name = "dbx-admin"
  owners = [
    var.user_master_owner
  ]
  security_enabled = true
}
