terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_project_service" "services" {
  for_each = toset([
    "container.googleapis.com",
    "compute.googleapis.com",
    "dns.googleapis.com",
  ])
  project = var.project_id
  service = each.value
}

resource "google_compute_network" "vpc" {
  name                    = "gke-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "gke_firewall" {
  for_each = var.firewall_rules

  name    = each.value.name
  network = google_compute_network.vpc.name

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }

  source_tags        = each.value.source_tags
  target_tags        = each.value.target_tags
  direction          = each.value.direction
  source_ranges      = each.value.source_ranges
  destination_ranges = each.value.destination_ranges
}

