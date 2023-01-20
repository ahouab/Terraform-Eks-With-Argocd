module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  version                         = "19.5.1"
  cluster_name                    = var.cluster_name
  cluster_version                 = "1.24"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  eks_managed_node_groups         = var.eks_managed_node_groups
  subnet_ids                      = module.vpc.private_subnets
  vpc_id                          = module.vpc.vpc_id

  node_security_group_additional_rules = {
    # If you omit this, you will get Internal error occurred: failed calling webhook, the server could not find the requested resource
    # https://github.com/kubernetes-sigs/aws-load-balancer-controller/issues/2039#issuecomment-1099032289
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
}

      # allow connections from ALB security group
    ingress_allow_access_from_alb_sg = {
      type                     = "ingress"
      protocol                 = "-1"
      from_port                = 0
      to_port                  = 0
      source_security_group_id = aws_security_group.alb.id
    }
    # allow connections from EKS to the internet
    egress_all = {
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    # allow internal connections from EKS to EKS
    ingress_self_all = {
      protocol  = "-1"
      from_port = 0
      to_port   = 0
      type      = "ingress"
      self      = true
    }
}
