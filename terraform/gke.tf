resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  network    = module.vpc.network_name
  subnetwork = module.vpc.subnets[0].name

  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  release_channel {
    channel = "REGULAR"
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.region

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    tags = ["gke-node"]
  }

  node_count = 2
}

# firewall.tf
resource "google_compute_firewall" "allow_lb_health_checks" {
  name    = "allow-lb-health-checks"
  network = module.vpc.network_name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  direction     = "INGRESS"
  target_tags   = ["gke-node"]
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = module.vpc.network_name

  allow {
    protocol = "all"
  }

  source_ranges = ["10.0.0.0/8"]
  direction     = "INGRESS"
}
