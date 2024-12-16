output "storage_account_name" {
  value = azurerm_storage_account.mariadb.name
}

output "storage_account_key" {
  value     = azurerm_storage_account.mariadb.primary_access_key
  sensitive = true
}