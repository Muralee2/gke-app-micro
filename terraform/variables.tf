variable "zone" {
  description = "GCP zone to deploy resources"
  type        = string
}

variable "gcs_bucket_name" {
  description = "The name of the GCS bucket used for backend state"
  type        = string
}
