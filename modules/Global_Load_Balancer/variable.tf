variable "GLB_Address_Name" {
  description = "The name of the global IP address for the load balancer"
  type        = string
}

variable "DOMAIN_NAME" {
  description = "The domain name for the SSL certificate"
  type        = string
}

variable "PROJECT_ID" {
  description = "The project ID in GCP"
  type        = string
}

variable "ZONE_A" {
  description = "Zone A for backend NEG"
  type        = string
}

variable "ZONE_B" {
  description = "Zone B for backend NEG"
  type        = string
}

variable "ZONE_C" {
  description = "Zone C for backend NEG"
  type        = string
}

variable "REGION" {
  description = "Region for resources"
  type        = string
}