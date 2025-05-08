resource "google_artifact_registry_repository" "artifact" {
  location      = var.REGION
  repository_id = var.ARTIFACT_REGISTRY_NAME
  description   = "This is an artifact registry to store Docker images."
  format        = "DOCKER"
  cleanup_policy_dry_run = false
  mode          = "STANDARD_REPOSITORY"

  cleanup_policies {
    id     = "keep-minimum-versions"
    action = "KEEP"
    most_recent_versions {
      keep_count            = var.ARTIFACT_REGISTRY_KEEP_COUNT
    }
  }

  docker_config {
    immutable_tags = false
  }
}