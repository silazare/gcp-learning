resource "google_compute_address" "gitlab_ip" {
  name = "gitlab-ip"
}

resource "google_compute_firewall" "firewall_gitlab" {
  name    = "allow-gitlab-default"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gitlab"]
}


resource "google_compute_instance" "gitlab" {
  name         = "gitlab"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = ["gitlab"]

  boot_disk {
    initialize_params {
      image = "${var.base_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.gitlab_ip.address}"
    }
  }

  metadata {
    sshKeys = "ubuntu:${file(var.public_key_path)}"
  }
}
