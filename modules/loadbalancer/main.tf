resource "azurerm_lb" "main" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontendConfig"
    subnet_id            = var.subnet_id
  }
}

resource "azurerm_lb_backend_address_pool" "backend" {
  loadbalancer_id     = azurerm_lb.main.id
  name                = "backend-pool"
}

resource "azurerm_lb_probe" "http" {
  loadbalancer_id     = azurerm_lb.main.id
  name                = "http-probe"
  protocol            = "Tcp"
  port                = 3306
}

resource "azurerm_lb_rule" "http" {

  loadbalancer_id                = azurerm_lb.main.id
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 3306
  backend_port                   = 3306
  frontend_ip_configuration_name = "frontendConfig"
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.backend.id]
  probe_id                       = azurerm_lb_probe.http.id
}
