variable "NETWORK_NAME" {
  description = "The name of the VPC network to be created."
  type        = string
}

variable "REGION" {
  description = "The region where the subnet will be created (e.g., asia-south1 for Mumbai)."
  type        = string
}

variable "ROUTER_NAME" {
  description = "Cloud Router Name"
}

variable "CLOUD_NAT_NAME" {
  description = "Cloud Nat Name"
}

variable "SUBNET_NAME" {
  description = "The name of the primary subnet to be created."
  type        = string
}