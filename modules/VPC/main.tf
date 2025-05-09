resource "google_compute_network" "vpc_network" {
  name                             = var.NETWORK_NAME
  auto_create_subnetworks          = false
  routing_mode                     = "GLOBAL"
  delete_default_routes_on_create  = true
}

resource "google_compute_subnetwork" "vpc_subnet" {
  depends_on = [ google_compute_network.vpc_network ]
  name                  = var.SUBNET_NAME
  ip_cidr_range         = var.PRIMARY_RANGE
  region                = var.REGION
  network               = google_compute_network.vpc_network.id

  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  secondary_ip_range {
    range_name    = var.PODS_RANGE_NAME
    ip_cidr_range = var.PODS_RANGE
  }

  secondary_ip_range {
    range_name    = var.SERVICES_RANGE_NAME
    ip_cidr_range = var.SERVICES_RANGE
  }
}