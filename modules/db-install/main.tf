resource "azurerm_storage_account" "mariadb" {
  name                     = "dbinstall"
  resource_group_name      = var.resource_group_name
  location                = var.location
  account_tier            = "Standard"
  account_replication_type = "LRS"
  #allow_blob_public_access = true
/*  blob_properties {
    container_delete_retention_policy {
      days = 7
    }

    delete_retention_policy {
      days = 7
    }
      # Allow public access
  }*/
}

resource "azurerm_storage_container" "install" {
  name                  = "install"
  storage_account_name  = azurerm_storage_account.mariadb.name
  container_access_type = "private"
}
resource "azurerm_storage_container" "play" {
  name                  = "play"
  storage_account_name  = azurerm_storage_account.mariadb.name
  container_access_type = "blob"
}
resource "azurerm_storage_blob" "install_script" {
  name                   = "install_mariadb.sh"
  storage_account_name   = azurerm_storage_account.mariadb.name
  storage_container_name = azurerm_storage_container.install.name
  type                   = "Block"
  source                 = "${path.module}/scripts/install_mariadb.sh"
}

resource "azurerm_storage_blob" "ansible_playbook" {
  name                   = "playbook.yml"
  storage_account_name   = azurerm_storage_account.mariadb.name
  storage_container_name = azurerm_storage_container.play.name
  type                   = "Block"
  source                 = "${path.module}/scripts/playbook.yml"
}