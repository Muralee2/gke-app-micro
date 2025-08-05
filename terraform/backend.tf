# terraform/backend.tf
terraform {
  backend "gcs" {
    bucket = "samurai-og"  # Replace with your bucket name
    prefix = "terraform/state"
  }
}
