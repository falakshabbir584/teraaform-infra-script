terraform {
 backend "gcs" {
    credentials = file(var.SERVICE_ACCOUNT_FILE)
    bucket  = var.BUCKET_NAME
    prefix  = "terraform/state"
 }
}