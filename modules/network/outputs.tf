output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web_subnet.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db_subnet.id
}
output "web_nsg_id" {
  value = azurerm_network_security_group.web_nsg.id
}