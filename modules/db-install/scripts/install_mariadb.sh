#!/bin/bash

# Variables
WEB_SERVER_IP="10.0.1.4"
DB_NAME="example_db"
username="adminbruker" #Change to a same username as in the terraform.tfvars file
password="Passord12" #Change to a same password as in the terraform.tfvars file

# Update package lists
sudo apt-get update

# Install dependencies
sudo apt-get install -y libmpfr6

# Download packages from the web server
wget -r -l1 -nd -np -A ".deb" http://${WEB_SERVER_IP}:8000/
sudo dpkg -i *.deb || sudo apt-get install -f -y

# Install downloaded packages
sudo dpkg -i *.deb || sudo apt-get install -f -y

# Start and enable MariaDB
sudo systemctl enable mariadb
sudo systemctl start mariadb

sudo sed -i "s/^bind-address\s*=.*$/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb

# Secure installation
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '';"
sudo mysql -e "CREATE USER '${username}'@'10.0.1.4' IDENTIFIED BY '${password}';"
sudo mysql -e "CREATE USER '${username}'@'localhost' IDENTIFIED BY '${password}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${username}'@'10.0.1.4' IDENTIFIED BY '${password}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${username}'@'localhost' IDENTIFIED BY '${password}';"
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Create database and table
sudo mysql -e "CREATE DATABASE ${DB_NAME};"
sudo mysql -e "USE ${DB_NAME}; CREATE TABLE employees (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), position VARCHAR(100), salary DECIMAL(10,2));"

# Insert sample data
sudo mysql -e "USE ${DB_NAME}; INSERT INTO employees (name, position, salary) VALUES ('Bergljot', 'Engineer', 75000), ('Sondre', 'Manager', 85000), ('Elias', 'Director', 95000);"