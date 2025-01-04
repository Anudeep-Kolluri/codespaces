provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform_rg" {
  name     = "terraform-rg"
  location = "Central US"
}

resource "azurerm_storage_account" "terraform_storage" {
  name                     = "anudeepterraformstorage"
  resource_group_name      = azurerm_resource_group.terraform_rg.name
  location                 = azurerm_resource_group.terraform_rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
}


resource "azurerm_storage_data_lake_gen2_filesystem" "terraform_data_lake" {
  name               = "terraform-data-lake"
  storage_account_id = azurerm_storage_account.terraform_storage.id
}



resource "azurerm_synapse_workspace" "terraform_synapse" {
  name                                 = "terraform-synapse-analytics"
  resource_group_name                  = azurerm_resource_group.terraform_rg.name
  location                             = azurerm_resource_group.terraform_rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.terraform_data_lake.id


  # github_repo {
  #   account_name    = "Anudeep-Kolluri"
  #   branch_name     = "main"
  #   repository_name = "ELT-BD-Agriculture-Synapse-Terraform"
  #   root_folder     = "/"
  # }

  identity {
    type = "SystemAssigned"
  }

}

resource "azurerm_synapse_firewall_rule" "allow_all_ips" {
  name                 = "allow-all-ips"
  synapse_workspace_id = azurerm_synapse_workspace.terraform_synapse.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "255.255.255.255"
}