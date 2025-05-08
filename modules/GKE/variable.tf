variable "CLUSTER_NAME" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "REGION" {
  description = "The region where GKE cluster will be created"
  type        = string
}

variable "PROJECT_ID" {
  description = "The GCP project ID"
  type        = string
}

variable "NETWORK_NAME" {
  description = "The name of the VPC network"
  type        = string
}

variable "SUBNET_NAME" {
  description = "The name of the subnet"
  type        = string
}

variable "MASTER_IP_RANGE" {
  description = "The range of master ip in gke"
  type        = string
}

variable "GKE_MACHINE_TYPE" {
  description = "The name of the machine type of node in gke"
  type        = string
}

variable "PODS_RANGE_NAME" {
  description = "The secondary IP range name for Pods"
  type        = string
}

variable "SERVICES_RANGE_NAME" {
  description = "The secondary IP range name for Services"
  type        = string
}

variable "ZONE_A" {
  description = "Please enter Zone-A"
  type        = string
}
variable "ZONE_B" {
  description = "Please enter Zone-B"
  type        = string
}
variable "ZONE_C" {
  description = "Please enter Zone-C"
  type        = string
}
variable "KMS_KEY_RING_NAME" {
  type        = string
  description = "Name of the KMS key ring"
}
variable "KMS_KEY_NAME" {
  type        = string
  description = "Name of the KMS key"
}
variable "MINIMUM_NODE_COUNT" {
  type        = string
  description = "Please provide the number of minimum node counts for gke"
}
variable "MAXIMUM_NODE_COUNT" {
  type        = string
  description = "Please provide the number of maximum node counts for gke"
}