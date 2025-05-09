## Provider Configuration ##
PROJECT_ID              = "cra-nps-project_id-uat"
REGION                  = "asia-south1"
ZONE_A                  = "asia-south1-a"
ZONE_B                  = "asia-south1-b"
ZONE_C                  = "asia-south1-c"
SERVICE_ACCOUNT_FILE    = "key.json"

## VPC Configuration ##
NETWORK_NAME            = "cra-nps-vpc-uat"
SUBNET_NAME             = "primary-subnet-mumbai"
PRIMARY_RANGE           = "10.34.32.0/21"
PODS_RANGE_NAME         = "secondary-subnet-mumbai"
PODS_RANGE              = "10.34.16.0/20"
SERVICES_RANGE_NAME     = "service-subnet-mumbai"
SERVICES_RANGE          = "10.34.0.0/20"

## Cloud Router and NAT Configuration ##
ROUTER_NAME             = "cra-nps-router-uat"
CLOUD_NAT_NAME          = "cra-nps-nat-uat"

## Artifact Registry Configuration ##
ARTIFACT_REGISTRY_NAME  = "cra-nps-artifact-registry-uat"
ARTIFACT_REGISTRY_KEEP_COUNT = "10"

## GKE ##
CLUSTER_NAME            = "cra-nps-cluster-uat"
MASTER_IP_RANGE         = "10.34.32.0/28"
GKE_MACHINE_TYPE        = "n2d-standard-4" ##(estimated 30 services, we have enabled autoscaling also for that.)
MINIMUM_NODE_COUNT      = "1"
MAXIMUM_NODE_COUNT      = "9"

## KMS ##
KMS_KEY_RING_NAME       = "cra-nps-kms-keyring-uat"
KMS_KEY_NAME            = "cra-nps-kms-key-uat"

## Bucket ##
BUCKET_NAME             = "cra-nps-bucket-uat"

## Compute Engine ##
COMPUTE_ENGINE_NAME     = "cra-nps-compute-engine-uat"
COMPUTE_ENGINE_DISK_TYPE= "pd-standard"
COMPUTE_ENGINE_IMAGE    = "ubuntu-os-cloud"
COMPUTE_ENGINE_FAMILY   = "ubuntu-2204-lts"
COMPUTE_ENGINE_PROJECT  = "ubuntu-os-cloud"
COMPUTE_ENGINE_MACHINE_TYPE = "n2d-standard-2"
COMPUTE_ENGINE_SSH_WHITELIST = "112.196.2.202/32"     ## Wits VPN IP range we are putting this to configure the VM.

## Global Load Balancer ##
GLB_Address_Name        = "cra-nps-glb-ip"
DOMAIN_NAME             = "cra-nps-uat-proteantech.in"