# AWS Infrastructure as Code with Terraform

This project demonstrates the deployment of a cloud infrastructure on AWS using Terraform. It includes EC2 instances, Lambda functions, S3 buckets, and RDS databases, showcasing a modern cloud architecture with multiple integrated services.

## Architecture Overview

The infrastructure consists of the following components:
- **Network & Security**: VPC, subnets, security groups, and IAM roles
- **Storage & Database**: S3 buckets and RDS instance
- **Serverless Compute**: AWS Lambda functions for AI/ML processing
- **Frontend**: EC2 instances serving the application frontend

## Prerequisites

- AWS Account with appropriate permissions
- Terraform v1.0+ installed
- AWS CLI configured with credentials
- Git

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/mng-g/demo-terraform-aws-ec2-lambda-s3-rds.git
   cd demo-terraform-aws-ec2-lambda-s3-rds
   ```

2. Initialize Terraform in each module directory:
   ```bash
   cd network-security && terraform init
   cd ../s3-rds && terraform init
   cd ../api-lambda && terraform init
   cd ../frontend-ec2 && terraform init
   cd ../..
   ```

3. **Using Workspaces (Future Enhancement)**
   
   For future multi-environment support (dev/test/prod), this project will implement Terraform workspaces. This will allow managing multiple environments with the same configuration while maintaining separate state files.

   ```bash
   # Example of how workspaces will be used in future versions:
   
   # List available workspaces
   terraform workspace list
   
   # Create a new workspace for dev environment
   terraform workspace new dev
   
   # Select the workspace
   terraform workspace select dev
   
   # When applying changes, the workspace name will be used to manage environment-specific resources
   terraform apply -var-file="dev.tfvars"
   ```
   
   Note: Currently, the project uses direct variable files for environment management. Workspace support will be added in a future update.

## Deployment Order

Deploy the infrastructure in the following order:

1. **Network & Security**
   ```bash
   cd modules/network-security
   terraform plan
   terraform apply -var-file="dev.tfvars" -var 'prefix=demo-terraform-aws-ec2-lambda-s3-rds'
   ```

2. **S3 & RDS**
   ```bash
   cd ../s3-rds
   terraform plan
   terraform apply -var-file="dev.tfvars" -var 'prefix=demo-terraform-aws-ec2-lambda-s3-rds'
   ```

3. **AI Lambda Functions**
   ```bash
   cd ../ai-lambda
   terraform plan
   terraform apply -var-file="dev.tfvars" -var 'prefix=demo-terraform-aws-ec2-lambda-s3-rds'
   ```

4. **Frontend EC2 Instances**
   ```bash
   cd ../frontend-ec2
   terraform plan
   terraform apply -var-file="dev.tfvars" -var 'prefix=demo-terraform-aws-ec2-lambda-s3-rds'
   ```

## Variables

Each module contains a `variables.tf` file where you can customize the deployment. Common variables to configure include:
- AWS region
- Instance types
- Database configurations
- Environment tags

## Clean Up

To destroy all resources, run `terraform destroy` in reverse order:

1. `frontend-ec2`
2. `ai-lambda`
3. `s3-rds`
4. `network-security`

## Security Considerations

- Ensure proper IAM roles and policies are in place
- Use secure methods for handling secrets (AWS Secrets Manager or Parameter Store)
- Enable encryption at rest and in transit
- Follow the principle of least privilege