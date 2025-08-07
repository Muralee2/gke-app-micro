variable "project_id" {}
variable "region" {}
variable "network_name" {}
variable "subnet_name" {}
variable "subnet_ip" {}
variable "cluster_name" {}
variable "pods_range_cidr" {
  description = "CIDR range for GKE pods"
  type        = string
}

variable "services_range_cidr" {
  description = "CIDR range for GKE services"
  type        = string
}




