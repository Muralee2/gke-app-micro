data "google_service_account" "gke_workload_sa" {
  account_id = "gke-workload-sa"
  project    = var.project_id
}

resource "google_container_cluster" "primary" {
  name                     = "my-gke-cluster"
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    machine_type    = "e2-medium"
    service_account = data.google_service_account.gke_workload_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}


