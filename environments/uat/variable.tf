## Provider Configuration ##
variable "PROJECT_ID" {
  description = "Please enter the Project ID of GCP"
  type        = string
  sensitive   = true
}

variable "REGION" {
  description = "Please enter the region for resources."
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

variable "SERVICE_ACCOUNT_FILE" {
  description = "Path to the service account key file."
  type        = string
}

## VPC Configuration ##
variable "NETWORK_NAME" {
  description = "The name of the VPC network to be created."
  type        = string
}

variable "SUBNET_NAME" {
  description = "The name of the primary subnet to be created."
  type        = string
}

variable "PRIMARY_RANGE" {
  description = "The primary IP CIDR range for the subnet (e.g., 10.10.0.0/16)."
  type        = string
}

variable "PODS_RANGE_NAME" {
  description = "The name for the secondary IP range used for GKE Pods."
  type        = string
}

variable "PODS_RANGE" {
  description = "The CIDR range for GKE Pods (e.g., 10.20.0.0/16)."
  type        = string
}

variable "SERVICES_RANGE_NAME" {
  description = "The name for the secondary IP range used for GKE Services."
  type        = string
}

variable "SERVICES_RANGE" {
  description = "The CIDR range for GKE Services (e.g., 10.30.0.0/20)"
  type        = string
}

variable "ROUTER_NAME" {
  description = "Cloud Router Name"
  type        = string
}

variable "ARTIFACT_REGISTRY_NAME" {
  description = "Artifact Registry Name"
  type        = string
}

variable "ARTIFACT_REGISTRY_KEEP_COUNT" {
  description = "Please provide the number of Artifact Registry count which will store."
  type        = number
}

variable "CLUSTER_NAME" {
  description = "The name of the GKE cluster"
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

variable "MINIMUM_NODE_COUNT" {
  type        = string
  description = "Please provide the number of minimum node counts for gke"
}

variable "MAXIMUM_NODE_COUNT" {
  type        = string
  description = "Please provide the number of maximum node counts for gke"
}

variable "CLOUD_NAT_NAME" {
  description = "Cloud Nat Name"
  type        = string
}

variable "KMS_KEY_RING_NAME" {
  description = "Name of the KMS key ring"
  type        = string
}

variable "KMS_KEY_NAME" {
  description = "Name of the KMS key"
  type        = string
}

variable "BUCKET_NAME" {
  description = "Name of the GCS bucket"
  type        = string
}

## Compute Engine Configuration ##
variable "COMPUTE_ENGINE_NAME" {
  description = "The name of the compute engine instance"
  type        = string
}

variable "COMPUTE_ENGINE_DISK_TYPE" {
  description = "The type of the disk. Can be either 'pd-standard' or 'pd-ssd'"
  type        = string
  default     = "pd-standard"
}

variable "COMPUTE_ENGINE_IMAGE" {
  description = "The image family to use for the instance"
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "COMPUTE_ENGINE_FAMILY" {
  description = "The specific image name to use (e.g., 'ubuntu-2204-lts')"
  type        = string
}

variable "COMPUTE_ENGINE_PROJECT" {
  description = "The GCP project where the image resides"
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "COMPUTE_ENGINE_MACHINE_TYPE" {
  description = "The machine type of the instance (e.g., n1-standard-1)"
  type        = string
}

variable "GLB_Address_Name" {
  description = "The name of the global IP address for the load balancer"
  type        = string
}

variable "DOMAIN_NAME" {
  description = "The domain name for the SSL certificate"
  type        = string
}

variable "COMPUTE_ENGINE_SSH_WHITELIST" {
  description = "Please provide the subnet range of public ips to access vm in gcp"
  type        = string
}