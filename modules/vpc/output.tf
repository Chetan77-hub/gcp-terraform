output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "public_subnet" {
  value = google_compute_subnetwork.public.name
}

output "private_vm_subnet" {
  value = google_compute_subnetwork.private_vm.name
}

output "private_db_subnet" {
  value = google_compute_subnetwork.private_db.name
}

output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}