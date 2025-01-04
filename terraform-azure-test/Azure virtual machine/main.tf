provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "job_risk_rg" {
  name     = "job-risk-resources"
  location = "Central US"
}

resource "azurerm_virtual_network" "job_risk_vnet" {
  name                = "job-risk-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.job_risk_rg.location
  resource_group_name = azurerm_resource_group.job_risk_rg.name
}

resource "azurerm_subnet" "job_risk_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.job_risk_rg.name
  virtual_network_name = azurerm_virtual_network.job_risk_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "job_risk_nic" {
  name                = "job-risk-nic"
  location            = azurerm_resource_group.job_risk_rg.location
  resource_group_name = azurerm_resource_group.job_risk_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.job_risk_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "job_risk_vm" {
  name                = "job-risk-machine"
  resource_group_name = azurerm_resource_group.job_risk_rg.name
  location            = azurerm_resource_group.job_risk_rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.job_risk_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
