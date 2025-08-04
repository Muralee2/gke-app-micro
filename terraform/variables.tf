variable "project_id" {
  type = string
}

variable "region" {
  type = string
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


