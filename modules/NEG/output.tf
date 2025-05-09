output "namespace" {
  value = kubernetes_namespace.nginx_ingress.metadata[0].name
}

output "helm_release_name" {
  value = helm_release.nginx_ingress.name
}