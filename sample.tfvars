cluster_name            = "eks-with-argocd-eks-cluster"
name_prefix             = "eks-with-argocd-development"
main_network_block      = "10.0.0.0/16"

subnet_prefix_extension = 4
zone_offset             = 8

eks_managed_node_groups = {
  "devops-eks-ondemand" = {
    ami_type     = "AL2_x86_64"
    min_size     = 1
    max_size     = 4
    desired_size = 1
    instance_types = [
      "t3.medium",
    ]
    capacity_type = "ON_DEMAND"
    network_interfaces = [{
      delete_on_termination       = true
      associate_public_ip_address = true
    }]
  }
}

external_dns_iam_role      = "external-dns"
external_dns_chart_name    = "external-dns"
external_dns_chart_repo    = "https://kubernetes-sigs.github.io/external-dns/"
external_dns_chart_version = "1.9.0"

external_dns_values = {
  "image.repository"   = "k8s.gcr.io/external-dns/external-dns",
  "image.tag"          = "v0.11.0",
  "logLevel"           = "info",
  "logFormat"          = "json",
  "triggerLoopOnEvent" = "true",
  "interval"           = "5m",
  "policy"             = "sync",
  "sources"            = "{ingress}"
}

dns_hosted_zone              = "calvineotieno.com"
load_balancer_name           = "aws-load-balancer-controller"
alb_controller_iam_role      = "load-balancer-controller"
alb_controller_chart_name    = "aws-load-balancer-controller"
alb_controller_chart_repo    = "https://aws.github.io/eks-charts"
alb_controller_chart_version = "1.4.1"

admin_users     = ["calvine.devops"]
developer_users = ["elvis-kariuki", "peter-donald"]
