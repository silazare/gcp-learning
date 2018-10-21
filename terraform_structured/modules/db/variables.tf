variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable machine_type {
  description = "Instance type"
  default     = "g1-small"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db"
}
