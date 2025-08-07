resource "google_compute_firewall" "allow_lb_health_checks" {
  name    = "allow-lb-health-checks"
  network = module.vpc.network_name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  direction     = "INGRESS"
  target_tags   = ["gke-node"]
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = module.vpc.network_name

  allow {
    protocol = "all"
  }

  source_ranges = ["10.0.0.0/8"]
  direction     = "INGRESS"
}
