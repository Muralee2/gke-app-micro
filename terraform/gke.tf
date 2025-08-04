resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  depends_on = [
    google_project_service.services,
  ]
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "default-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    machine_type = "e2-micro" # Free tier eligible
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}