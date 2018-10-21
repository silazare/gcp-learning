# Main resources description
provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_firewall" "firewall_ssh" {
  name        = "default-allow-ssh"
  network     = "default"
  description = "Allow SSH from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Network name for rule apply
  network     = "default"
  description = "Allow Puma web service from anywhere"

  # Rules
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # IP addresses
  source_ranges = ["0.0.0.0/0"]

  # Rule should be applied for instances with tags
  target_tags = ["reddit-app"]
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }

  # Define boot disk
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  tags = ["reddit-app"]

  # Define network network_interface
  network_interface {
    # Network to which interface will be attached
    network = "default"

    # Use ephemeral IP for access from Internet
    # It is used implicit dependency VM of app_ip address
    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  # Define provisioners connection config
  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}
