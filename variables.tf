variable "eks_managed_node_groups" {
  type        = map(any)
  description = "Map of EKS managed node group definitions to create"
}
variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}
variable "name_prefix" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
}
variable "main_network_block" {
  type        = string
  description = "Base CIDR block to be used in our VPC."
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "private_subnets" {
  type        = list(string)
  description = "Private subnet cidr block"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnet cidr block"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

}
variable "external_dns_iam_role" {
  type        = string
  description = "IAM Role Name associated with external-dns service."
}
variable "external_dns_chart_name" {
  type        = string
  description = "Chart Name associated with external-dns service."
}

variable "external_dns_chart_repo" {
  type        = string
  description = "Chart Repo associated with external-dns service."
}

variable "external_dns_chart_version" {
  type        = string
  description = "Chart Repo associated with external-dns service."
}

variable "external_dns_values" {
  type        = map(string)
  description = "Values map required by external-dns service."
}

variable "dns_hosted_zone" {
  type        = string
  description = "DNS Zone name to be used from EKS Ingress."
}

variable "load_balancer_name" {
  type        = string
  description = "Load-balancer service name."
}
variable "alb_controller_iam_role" {
  type        = string
  description = "IAM Role Name associated with load-balancer service."
}
variable "alb_controller_chart_name" {
  type        = string
  description = "AWS Load Balancer Controller Helm chart name."
}
variable "alb_controller_chart_repo" {
  type        = string
  description = "AWS Load Balancer Controller Helm repository name."
}
variable "alb_controller_chart_version" {
  type        = string
  description = "AWS Load Balancer Controller Helm chart version."
}

variable "admin_users" {
  type        = list(string)
  description = "List of Kubernetes admins."
}
variable "developer_users" {
  type        = list(string)
  description = "List of Kubernetes developers."
}
variable "helm_repo_url" {
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
  description = "Helm repository"
}

variable "argocd_namespace" {
  description = "Namespace to release argocd into"
  type        = string
  default     = "argocd"
}

variable "argocd_helm_chart_version" {
  description = "argocd helm chart version to use"
  type        = string
  default     = ""
}

variable "argocd_server_host" {
  description = "Hostname for argocd (will be utilised in ingress if enabled)"
  type        = string
  default = "argocd.calvineotieno.com"
}

variable "argocd_ingress_class" {
  description = "Ingress class to use for argocd"
  type        = string
  default     = "nginx"
}

variable "argocd_ingress_enabled" {
  description = "Enable/disable argocd ingress"
  type        = bool
  default     = true
}

variable "argocd_ingress_tls_acme_enabled" {
  description = "Enable/disable acme TLS for ingress"
  type        = string
  default     = "true"
}

variable "argocd_ingress_ssl_passthrough_enabled" {
  description = "Enable/disable SSL passthrough for ingresss"
  type        = string
  default     = "true"
}

variable "argocd_ingress_tls_secret_name" {
  description = "Secret name for argocd TLS cert"
  type        = string
  default     = "argocd-cert"
}

variable "argocd_name" {
  default = "argocd-demo"
}

