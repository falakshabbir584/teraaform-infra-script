terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = var.PROJECT_ID
  region  = var.REGION
  credentials = file(var.SERVICE_ACCOUNT_FILE)
}

provider "kubernetes" {
  config_path    = "~/.kube/config" 
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}