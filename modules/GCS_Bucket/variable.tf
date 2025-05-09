variable "BUCKET_NAME" {
  description = "Name of the GCS bucket"
  type        = string
}

variable "REGION" {
  description = "The location/region for the bucket (e.g., asia-south1)"
  type        = string
}

variable "KMS_KEY_NAME" {
  description = "KMS key name to encrypt the bucket"
  type        = string
}