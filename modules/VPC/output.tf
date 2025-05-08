output "network_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc_network.name
}

output "network_self_link" {
  description = "The self link of the VPC network"
  value       = google_compute_network.vpc_network.self_link
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = google_compute_subnetwork.vpc_subnet.name
}

output "subnet_self_link" {
  description = "The self link of the subnet"
  value       = google_compute_subnetwork.vpc_subnet.self_link
}

output "secondary_ranges" {
  description = "The secondary IP ranges used for pods and services"
  value = {
    pods_range_name     = var.PODS_RANGE_NAME
    services_range_name = var.SERVICES_RANGE_NAME
  }
}