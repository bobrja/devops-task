terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("~/.ssh/gcp-terraform-softserve-a4b27cbd0f8e.json")

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
    name = var.subnet_name
    ip_cidr_range = var.subnet_cidr
    network = google_compute_network.vpc_network.name
}

data "google_compute_image" "image" {
  family  = var.image_family
  project = var.image_project
}

resource "google_compute_instance" "vm_instance" {
  name = "${var.instance_name}-${var.environment}"
  machine_type = var.instance_type
  tags = var.network_tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.image.self_link
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.network-with-private-secondary-ip-ranges.id
    
    access_config {
    }
    
    metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    systemctl start apache2
    EOF
    
    allow_stopping_for_update = true
}

resource "google_compute_firewall" "instance_firewall" {
  name    = "allow-instance-ports"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = ["0.0.0.0/0"]
}