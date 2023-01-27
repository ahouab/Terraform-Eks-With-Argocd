data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "devops-demo.tfstate"
    key    = "argoinfra.json"
    region = "eu-west-1"
    workspace_key_prefix = "environment"
    dynamodb_table       = "devops-demo.tfstate.lock"
  }
}


# get EKS authentication for being able to manage k8s objects from terraform
provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "${data.terraform_remote_state.eks.outputs.cluster_name}"]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
    exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", "${data.terraform_remote_state.eks.outputs.cluster_name}"]
    command     = "aws"
  }
  }
}

# data "aws_acm_certificate" "arn" {
#   name = data.terraform_remote_state.eks.outputs.aws_acm_certificate_arn
# }

# args        = ["eks", "get-token", "--cluster-name", var.cluster_name, "--region", var.aws_region]