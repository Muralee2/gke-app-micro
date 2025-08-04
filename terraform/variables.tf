variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a" # or your preferred zone
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "secure-gke-cluster" # or remove default if you want to pass it manually
}


variable "firewall_rules" {
  description = "Map of firewall rules"
  type = map(object({
    name               = string
    protocol           = string
    ports              = list(string)
    source_tags        = list(string)
    target_tags        = list(string)
    direction          = string
    source_ranges      = list(string)
    destination_ranges = list(string)
  }))
}





