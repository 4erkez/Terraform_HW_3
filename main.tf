//VPC
module "vpc" {
  source    = "./modules/google_network"
  project   = var.project
  region    = var.region
  zone      = var.zone
  vpc_name  = var.vpc_name
  auto_mode = false

//Subnet  
  subnet_name = {
    subnet1 = {
      name          = "subnet1-hw3"
      ip_cidr_range = "192.168.10.0/24"
      region        = "europe-central2"
      network       = "vpc-hw3"
      project       = "terraform-home-work"
    },
    subnet2 = {
      name          = "subnet2-hw3"
      ip_cidr_range = "192.168.20.0/24"
      region        = "europe-central2"
      network       = "vpc-hw3"
      project       = "terraform-home-work"
    },
    subnet3 = {
      name          = "subnet3-hw3"
      ip_cidr_range = "192.168.30.0/24"
      region        = "europe-central2"
      network       = "vpc-hw3"
      project       = "terraform-home-work"
    }
  }

//Firewall
  firewall_rules = [
    { protocol : "tcp",
      name : "firewall1-hw3",
      ports : [80, 443],
      source_ranges : ["0.0.0.0/0"]
    },
    { protocol : "tcp",
      name : "firewall2-hw3",
      ports : [3306],
      source_ranges : ["192.168.30.0/24"]
    },
    { protocol : "tcp",
      name : "firewall3-hw3",
      ports : [22],
      source_ranges : ["93.77.217.144/32"]
  }]
}

//Google Compute Engine
module "gce" {
  source          = "./modules/google_compute"
  project         = var.project
  zone            = var.zone
  vpc_name        = var.vpc_name
  subnet_name_gce = module.vpc.subnet
  disk_name       = var.disk_name
  disk_type       = var.disk_type
  disk_size       = var.disk_size
  gce_instance = {
    gce1 = {
      instance_name           = "gce1-hw3"
      instance_type           = "f1-micro"
      zone                    = "europe-central2-a"
      boot_image              = "debian-cloud/debian-9"
      metadata_startup_script = "sudo apt-get -y update; sudo apt-get -y install nginx; sudo service nginx start;"
      subnet_key              = "subnet1"
    },
    gce2 = {
      instance_name           = "gce2-hw3"
      instance_type           = "f1-micro"
      zone                    = "europe-central2-a"
      boot_image              = "debian-cloud/debian-9"
      metadata_startup_script = "sudo apt-get -y update; sudo apt-get -y install apache; sudo service apache2 start;"
      subnet_key              = "subnet2"
    },
    gce3 = {
      instance_name           = "gce3-hw3"
      instance_type           = "f1-micro"
      zone                    = "europe-central2-a"
      boot_image              = "debian-cloud/debian-9"
      metadata_startup_script = "sudo apt-get -y update; sudo apt-get -y install mysql; sudo service mysql start;"
      subnet_key              = "subnet3"
    }
  }
}

//Storage Bucket
resource "google_storage_bucket" "storage-buckets-hw3" {
  count                       = 3
  name                        = "storage-bucket-hw3-${count.index}"
  location                    = "EU"
  force_destroy               = true
  uniform_bucket_level_access = true
}

//Data Source
data "google_compute_network" "vpc-data" {
  name = "vpc-data"
}

resource "google_compute_subnetwork" "data-source-subnet" {
  name          = "vpc-data-subnet"
  ip_cidr_range = "10.2.0.0/16"
  region        = "europe-central2"
  network       = data.google_compute_network.vpc-data.id
}

resource "google_compute_firewall" "data-source-firewall" {
  name    = "data-source-firewall"
  network = data.google_compute_network.vpc-data.id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
}