# Variables for all project
variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
}

variable zone {
  description = "Zone"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable machine_type {
  description = "Instance type"
}

variable base_disk_image {
  description = "Disk image"
}

variable source_ranges {
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
}
