# Setup EKS and ArgoCD
EKS Deployment with ArgoCD with Terraform

## Complete Usage

Check this
[GitOps with ArgoCD, EKS and GitLab CI using Terraform)](https://medium.com/@calvineotieno010/gitops-with-argocd-eks-and-gitlab-ci-using-terraform-2a3c094b4ea3)
for detailed explanation.

### CI Environment Variables

These Environment Variables are needed for the pipeline when
runnig Terraform commands.

* `AWS_ROLE ARN` - AWS Role Arn to used by the pipeline to get temporary credentials
* `AWS_DEFAULT_REGION` - AWS region where the S3 bucket is located

### Local Environment Variables

These Environment Variables are needed for the pipeline when
runnig Terraform commands.

* `AWS_DEFAULT_REGION` - AWS region to create the resources

* `AWS_ACCESS_KEY_ID` - Access Key ID to be used by the pipeline
to authenticate with your AWS Account

* `AWS_SECRET_ACCESS_KEY` - Secret Access Key to authenticate with your AWS Account

### Click-Ops
You need to do these bootstrapping bits.

* Create an `S3 Bucket` and `Amazon DynamoDB` for you to store terraform remote state and state locking. You can work with local state but...
* Create a `Hosted zone` in `Route53` with a public domain

Check `backend.tfvars` file in each folders (`eks` and `argocd`) and update accordingly.


### EKS Terraform Variables Values
Check `sample.tfvars` file in `eks` directory and update accordingly especially `dns_hosted_zone`, `admin_users` and `developer_users`.


### Running Locally

You need to first apply the `eks` before applying `argocd`.

#### EKS
Check into the folder
```bash
cd eks
```

##### Terraform Commands

```bash
# Initialize Terraform
terraform init -backend-config=backend.tfvars

# Generate Plan
terraform plan -out=eks.tfplan -var-file=sample.tfvars

# Apply the Plan
terraform apply eks.tfplan
```


#### ArgoCD
Check into the folder
```bash
cd argocd
```

##### Terraform Commands

```bash
# Initialize Terraform
terraform init -backend-config=backend.tfvars

# Generate Plan
terraform plan -out=argocd.tfplan

# Apply the Plan
terraform apply argocd.tfplan
```

### Running Locally Using Docker Compose (Recommended)

You can create a docker compose file with this content.

This assumes you have configured MFA for your AWS IAM User you are using locally.

```yaml
version: '3.7'

services:
  terraform:
    image: hashicorp/terraform:1.3.7
    volumes:
      - .:/infra
    working_dir: /infra
    environment:
      - AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
      - AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
      - AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
```

##### Example Usage

```bash
docker-compose -f docker-compose.yaml run --rm terraform init -backend-config=backend.tfvars
```

### Running on the CI

Check this
[GitOps with ArgoCD, EKS and GitLab CI using Terraform)](https://medium.com/@calvineotieno010/gitops-with-argocd-eks-and-gitlab-ci-using-terraform-2a3c094b4ea3)
for detailed explanation.

## License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

See the LICENSE file for more info
