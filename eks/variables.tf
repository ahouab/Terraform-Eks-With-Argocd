variable "aws_region" {
  type = string
  description = "AWS region to create the infrastructure"
  default = "eu-west-1"
}
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
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
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
