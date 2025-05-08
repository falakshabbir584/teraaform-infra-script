resource "google_compute_global_address" "GLB_IP" {
  name = var.GLB_Address_Name
  labels = {
    label= var.GLB_Address_Name
  }
}

resource "google_compute_ssl_policy" "ssl_policy" {
  name = "ssl-policy-tls1-2"
  profile = "MODERN"
  min_tls_version = "TLS_1_2"
}

resource "google_compute_managed_ssl_certificate" "ssl_certificate" {
  name = "ssl-certificate-dev"
  managed {
    domains = ["${var.DOMAIN_NAME}"]
  }
}

resource "google_compute_target_https_proxy" "frontend_https_proxy" {
  name            = "frontend-https-proxy"
  url_map         = google_compute_url_map.frontend_url_map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl_certificate.id]
  ssl_policy      = google_compute_ssl_policy.ssl_policy.id
}

resource "google_compute_url_map" "frontend_url_map" {
  name = "frontend-url-map"
  
  default_url_redirect {
    https_redirect = true
    strip_query = false
  }

  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_http_health_check" "backend_health_check" {
  name               = "backend-health-check"
  port               = 80
  request_path       = "/"
  check_interval_sec = 5
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2
}

data "google_compute_network_endpoint_group" "backend_neg_1" {
  name    = "neg-1"
  project = var.PROJECT_ID
  zone    = var.ZONE_A
}

data "google_compute_network_endpoint_group" "backend_neg_2" {
  name    = "neg-2"
  project = var.PROJECT_ID
  zone    = var.ZONE_B
}

data "google_compute_network_endpoint_group" "backend_neg_3" {
  name    = "neg-3"
  project = var.PROJECT_ID
  zone    = var.ZONE_C
}

resource "google_compute_global_forwarding_rule" "frontend_forwarding_rule" {
  name          = "frontend-forwarding-rule"
  target        = google_compute_target_https_proxy.frontend_https_proxy.id
  ip_address    = google_compute_global_address.GLB_IP.address
  port_range    = "443"
}

resource "google_compute_security_policy" "default_cloud_armor_policy" {
  name        = "default-cloud-armor-policy"
  description = "Cloud Armor policy for default protection"
  rule {
    action   = "allow"
    priority = 1000
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["0.0.0.0/0"]
      }
    }
  }
}

resource "google_compute_backend_service" "backend" {
  name                     = "backend-service-with-armor"
  protocol                 = "HTTPS"
  timeout_sec              = 300
  health_checks = [google_compute_http_health_check.backend_health_check.id]
  enable_cdn = false
  log_config {
    enable = true
  }
  backend {
    group = data.google_compute_network_endpoint_group.backend_neg_1.id
  }
  backend {
    group = data.google_compute_network_endpoint_group.backend_neg_2.id
  }
  backend {
    group = data.google_compute_network_endpoint_group.backend_neg_3.id
  }

  security_policy = google_compute_security_policy.default_cloud_armor_policy.id
}