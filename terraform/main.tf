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

# Firewall rules via external data source
data "external" "firewall_rules" {
  program = ["python3", "${path.module}/../scripts/firewall_rules.py"]
  query = {
    project_id   = var.project_id
    network_name = google_compute_network.vpc.name
  }
}

# 🔧 Decode the stringified firewall rules JSON into a local map
locals {
  firewall_rules = jsondecode(data.external.firewall_rules.result.rules)
}

resource "google_compute_firewall" "gke_firewall" {
  for_each = local.firewall_rules

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
