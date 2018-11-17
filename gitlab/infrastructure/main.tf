# Main resources description
provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

module "gitlab" {
  source          = "../modules/gitlab"
  zone            = "${var.zone}"
  public_key_path = "${var.public_key_path}"
  base_disk_image = "${var.base_disk_image}"
  machine_type    = "${var.machine_type}"
}
