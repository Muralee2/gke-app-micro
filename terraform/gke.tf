resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  network    = module.vpc.network_name
  subnetwork = values(module.vpc.subnets)[0].name  # ✅ FIXED

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
