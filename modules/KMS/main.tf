resource "google_kms_key_ring" "gke_key_ring" {
  name     = var.KMS_KEY_RING_NAME
  location = var.REGION
  project  = var.PROJECT_ID
}

resource "google_kms_crypto_key" "gke_crypto_key" {
  name     = var.KMS_KEY_NAME
  key_ring = google_kms_key_ring.gke_key_ring.id
  purpose  = "ENCRYPT_DECRYPT"
}