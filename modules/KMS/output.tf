output "kms_key_id" {
  value       = google_kms_crypto_key.gke_crypto_key.id
  description = "KMS key self link for CMEK"
}