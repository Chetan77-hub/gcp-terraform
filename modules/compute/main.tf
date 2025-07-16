resource "google_compute_instance" "jumpbox" {
  name         = "jumpbox"
  machine_type = "e2-medium"
  zone         = var.zone
  tags         = ["jump-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = var.public_subnet
    access_config {}
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install -yq openssh-server"
}

resource "google_compute_instance" "private_vm" {
  name         = "private-vm"
  machine_type = "e2-medium"
  zone         = var.zone
  tags         = ["private-vm"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = var.private_subnet
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install -yq openssh-server"
}

resource "google_compute_firewall" "allow_ssh_to_jumpbox" {
  name    = "allow-ssh-to-jumpbox"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["jump-server"]
}

resource "google_compute_firewall" "allow_ssh_from_jumpbox" {
  name    = "allow-ssh-from-jumpbox"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.0.1.0/24"]  # Jumpbox subnet
  target_tags   = ["private-vm"]
}
