output "instance_name" {
  description = "The name of the created compute instance"
  value       = google_compute_instance.vm_instance.name
}

output "instance_ip" {
  description = "The static IP address assigned to the compute instance"
  value       = google_compute_address.static.address
}

output "instance_disk_id" {
  description = "The ID of the persistent disk attached to the instance"
  value       = google_compute_disk.persistent_disk.id
}

output "instance_disk_name" {
  description = "The name of the persistent disk"
  value       = google_compute_disk.persistent_disk.name
}

output "instance_zone" {
  description = "The zone where the instance is created"
  value       = google_compute_instance.vm_instance.zone
}

output "disk_type" {
  description = "The type of disk attached to the instance"
  value       = google_compute_disk.persistent_disk.type
}