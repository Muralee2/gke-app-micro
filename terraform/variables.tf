variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "firewall_rules" {
  type = map(object({
    name               = string
    direction          = string
    source_ranges      = list(string)
    target_tags        = list(string)
    protocol           = string
    ports              = list(string)
    source_tags        = list(string)
    destination_ranges = list(string)
  }))
}
