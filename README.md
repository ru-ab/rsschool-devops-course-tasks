# Task 3: K8s Cluster Configuration and Creation

In this Terraform project, an AWS VPC is created, consisting of:

- 1 public subnet
- 1 private subnet
- An Internet Gateway for internet access
- A Bastion host for secure access to instances in the private subnet
- A NAT Gateway for internet access for private instances
- Security groups
- 2 EC2 Instances for k3s cluster

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

## Setup Kubernetes Cluster using k3s

1. Create k3s cluster on the control plane node:

```bash
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
```

2. Get **K3S_TOKEN** from the control plane node:

```bash
cat /var/lib/rancher/k3s/server/node-token
```

3. Connect the worker node to the control plane node:

```bash
curl -sfL https://get.k3s.io | K3S_URL=https://<control-plane-node-ip>:6443 K3S_TOKEN=<control-plane-node-token> sh -
```

## Forward kubectl through the bastion host

Run the command locally to connect the **kubectl** command to the k3s cluster:

```bash
ssh -f ubuntu@<bastion-host-ip> -L 6443:<control-plane-node-ip>:6443 -N
```

## Project file structure

### provider.tf

This file configures the AWS provider in Terraform, setting the region based on the value of the region variable.

### state.tf

This file sets up remote state storage in an S3 bucket.

### vars.tf

This file defines variables.

### vpc.tf

This file configures a VPC setup with public and private subnets. It creates an internet gateway for public access and assigns route tables to manage traffic. NAT gateways are deployed in public subnet to allow private instances to access the internet. Elastic IPs are allocated for the NAT gateway, and route tables are associated with the respective subnets.

### security-groups.tf

This file defines two AWS security groups. The first group "task_3_host_sg" allows incoming ICMP traffic, SSH (port 22), HTTP (port 80), HTTPS (port 443), and Kubernetes API (port 6443) from any source, with all outbound traffic allowed. The second group "task_3_bastion_sg" permits SSH access and allows all outbound traffic.

### bastion.tf

This file creates an EC2 Bastion Host.

### ec2.tf

This file creates two EC2 instances: for kubernetes control plane and worker.

### ami.tf

This file retrieves the most recent Amazon Machine Image (AMI) for Ubuntu 22.

### .terraform.lock.hcl

This file is used in Terraform to manage provider dependencies and ensure consistent versions across different runs of your Terraform configuration.

### .gitignore

Defines the files that will be ignored by Git.

### README.MD

This file.
