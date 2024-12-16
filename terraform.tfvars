location            = "Norway East"
resource_group_name = "ReseourceGroup"
admin_username      = "adminbruker" #make sure to change this in the install_mariadb.sh file and playbook.yml file to match if you change it
admin_password = "Passord12" #make sure to change this in the install_mariadb.sh file and playbook.yml file to match if you change it

# VM-sices
web_vm_size = "Standard_B1s"
db_vm_size  = "Standard_B1ms"
install_script_url = "dbinstall"

#Network
vnet_name = "vnet" 
address_space = ["10.0.0.0/16"] 
db_subnet_prefix = "10.0.0.0/24" 
web_subnet_prefix = "10.0.1.0/24" 

#VM
web_vm_name = "web-server"
web_script_url = "https://dbinstall.blob.core.windows.net/play/playbook.yml"
vm_count = 2
db_vm_name = "db-server"
db_script_url = "https://dbinstall.blob.core.windows.net/install/install_mariadb.sh"