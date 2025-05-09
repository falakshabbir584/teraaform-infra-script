module "vpc" {
  source = "../../modules/VPC"
  
  NETWORK_NAME        = var.NETWORK_NAME
  SUBNET_NAME         = var.SUBNET_NAME
  REGION              = var.REGION
  PRIMARY_RANGE       = var.PRIMARY_RANGE
  PODS_RANGE_NAME     = var.PODS_RANGE_NAME
  PODS_RANGE          = var.PODS_RANGE
  SERVICES_RANGE_NAME = var.SERVICES_RANGE_NAME
  SERVICES_RANGE      = var.SERVICES_RANGE
}

module "cloud_router_nat" {
  source        = "../../modules/Cloud_Router_NAT"
  depends_on    = [module.vpc]
  
  ROUTER_NAME         = var.ROUTER_NAME
  NETWORK_NAME        = var.NETWORK_NAME
  REGION              = var.REGION
  SUBNET_NAME         = var.SUBNET_NAME
  CLOUD_NAT_NAME      = var.CLOUD_NAT_NAME
}

module "artifact_registry" {
  source                     = "../../modules/Artifact_Registry"
  depends_on                 = [module.cloud_router_nat]
  
  REGION                     = var.REGION
  ARTIFACT_REGISTRY_NAME     = var.ARTIFACT_REGISTRY_NAME
  ARTIFACT_REGISTRY_KEEP_COUNT = var.ARTIFACT_REGISTRY_KEEP_COUNT
}

module "NEG" {
  source     = "./../../modules/NEG"
  depends_on = [module.artifact_registry]
  
}

module "KMS" {
  source     = "../../modules/KMS"
  
  depends_on = [module.NEG]
  PROJECT_ID           = var.PROJECT_ID
  REGION       = var.REGION
  KMS_KEY_RING_NAME    = var.KMS_KEY_RING_NAME
  KMS_KEY_NAME = var.KMS_KEY_NAME
}

module "gke_cluster" {
  source     = "../../modules/GKE"
  depends_on = [module.KMS]
  
  CLUSTER_NAME         = var.CLUSTER_NAME
  REGION               = var.REGION
  PROJECT_ID           = var.PROJECT_ID
  MASTER_IP_RANGE      = var.MASTER_IP_RANGE
  GKE_MACHINE_TYPE     = var.GKE_MACHINE_TYPE
  NETWORK_NAME         = var.NETWORK_NAME
  SUBNET_NAME          = var.SUBNET_NAME
  PODS_RANGE_NAME      = var.PODS_RANGE_NAME
  SERVICES_RANGE_NAME  = var.SERVICES_RANGE_NAME
  ZONE_A               = var.ZONE_A
  ZONE_B               = var.ZONE_B
  ZONE_C               = var.ZONE_C
  KMS_KEY_RING_NAME    = var.KMS_KEY_RING_NAME
  KMS_KEY_NAME         = var.KMS_KEY_NAME
  MINIMUM_NODE_COUNT   = var.MINIMUM_NODE_COUNT
  MAXIMUM_NODE_COUNT   = var.MAXIMUM_NODE_COUNT
}

module "google_compute_engine" {
  source     = "./../../modules/Compute_Engine"
  depends_on = [module.VPC]
  
  PROJECT_ID                  = var.PROJECT_ID
  COMPUTE_ENGINE_NAME         = var.COMPUTE_ENGINE_NAME
  REGION                      = var.REGION
  ZONE_A                      = var.ZONE_A
  COMPUTE_ENGINE_DISK_TYPE    = var.COMPUTE_ENGINE_DISK_TYPE
  KMS_KEY_NAME                = var.KMS_KEY_NAME
  KMS_KEY_RING_NAME           = var.KMS_KEY_RING_NAME
  COMPUTE_ENGINE_IMAGE        = var.COMPUTE_ENGINE_IMAGE
  COMPUTE_ENGINE_FAMILY       = var.COMPUTE_ENGINE_FAMILY
  COMPUTE_ENGINE_PROJECT      = var.COMPUTE_ENGINE_PROJECT
  COMPUTE_ENGINE_MACHINE_TYPE = var.COMPUTE_ENGINE_MACHINE_TYPE
  NETWORK_NAME                = var.NETWORK_NAME
  SUBNET_NAME                 = var.SUBNET_NAME
}

module "Firewall_Rules" {
  source     = "./../../modules/Firewall_Rules"
  depends_on = [module.google_compute_engine]
  
  NETWORK_NAME                 = var.NETWORK_NAME
  COMPUTE_ENGINE_NAME          = var.COMPUTE_ENGINE_NAME
  COMPUTE_ENGINE_SSH_WHITELIST = var.COMPUTE_ENGINE_SSH_WHITELIST
}

module "Global_Load_Balancer" {
  source     = "./../../modules/Global_Load_Balancer"
  depends_on = [module.Firewall_Rules]
  
  PROJECT_ID          = var.PROJECT_ID
  ZONE_A              = var.ZONE_A
  ZONE_B              = var.ZONE_B
  ZONE_C              = var.ZONE_C
  REGION             = var.REGION
  GLB_Address_Name   = var.GLB_Address_Name
  DOMAIN_NAME        = var.DOMAIN_NAME
}

module "bucket" {
  source     = "../../modules/GCS_Bucket"
  
  depends_on = [module.gke_cluster]
  BUCKET_NAME  = var.BUCKET_NAME
  REGION       = var.REGION
  KMS_KEY_NAME = var.KMS_KEY_NAME
}