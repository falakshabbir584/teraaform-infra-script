resource "google_service_account" "gke_service_account" {
  account_id   = "${var.CLUSTER_NAME}-sa"
  display_name = "${var.CLUSTER_NAME} GKE Service Account"
}

resource "google_project_iam_member" "gke_sa_container_admin" {
  project = var.PROJECT_ID
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gke_service_account.email}"
}

resource "google_project_iam_member" "gke_sa_iam_user" {
  project = var.PROJECT_ID
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.gke_service_account.email}"
}

resource "google_container_cluster" "cluster" {
  name     = var.CLUSTER_NAME
  location = var.REGION
  project  = var.PROJECT_ID
  
  remove_default_node_pool = true
  initial_node_count       = 1
  networking_mode          = "VPC_NATIVE"
  deletion_protection = false
  release_channel {
    channel = "REGULAR"
  }

  network    = var.NETWORK_NAME
  subnetwork = var.SUBNET_NAME

  ip_allocation_policy {
    cluster_secondary_range_name  = var.PODS_RANGE_NAME
    services_secondary_range_name = var.SERVICES_RANGE_NAME
  }

  resource_labels = {
    cluster = var.CLUSTER_NAME
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = var.MASTER_IP_RANGE
  }

  maintenance_policy {
    recurring_window {
      start_time = "2025-05-10T11:00:00Z"  # Saturday 11 AM UTC
      end_time   = "2025-05-11T09:00:00Z"  # Sunday 9 AM UTC
      recurrence = "FREQ=WEEKLY;BYDAY=SA"
    }
  }

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS", "WORKLOADS", "APISERVER", "SCHEDULER", "CONTROLLER_MANAGER"
    ]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS", "POD", "DEPLOYMENT", "STATEFULSET", "DAEMONSET", "HPA", "CADVISOR", "KUBELET"]
    managed_prometheus {
      enabled = true
    }
  }

  confidential_nodes {
    enabled = true
  }

  master_authorized_networks_config {
    gcp_public_cidrs_access_enabled      = false
  }

  addons_config {
  gcs_fuse_csi_driver_config {
    enabled = true
  }
  gke_backup_agent_config {
    enabled = true
  }
  }
  database_encryption {
    state    = "ENCRYPTED"
    key_name = var.KMS_KEY_NAME
  }

  workload_identity_config {
    workload_pool = "${var.PROJECT_ID}.svc.id.goog"
  }

  node_config {
    machine_type = var.GKE_MACHINE_TYPE
    image_type   = "COS_CONTAINERD"
    disk_size_gb = 100
    service_account = google_service_account.gke_service_account.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    tags = [var.CLUSTER_NAME]

    shielded_instance_config {
      enable_secure_boot = true
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  node_locations = [var.ZONE_A, var.ZONE_B, var.ZONE_C]

  enable_shielded_nodes = true
}

resource "google_container_node_pool" "primary_node_pool" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.cluster.name
  location   = google_container_cluster.cluster.location
  node_count = 1

  node_config {
    machine_type = var.GKE_MACHINE_TYPE
    disk_size_gb = 100
    image_type   = "COS_CONTAINERD"
    tags         = ["${var.CLUSTER_NAME}-tag"]

    shielded_instance_config {
      enable_secure_boot = true
    }
  }

  autoscaling {
    min_node_count = var.MINIMUM_NODE_COUNT
    max_node_count = var.MAXIMUM_NODE_COUNT
  }

  management {
    auto_upgrade = false
    auto_repair  = true
  }
}
