# 🌐 Custom Network Creation on AWS using Terraform

> **Hands-on Infrastructure as Code (IaC) | AWS Networking | Terraform**

This project demonstrates how to create a custom AWS network infrastructure using **Terraform**, covering VPC, public and private subnets, Internet Gateway, NAT Gateway, route tables, security groups, and EC2 instances.

The primary objective is to understand how AWS networking components interact with each other and how Terraform provisions and manages these resources.

## 🎯 Project Objectives

- 🌐 Create a custom Amazon VPC.
- 🧩 Configure public and private subnets across two Availability Zones.
- 🌍 Attach an Internet Gateway for internet connectivity.
- 🔄 Configure a NAT Gateway for outbound internet access from the private subnet.
- 🛣️ Create public and private route tables with subnet associations.
- 🔐 Implement security group ingress and egress rules using two different approaches.
- 🖥️ Launch EC2 instances in public and private subnets.
- ⚙️ Understand Terraform resource references and dependency management.

## 🏗️ Architecture Overview

The infrastructure consists of the following components:

| Component | Configuration | Purpose |
|---|---|---|
| VPC | `10.0.0.0/16` | Provides an isolated virtual network |
| Public Subnet | `10.0.1.0/24` | Hosts the public EC2 instance and NAT Gateway |
| Private Subnet | `10.0.2.0/24` | Hosts the private EC2 instance |
| Internet Gateway | Attached to the VPC | Enables internet routing for public resources |
| Elastic IP | Associated with NAT Gateway | Provides a static public IP for NAT |
| NAT Gateway | Located in the public subnet | Allows private resources to initiate outbound internet connections |
| Public Route Table | Default route to Internet Gateway | Routes internet-bound traffic through the IGW |
| Private Route Table | Default route to NAT Gateway | Routes internet-bound traffic through the NAT Gateway |
| Security Groups | EC2 and ALB configurations | Control inbound and outbound traffic |
| EC2 Instances | `t2.micro` | Demonstrate compute resources in both subnets |

### 🔀 Network Traffic Flow

**Public subnet:**

`EC2 → Public Route Table → Internet Gateway → Internet`

**Private subnet — outbound internet access:**

`Private EC2 → Private Route Table → NAT Gateway → Internet Gateway → Internet`

The NAT Gateway allows instances in the private subnet to initiate outbound connections. It does not automatically make those instances publicly accessible from the internet.

## 🔐 Security Groups: Two Implementation Methods

This project demonstrates two approaches to defining security group rules in Terraform.

### Method 1: Separate Ingress and Egress Resources

The EC2 security group uses standalone rule resources:

- `aws_security_group`
- `aws_vpc_security_group_ingress_rule`
- `aws_vpc_security_group_egress_rule`

**Inbound rules configured:**

| Protocol | Port | Source | Purpose |
|---|---:|---|---|
| TCP | 80 | `0.0.0.0/0` | HTTP traffic |
| TCP | 443 | `0.0.0.0/0` | HTTPS traffic |
| TCP | 22 | `0.0.0.0/0` | SSH access |

**Outbound rule:** All protocols and ports are allowed to `0.0.0.0/0`.

**Why use this method?**

- Keeps security group creation separate from rule definitions.
- Makes individual rules easier to manage independently.
- Supports clearer resource-level organization in larger Terraform configurations.

### Method 2: Inline Ingress and Egress Blocks

The ALB security group defines rules directly inside the `aws_security_group` resource using:

- `ingress {}` for inbound traffic.
- `egress {}` for outbound traffic.

**Inbound rules:** HTTP on port 80 and HTTPS on port 443, both from `0.0.0.0/0`.

**Outbound rule:** All protocols and ports are allowed to `0.0.0.0/0`.

**Why use this method?**

- Keeps the security group and its rules together in one resource.
- Makes small configurations easier to read.
- Provides a compact way to demonstrate basic networking concepts.

### ⚖️ Key Difference

| Aspect | Method 1 | Method 2 |
|---|---|---|
| Rule definition | Separate Terraform resources | Inline blocks |
| Organization | Rules managed individually | Rules grouped inside the security group |
| Best learning use | Understanding resource-level configuration | Understanding nested resource blocks |
| Important consideration | Avoid conflicting duplicate rule management | Avoid mixing inline rules with separate rule resources for the same security group |

**Note:** These are alternative configuration styles. They should not be combined indiscriminately for the same security group because conflicting rule management can lead to Terraform drift or unexpected changes.

Also, the current SSH rule allows access from anywhere. For production deployments, restrict SSH access to a trusted IP range or use AWS Systems Manager Session Manager where appropriate.

## 🖥️ EC2 Instance Placement

Two EC2 instances are configured:

- **Public EC2:** Deployed in the public subnet in `us-west-2a`.
- **Private EC2:** Deployed in the private subnet in `us-west-2b`.

Both instances reference the same EC2 security group in this learning configuration.

**Important:** A public subnet does not automatically assign a public IPv4 address to an EC2 instance. Public reachability also depends on public IP assignment, routing, security groups, network ACLs, and the instance's operating system configuration.

Similarly, the private instance is not automatically reachable through the NAT Gateway. A NAT Gateway provides outbound connectivity, not inbound connectivity initiated from the internet.

## 🧠 Why Variables Are Not Used Here

This configuration intentionally uses direct values for settings such as CIDR blocks, Availability Zones, instance types, and resource names.

The focus of this exercise is **understanding AWS network architecture and successfully provisioning the resources**, rather than demonstrating Terraform variable management.

Using direct values keeps the configuration straightforward for beginners and makes the relationships between resources easier to follow.

For a separate example covering variables, `terraform.tfvars`, input validation, and configuration files, refer to:

🔗 [Terraform AWS — Day 2: All Configuration Files](https://github.com/byteAlok/Terraform-AWS/tree/main/day-2-all-configuration-file)
🔗 [Terraform AWS — Day 4: State Backend Remote Location (AWS S3)](https://github.com/byteAlok/Terraform-AWS/tree/main/day-4-state-backend-remote-location)

In real-world projects, reusable variables, environment-specific configuration, and appropriate validation are recommended.

## 📁 Terraform State File — Learning Context

The `.tfstate` file is currently retained in this repository **strictly for the context of this personal learning exercise**.

The purpose is to document and understand Terraform's state management while practising AWS infrastructure provisioning.

This is a controlled, temporary learning environment. The associated Pluralsight sandbox automatically deletes its resources after approximately four hours, according to the sandbox setup used for this exercise.

That temporary environment is part of the learning workflow, not a recommended state-management strategy for production infrastructure.

### 🔒 Important State File Considerations

Terraform state can contain sensitive information, resource identifiers, and configuration data. Therefore:

- Do not commit production state files to a public GitHub repository.
- Use a secure remote backend, such as Amazon S3 with appropriate access controls, encryption, and state locking where supported by the chosen configuration.
- Never commit credentials, access keys, private keys, or other secrets.
- For team environments, establish proper state access, locking, recovery, and versioning practices.

**Scope clarification:** Keeping the state file here is a deliberate learning-context choice, not a recommendation for professional or production deployments.

## ⚙️ Terraform Workflow

The standard workflow for this exercise is:

```bash
# Initialize the working directory
terraform init

# Validate the configuration
terraform validate

# Review the planned infrastructure changes
terraform plan

# Create the AWS resources
terraform apply

# Inspect Terraform-managed resources
terraform state list

# Destroy the resources when finished
terraform destroy
```

Ensure that your AWS credentials and selected region are configured correctly before applying the configuration.

The AMI ID must also be valid for the selected AWS region and compatible with the chosen instance configuration.

## 🚀 Learning vs. Production Readiness

This repository focuses on networking concepts and hands-on learning. It is not intended to represent a complete production-ready AWS architecture.

Production deployments would require additional design decisions, including:

- 🔐 Least-privilege security group rules and controlled administrative access.
- 🔑 Secure credential and secret management.
- 🗄️ Secure Terraform state storage and team collaboration practices.
- 🌍 Public IP assignment and connectivity settings appropriate to each workload.
- 🛡️ High availability, monitoring, logging, and backup or recovery planning.
- 💰 Cost controls for NAT Gateways, Elastic IPs, and other billable resources.
- 🧩 Reusable modules, variables, and environment-specific configuration.
- 🧪 Testing and validation of the complete deployment.

The current configuration is a foundation for learning these concepts and can be enhanced incrementally as more Terraform and AWS networking topics are covered.

## 📚 Key Takeaways

By completing this exercise, you can understand:

- How Terraform provisions AWS networking resources.
- How VPCs and subnets organize cloud infrastructure.
- How Internet Gateways and NAT Gateways serve different networking purposes.
- How route tables determine network traffic paths.
- How security group rules control inbound and outbound traffic.
- How separate Terraform rule resources differ from inline ingress and egress blocks.
- Why Terraform variables, state management, and security practices matter in production environments.

## 👨‍💻 Author

**Alok Maurya | AlokSDE — Personal Brand & Portfolio**

Full Stack Engineer | Cloud & DevOps Learner

- 🌐 Portfolio: [aloksde.com](https://aloksde.com/)
- 💻 GitHub: [@byteAlok](https://github.com/byteAlok)
- 📦 Terraform AWS Learning Repository: [Terraform-AWS](https://github.com/byteAlok/Terraform-AWS)

---

⭐ If this repository helps you understand AWS networking with Terraform, consider starring it and exploring the other hands-on cloud infrastructure examples.

**Learning by building. Improving by iterating.**
