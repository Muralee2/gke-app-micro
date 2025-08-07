resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}


resource "google_compute_subnetwork" "gke_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_ip
  region        = var.region
  network       = google_compute_network.vpc.id
  purpose       = "PRIVATE"
  stack_type    = "IPV4_ONLY"

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = var.pods_ip_range
  }

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = var.services_ip_range
  }
}
