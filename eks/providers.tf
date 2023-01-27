provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project   = "eks-argocd-demo"
      ManagedBy = "Terraform"
    }
  }
}

# get EKS authentication for being able to manage k8s objects from terraform
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
