# Holds the main configuration for the Terraform project - resources

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0" # best to use ~> and not >=
    }
  }
}

provider "google" {
  # credentials = file(var.gcp_credentials_file) not needed if doing local development
  project = var.gcp_project_id
  region  = var.gcp_region

}

# Create a custom network for the VM
resource "google_compute_network" "custom_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false # bad practice to use auto-create subnets since it creates a subnet in every region

}

# Create a subnet for the custom network
resource "google_compute_subnetwork" "custom_subnetwork" {
  name          = "terraform-subnetwork"
  region        = var.gcp_region
  network       = google_compute_network.custom_network.name
  ip_cidr_range = "10.0.0.0/24"
}

resource "google_compute_instance" "vm" {
  name         = "vm-instance-testing"
  machine_type = "e2-medium"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.custom_subnetwork.name
    # access_config {}
  }

  metadata_startup_script = file("${path.module}/startup.sh")

}