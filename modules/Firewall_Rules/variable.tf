variable "NETWORK_NAME" {
  description = "The name of the network"
  type        = string
}

variable "COMPUTE_ENGINE_NAME" {
  description = "The name of the compute engine instance"
  type        = string
}

variable "COMPUTE_ENGINE_SSH_WHITELIST" {
  description = "Please provide the subnet range of public ips to access vm in gcp"
  type        = string
}