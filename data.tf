# get all available AZs in our region
data "aws_availability_zones" "available_azs" {
  state = "available"
}

data "aws_caller_identity" "current" {} # used for accesing Account ID and ARN

# get DNS Hosted Zone
# ATTENTION: if you don't have a Route53 Zone already, replace this data by a new resource
data "aws_route53_zone" "hosted_zone" {
  name = var.dns_hosted_zone
}

# data "kubectl_file_documents" "namespace" {
#   content = file("./manifests/namespace.yaml")
# }

# data "kubectl_file_documents" "argocd" {
#   content = file("./manifests/install.yaml")
# }

# data "kubectl_file_documents" "grpc" {
#   content = file("./manifests/service-grpc.yaml")
# }

# data "kubectl_file_documents" "ingress" {
#   content = file("./manifests/ingress.yaml")
# }
# data "kubectl_file_documents" "appset" {
#   content = file("./manifests/app-set.yaml")
# }
