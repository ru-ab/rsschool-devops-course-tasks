# Task 2: Basic Infrastructure Configuration

In this Terraform project, an AWS VPC is created, consisting of:

- 2 public subnets in different availability zones
- 2 private subnets in different availability zones
- An Internet Gateway for internet access
- A Bastion host for secure access to instances in the private subnets
- A NAT Gateway for internet access for private instances
- Security groups and ACLs

## Project file structure

### provider.tf

This file configures the AWS provider in Terraform, setting the region based on the value of the region variable.

### state.tf

This file sets up remote state storage in an S3 bucket.

### vars.tf

This file defines variables.

### vpc.tf

This file creates a VPC with both public and private subnets, each distributed across different availability zones. It sets up an Internet Gateway for the public subnets, allowing them to access the internet. Public subnets automatically assign public IPs to instances. For the private subnets, it configures a NAT Gateway in the public subnets, enabling outbound internet access for instances without exposing them to direct internet traffic. Route tables are associated with both public and private subnets, ensuring proper traffic routing.

### security-groups.tf

This file defines three AWS security groups for managing network traffic:

- **allow_ping**: Allows incoming ICMP (ping) traffic from any IP (0.0.0.0/0) to enable pinging of instances in the VPC.
- **allow_ssh**: Allows incoming SSH (port 22) connections from any IP, providing SSH access to instances.
- **allow_outbound**: Allows all outbound traffic from instances, using an egress rule that permits any protocol to any destination.

### acl.tf

This file defines an AWS Network ACL with rules to control inbound and outbound traffic for a VPC:

- Ingress rules (incoming traffic):
  - Rule 100: Allows ICMP echo requests (type 8) from any IP (used for ping).
  - Rule 110: Allows ICMP echo replies (type 0) from any IP (ping responses).
  - Rule 200: Allows incoming SSH (TCP on port 22) from any IP.
  - Rule 300: Allows incoming traffic on dynamic ports (TCP 1024-65535) from any IP.
- Egress rule (outgoing traffic):
  - Rule 100: Allows all outgoing traffic (any protocol, port, and IP).

### bastion.tf

This file creates an EC2 Bastion Host using an Auto Scaling Group and a Launch Template. The Auto Scaling Group ensures a single bastion host is always running in public subnets, maintaining fixed capacity.

### ec2.tf

This file creates two sets of EC2 instances: public and private for testing purposes.

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
