variable "project" {
  description = "GCP project id"
  type        = string
  default     = "terraform-home-work"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-central2"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "europe-central2-a"
}

variable "key" {
  description = "JSON key to service account"
  type        = string
  default     = "terraform-home-work-81dcf2e3f7cb.json"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "vpc-hw3"
}

variable "disk_name" {
  description = "Disk name"
  type        = string
  default     = "gce-disk"
}

variable "disk_type" {
  description = "Disk type"
  type        = string
  default     = "pd-ssd"
}

variable "disk_size" {
  description = "Disk size"
  type        = string
  default     = "1"
}