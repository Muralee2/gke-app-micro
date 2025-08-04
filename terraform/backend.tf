# terraform/backend.tf
terraform {
  backend "gcs" {
    bucket = "project-og"  # Replace with your bucket name
    prefix = "terraform/state"
  }
}
