output "lb_id" {
  value = azurerm_lb.main.id
}
output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.backend.id
}