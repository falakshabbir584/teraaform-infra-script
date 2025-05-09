output "cloud_router_name" {
  description = "The name of the Cloud Router"
  value       = google_compute_router.cloud_router.name
}

output "cloud_nat_name" {
  description = "The name of the Cloud NAT"
  value       = google_compute_router_nat.cloud_nat.name
}

output "nat_ip_addresses" {
  description = "List of external IP addresses used for Cloud NAT"
  value       = google_compute_address.cloud_nat_public_ip[*].address
}
