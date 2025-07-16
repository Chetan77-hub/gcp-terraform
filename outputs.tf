output "jumpbox_ip" {
  value = module.compute.jumpbox_ip
}

output "private_vm_ip" {
  value = module.compute.private_vm_ip
}

output "cloud_sql_connection" {
  value = module.sql.db_instance_connection_name
}
