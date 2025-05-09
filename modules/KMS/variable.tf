variable "REGION" {
  description = "The region where GKE cluster will be created"
  type        = string
}

variable "PROJECT_ID" {
  description = "The GCP project ID"
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