provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform_rg" {
  name     = "terraform-rg"
  location = "Central India"
}


resource "azurerm_mssql_server" "terraform_server" {
  name                         = "terraform-sql-server-anudeep"
  resource_group_name          = azurerm_resource_group.terraform_rg.name
  location                     = azurerm_resource_group.terraform_rg.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11"
  minimum_tls_version          = "1.2"
}



resource "azurerm_mssql_database" "terraform_db" {
  name         = "terraform-db"
  server_id    = azurerm_mssql_server.terraform_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
}