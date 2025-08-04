variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "secure-microservice"
}

variable "dns_name" {
  description = "DNS name for the service"
  type        = string
  default     = "microservice.example.com"
}