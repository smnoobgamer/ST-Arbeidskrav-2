resource "azurerm_public_ip" "main" {
  count               = var.assign_public_ip ? 1 : 0
  name                = "${var.vm_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.assign_public_ip ? azurerm_public_ip.main[0].id : null
  }
}
resource "azurerm_network_interface_security_group_association" "web_nsg" {
  count = can(regex(".*web.*", var.vm_name)) ? 1 : 0
  
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = var.nsg_id
}
resource "azurerm_network_interface_backend_address_pool_association" "db_pool" {
  count = can(regex(".*db.*", var.vm_name)) ? 1 : 0
  
  network_interface_id    = azurerm_network_interface.main.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = var.backend_pool_id
}

resource "azurerm_virtual_machine_extension" "mariadb_install" {
  count                = can(regex(".*db.*", var.vm_name)) ? 1 : 0
  name                 = "mariadb-install-${var.vm_name}"
  virtual_machine_id   = azurerm_linux_virtual_machine.main.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"
  auto_upgrade_minor_version = false

  settings = <<SETTINGS
    {
      "fileUris": ["https://dbinstall.blob.core.windows.net/install/install_mariadb.sh"],
      "commandToExecute": "bash install_mariadb.sh"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "storageAccountName": "${var.storage_account_name}",
      "storageAccountKey": "${var.storage_account_key}"
    }
  PROTECTED_SETTINGS
}
resource "azurerm_linux_virtual_machine" "main" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.main.id]
  disable_password_authentication = false
  custom_data = can(regex(".*web.*", var.vm_name)) ? base64encode(<<-SCRIPT
    #!/bin/bash
    # Create directory for MariaDB packages
    sudo mkdir -p /home/${var.admin_username}/mariadb_packages
    cd /home/${var.admin_username}/mariadb_packages

    # Update package lists
    sudo apt-get update

    # Download MariaDB packages without installing
    sudo apt-get install --download-only -y mariadb-server
    # Copy packages to prepared directory
    sudo cp /var/cache/apt/archives/*.deb /home/${var.admin_username}/mariadb_packages/

    # Set permissions
    sudo chown -R ${var.admin_username}:${var.admin_username} /home/${var.admin_username}/mariadb_packages

    # Install Python for simple HTTP server
    sudo apt-get install -y python3

    # Create systemd service for HTTP server
    sudo cat > /etc/systemd/system/packages-server.service <<EOF
    [Unit]
    Description=Package HTTP Server
    After=network.target

    [Service]
    Type=simple
    User=${var.admin_username}
    WorkingDirectory=/home/${var.admin_username}/mariadb_packages
    ExecStart=/usr/bin/python3 -m http.server 8000
    Restart=always

    [Install]
    WantedBy=multi-user.target
    EOF

    # Enable and start the service
    sudo systemctl enable packages-server
    sudo systemctl start packages-server
    sudo sudo apt-get install -y ansible
    STORAGE_ACCOUNT_NAME="${var.storage_account_name}"
    PLAYBOOK_URL="https://dbinstall.blob.core.windows.net/play/playbook.yml"
    PLAYBOOK_PATH="/home/${var.admin_username}/playbook.yml"

    # Download the Ansible playbook
    sudo curl -o /home/${var.admin_username}/playbook.yml https://dbinstall.blob.core.windows.net/play/playbook.yml

    # Run the playbook
    sudo ansible-playbook /home/${var.admin_username}/playbook.yml
    SCRIPT
  ) : null


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

 source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}
