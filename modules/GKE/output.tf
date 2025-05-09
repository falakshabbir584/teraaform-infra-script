output "cluster_name" {
  description = "Name of the GKE cluster"
  value       = google_container_cluster.cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint for the GKE cluster"
  value       = google_container_cluster.cluster.endpoint
}

output "cluster_location" {
  description = "Region where the cluster is deployed"
  value       = google_container_cluster.cluster.location
}

output "node_pool_name" {
  description = "Name of the primary node pool"
  value       = google_container_node_pool.primary_node_pool.name
}

output "cluster_self_link" {
  description = "Self-link of the GKE cluster"
  value       = google_container_cluster.cluster.self_link
}

output "node_config_tags" {
  description = "Network tags applied to the node pool"
  value       = google_container_node_pool.primary_node_pool.node_config[0].tags
}
