output "vm_id" {
  value = azurerm_linux_virtual_machine.main.id
}

output "public_ip_address" {
  value = length(azurerm_public_ip.main) > 0 ? azurerm_public_ip.main[0].ip_address : null
}