include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_terragrunt_dir()}/../../terraform"
}

inputs = {
  project_id   = "your-project-id" # Replace with your project ID
  cluster_name = "test-cluster"
  region       = "us-central1"
  dns_name     = "test.example.com"
}

run "test_cluster_exists" {
  command = "apply"

  assert {
    condition     = google_container_cluster.primary.name == inputs.cluster_name
    error_message = "Cluster name does not match"
  }
}