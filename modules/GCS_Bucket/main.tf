resource "google_storage_bucket" "bucket" {
  name                        = var.BUCKET_NAME
  location                    = var.REGION
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
    autoclass {
    enabled = true
    terminal_storage_class = "ARCHIVE"
    }
  versioning {
    enabled = true
  }
  encryption {
    default_kms_key_name = var.KMS_KEY_NAME
  }
  soft_delete_policy {
    retention_duration_seconds = 2592000
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30
    }
  }

  labels = {
    tag = var.BUCKET_NAME
  }
}