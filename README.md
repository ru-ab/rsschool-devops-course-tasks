# Task 1: AWS Account Configuration

In this Terraform project, an S3 bucket is created for the Terraform state, and a role named **GithubActionsRole** is established with the following policies:

- AmazonEC2FullAccess
- AmazonRoute53FullAccess
- AmazonS3FullAccess
- IAMFullAccess
- AmazonVPCFullAccess
- AmazonSQSFullAccess
- AmazonEventBridgeFullAccess

Additionally, an OpenID Connect provider is configured for GitHub Actions.

## Project file structure

### provider.tf

This file configures the AWS provider in Terraform, setting the region based on the value of the region variable.

### state.tf

This file sets up remote state storage in an S3 bucket and creates an S3 bucket resource with specific tags for tracking the state.

### iam.tf

This file creates an IAM role for GitHub Actions with multiple permissions (EC2, Route53, S3, IAM, VPC, SQS, and EventBridge). It sets up an OpenID Connect provider to allow GitHub Actions to assume the role using web identity federation. The policy defines specific conditions for which repositories and actions can authenticate and assume this role.

### vars.tf

This file defines a variable for specifying the AWS region.

### .terraform.lock.hcl

This file is used in Terraform to manage provider dependencies and ensure consistent versions across different runs of your Terraform configuration.

### .github/workflows/deploy.yml

This file contains GitHub Actions to automate deployment after a commit or pull request to the main branch.

### .gitignore

Defines the files that will be ignored by Git.

### README.MD

This file.

## How to run

Follow these steps to set up and deploy this project:

### 1. Install Terraform (if not already installed)

Download and install Terraform from the official Terraform website.
Verify the installation by running:

```bash
terraform -v
```

### 2. This command downloads the necessary providers and sets up your backend configuration

```bash
terraform init
```

### 3. Preview the Changes

Run this command to see what changes Terraform will make to your infrastructure. It generates an execution plan.

```bash
terraform plan
```

### 4. Apply the Changes

Once you've reviewed the plan, apply the changes to provision or update your infrastructure. Terraform will ask for confirmation before proceeding.

```bash
terraform apply
```
