resource "kubernetes_namespace" "nginx_ingress" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  namespace  = kubernetes_namespace.nginx_ingress.metadata[0].name
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.12.1"

  values = [yamlencode({
    controller = {
      replicaCount = 3
      admissionWebhooks = {
        enabled = true
        patch = {
          enabled = true
        }
      }
      service = {
        type = "ClusterIP"
        annotations = {
          "cloud.google.com/neg" = jsonencode({
            exposed_ports = {
              "80" = {
                name = "ingress-nginx-internal-prod-80-neg-http"
              }
            }
          })
        }
      }
    }
  })]
}