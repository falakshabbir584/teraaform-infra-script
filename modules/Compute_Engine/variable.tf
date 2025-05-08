variable "PROJECT_ID" {
  description = "Please enter the Project ID of GCP"
  type        = string
  sensitive = true
}

variable "COMPUTE_ENGINE_NAME" {
  description = "The name of the compute engine instance"
  type        = string
}

variable "REGION" {
  description = "The region where the resources will be created"
  type        = string
}

variable "ZONE_A" {
  description = "The zone where the instance will be created"
  type        = string
}

variable "COMPUTE_ENGINE_DISK_TYPE" {
  description = "The type of the disk. Can be either 'pd-standard' or 'pd-ssd'"
  type        = string
  default     = "pd-standard"
}

variable "KMS_KEY_NAME" {
  description = "The KMS key self-link for disk encryption"
  type        = string
}

variable "KMS_KEY_RING_NAME" {
  type        = string
  description = "Name of the KMS key ring"
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

variable "NETWORK_NAME" {
  description = "The name of the network"
  type        = string
}

variable "SUBNET_NAME" {
  description = "The name of the subnet"
  type        = string
}