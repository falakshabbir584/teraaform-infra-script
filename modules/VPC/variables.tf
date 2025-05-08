variable "NETWORK_NAME" {
  description = "The name of the VPC network to be created."
  type        = string
}

variable "SUBNET_NAME" {
  description = "The name of the primary subnet to be created."
  type        = string
}

variable "REGION" {
  description = "The region where the subnet will be created (e.g., asia-south1 for Mumbai)."
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
  description = "The CIDR range for GKE Services (e.g., 10.30.0.0/20)."
  type        = string
}