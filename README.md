# Setup EKS and ArgoCD
EKS Deployment with ArgoCD with Terraform

## Usage

Check this
[GitOps with ArgoCD, EKS and GitLab CI using Terraform)](comming_up)
for detailed explanation.

### Environment Variables

These Environment Variables are needed for the pipeline when
runnig Terraform commands.

* `AWS_ROLE ARN` - AWS Role Arn to used by the pipeline to get temporary credentials
* `AWS_DEFAULT_REGION` - AWS region where the S3 bucket is located
