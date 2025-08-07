variable "project_id" {}
variable "region" {}
variable "subnet_name" {}
variable "subnet_ip" {}
variable "cluster_name" {}
variable "pods_range_name" {}
variable "services_range_name" {}


variable "zone" {
  description = "The GCP zone to deploy resources in (used in zonal resources)"
  type        = string
}


variable "network_name" {
  type        = string
  description = "The name of the VPC network"
}

variable "pods_ip_range" {
  type        = string
  description = "CIDR range for the GKE Pods secondary IP range"
}

variable "services_ip_range" {
  type        = string
  description = "CIDR range for the GKE Services secondary IP range"
}




