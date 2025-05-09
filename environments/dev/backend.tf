terraform {
 backend "gcs" {
    credentials = "key.json"
    bucket  = "cra-nps-terraform-bucket" ##Createt this bucket manually in gcp
    prefix  = "terraform/state"
 }
}