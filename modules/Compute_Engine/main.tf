resource "google_service_account" "compute_engine_service_account" {
  account_id   = "${var.COMPUTE_ENGINE_NAME}-sa"
  display_name = "${var.COMPUTE_ENGINE_NAME} GKE Service Account"
}

resource "google_project_iam_member" "gke_sa_container_admin" {
  project = var.PROJECT_ID
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.compute_engine_service_account.email}"
}

resource "google_project_iam_member" "gke_sa_iam_user" {
  project = var.PROJECT_ID
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.compute_engine_service_account.email}"
}

resource "google_compute_address" "static" {
  name   = "${var.COMPUTE_ENGINE_NAME}-ip"
  region = var.REGION
}

resource "google_compute_disk" "persistent_disk" {
  name  = "${var.COMPUTE_ENGINE_NAME}-disk"
  size  = 50
  type  = var.COMPUTE_ENGINE_DISK_TYPE
  zone  = var.ZONE_A
  labels = {
    environment = "${var.COMPUTE_ENGINE_NAME}-disk"
  }
  disk_encryption_key {
    kms_key_self_link = "projects/${var.PROJECT_ID}/locations/${var.REGION}/keyRings/${var.KMS_KEY_RING_NAME}/cryptoKeys/${var.KMS_KEY_NAME}"
  }
}

data "google_compute_image" "debian_image" {
  family  = var.COMPUTE_ENGINE_FAMILY
  project = var.COMPUTE_ENGINE_PROJECT
}

resource "google_compute_instance" "vm_instance" {
  name         = var.COMPUTE_ENGINE_NAME
  zone         = var.ZONE_A
  machine_type = var.COMPUTE_ENGINE_MACHINE_TYPE
  tags = ["${var.COMPUTE_ENGINE_NAME}-tag"] 

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
    }
  }

  service_account {
    email  = google_service_account.compute_engine_service_account.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  attached_disk {
    device_name = "disk"
    source      = google_compute_disk.persistent_disk.id
    mode        = "READ_WRITE"
  }

  labels = {
    label = var.COMPUTE_ENGINE_NAME
  }

  network_interface {
    network    = var.NETWORK_NAME
    subnetwork = var.SUBNET_NAME
    
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
}