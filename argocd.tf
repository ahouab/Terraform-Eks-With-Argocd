resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}
resource "helm_release" "argocd" {
    depends_on = [
      kubernetes_namespace.argocd
    ]

    name = "argocd-${var.argocd_name}"
    repository = var.helm_repo_url
    chart = "argo-cd"
    namespace = var.argocd_namespace
    version = var.argocd_helm_chart_version == "" ? null : var.argocd_helm_chart_version

    values = [
        templatefile(
            "./templates/values.yaml.tpl",
            {
                "argocd_server_host"          = var.argocd_server_host
                "argocd_ingress_enabled"                 = var.argocd_ingress_enabled
                "argocd_ingress_tls_acme_enabled"        = var.argocd_ingress_tls_acme_enabled
                "argocd_ingress_ssl_passthrough_enabled" = var.argocd_ingress_ssl_passthrough_enabled
                "argocd_ingress_class"                   = var.argocd_ingress_class
                "argocd_ingress_tls_secret_name"         = var.argocd_ingress_tls_secret_name
            }
        )
    ]

    set {
        name = "server.service.type"
        value = "NodePort"
        type = "string"
    }
}

data "kubernetes_service" "argo_nodeport" {
  depends_on = [
    helm_release.argocd
  ]
  metadata {
    name = "argocd-${var.argocd_name}-server"
    namespace = var.argocd_namespace
  }
}


resource "kubernetes_ingress_v1" "argocd-ingress" {
  depends_on = [
    helm_release.argocd
  ]
  wait_for_load_balancer = true
  metadata {
    name = "argocd-${var.argocd_name}"
    namespace = var.argocd_namespace

    annotations = {
      "kubernetes.io/ingress.class"                    = "alb"
      "alb.ingress.kubernetes.io/load-balancer-name" = var.load_balancer_name
      "alb.ingress.kubernetes.io/scheme"               = "internet-facing"
      "alb.ingress.kubernetes.io/backend-protocol" = "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-path" = "/"
      "alb.ingress.kubernetes.io/certificate-arn"      = aws_acm_certificate_validation.eks_domain_cert_validation.certificate_arn // Attach ACM arn
      "alb.ingress.kubernetes.io/listen-ports"         = <<JSON
      [{"HTTP": 80}, {"HTTPS":443}]
      JSON
      "alb.ingress.kubernetes.io/actions.ssl-redirect" = <<JSON
      {"Type": "redirect", "RedirectConfig": { "Protocol": "HTTPS", "Port": "443", "StatusCode": "HTTP_301"}}
      JSON
    }
  }
       spec {
      rule {
        host = var.argocd_server_host
        http {
         path {
           path = "/"
           path_type = "Prefix"
           backend {
             service {
               name = "argocd-${var.argocd_name}-server"
               port {
                 number = 443
               }
             }
           }
        }
      }
    }
  }
}
