variable "REGION" {
  description = "The region where the subnet will be created (e.g., asia-south1 for Mumbai)."
  type        = string
}

variable "ARTIFACT_REGISTRY_NAME" {
  description = "Artifact Registry Name"
}

variable "ARTIFACT_REGISTRY_KEEP_COUNT" {
  description = "Please provide the number of Artifact Registry count which will store."
}