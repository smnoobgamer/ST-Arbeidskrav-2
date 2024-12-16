output "web_vm_public_ip" {
  value = module.web_vm.public_ip_address
  description = "Public IP"
}

output "db_vm_ids" {
  value = [for db in module.db_vm : db.vm_id]
  description = "Database ID"
}

output "loadbalancer_id" {
  value = module.loadbalancer.lb_id
  description = "Loadbalancer ID"
}