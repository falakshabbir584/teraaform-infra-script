resource "google_compute_firewall" "allow_https_compute_engine" {
  name        = "${var.COMPUTE_ENGINE_NAME}-allow-https"
  network     = var.NETWORK_NAME
  description = "Allow HTTPS (port 443) from all sources"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]  # Public access from anywhere to access hosted tools in VM
  target_tags   = ["${var.COMPUTE_ENGINE_NAME}-tag"]
}

resource "google_compute_firewall" "allow_ssh" {
  name        = "${var.COMPUTE_ENGINE_NAME}-allow-ssh"
  network     = var.NETWORK_NAME
  description = "Allow SSH (port 22) only from a trusted IP"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  direction     = "INGRESS"
  source_ranges = ["${var.COMPUTE_ENGINE_SSH_WHITELIST}"]
  target_tags   = ["${var.COMPUTE_ENGINE_NAME}-tag"]
}
