resource "google_compute_router" "cloud_router" {
  name    = var.ROUTER_NAME
  region  = var.REGION
  network = var.NETWORK_NAME
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

resource "google_compute_address" "cloud_nat_public_ip" {
  depends_on = [ google_compute_router.cloud_router ]
  count  = 1
  name   = "${var.CLOUD_NAT_NAME}-ip"
  region = var.REGION

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_router_nat" "cloud_nat" {
  depends_on = [ google_compute_address.cloud_nat_public_ip ]
  name                               = var.CLOUD_NAT_NAME
  router                             = google_compute_router.cloud_router.name
  region                             = var.REGION
  nat_ip_allocate_option             = "MANUAL_ONLY"
  initial_nat_ips = [google_compute_address.cloud_nat_public_ip[0].self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = var.SUBNET_NAME
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  log_config {
    enable = true
    filter = "ALL"
  }
}