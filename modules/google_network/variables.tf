variable "project" {
  description = "GCP project id"
  type = string
}

variable "region" {
  description = "GCP region"
  type  = string
}

variable "zone" {
  description = "GCP zone"
  type = string
}

variable "vpc_name" {
  description = "VPC name"
  type = string
}

variable "auto_mode" {
  description = "Auto Mode"
  type = bool
  default = false
}

variable "subnet_name" {
  description = "Subnet name"
  type = map(object(
  {
    name = string
    ip_cidr_range = string
    region = string
    network = string
    project = string
  }))
}

variable "firewall_rules" {
  description = "Firewall rules"
  type = list(object(
  {
    name = string
    protocol = string
    ports    = list(any)
    source_ranges = list(string)
  }))
}

variable "router_name" {
  description = "Router name"
  type = string
  default = "roter-hw3"
}

variable "router_nat_name" {
  description = "NAT name"
  type = string
  default = "nat-hw3"
}