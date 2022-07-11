variable "project" {
  description = "GCP project id"
  type = string
}

variable "vpc_name" {
  description = "VPC name"
  type = string
}

variable "subnet_name_gce" {
  description = "Subnet name GCE"
  type = map
}

variable "gce_instance" {
  description = "GCE"
  type = map(object(
  {
    instance_name = string
    instance_type = string
    zone = string
    boot_image = string
    metadata_startup_script = string
    subnet_key = string
  }))
}

variable "disk_name" {
  description = "Disk name"
  type = string
}

variable "disk_type" {
  description = "Disk type"
  type = string
}

variable "zone" {
  description = "GCP zone"
  type = string
}

variable "disk_size" {
  description = "Disk size"
  type = string
}