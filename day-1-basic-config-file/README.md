# 🚀 Day 1 – Terraform Basic Configuration File

## 📌 Overview

This practical demonstrates how to configure Terraform and the AWS Provider to provision AWS infrastructure using Infrastructure as Code (IaC).

In this practical, I configured Terraform version requirements, AWS provider settings, and created an AWS VPC using Terraform.

## 📂 Project Structure

```text
day-1-basic-config-file/
├── 📄 main.tf
└── 📄 providers.tf
```

## 🛠️ Practical Implementation

### 1. 📄 main.tf – Infrastructure Configuration

The `main.tf` file contains the AWS infrastructure resource definitions.

**Implemented:**

- ☁️ Created an AWS VPC using the `aws_vpc` resource.
- 🌐 Configured the VPC CIDR block as `10.0.0.0/24`.
- 🏷️ Added a Name tag (`dev-vpc-alok-2`) to identify the VPC.

**Resource Configuration:**

| Argument | Value | Description |
|---|---|---|
| `resource` | `aws_vpc` | AWS VPC resource |
| `cidr_block` | `10.0.0.0/24` | VPC IPv4 address range |
| `Name` | `dev-vpc-alok-2` | VPC identification tag |

### 2. ⚙️ providers.tf – Terraform & Provider Configuration

The `providers.tf` file defines Terraform version requirements and AWS provider configuration.

**Implemented:**

- 🔢 Specified minimum Terraform CLI version as `1.0.0`.
- 📦 Configured AWS provider using `hashicorp/aws`.
- 🔄 Set AWS provider version constraint to `~> 6.0`.
- 🌎 Configured AWS region as `us-east-1`.

**Configuration Breakdown:**

| Configuration | Value | Purpose |
|---|---|---|
| `required_version` | `>= 1.0.0` | Minimum Terraform version |
| `source` | `hashicorp/aws` | AWS provider source |
| `version` | `~> 6.0` | Provider version constraint |
| `region` | `us-east-1` | AWS deployment region |

## 🔄 3. Terraform Execution Workflow

```text
       📄 Terraform Files
                │
                ▼
         🔧 terraform init
                │
                ▼
       📦 Download AWS Provider
                │
                ▼
       ✅ terraform validate
                │
                ▼
          📋 terraform plan
                │
                ▼
          🚀 terraform apply
                │
                ▼
         ☁️ AWS VPC Created
          (10.0.0.0/24)
```

## 💻 4. Terraform Commands

```bash
# 🔧 Initialize Terraform
terraform init

# ✅ Validate configuration
terraform validate

# 📋 Preview infrastructure changes
terraform plan

# 🚀 Create AWS infrastructure
terraform apply

# 🗑️ Destroy created infrastructure
terraform destroy
```

## 🧠 5. Important Concepts Learned

- 🏗️ Infrastructure as Code (IaC).
- ⚙️ Terraform configuration file structure.
- 📦 Terraform required providers.
- 🔢 Terraform CLI version constraints.
- 🔄 AWS provider version constraints.
- 🌎 AWS region configuration.
- ☁️ AWS VPC provisioning.
- 🏷️ Resource tagging.

## 🎯 6. Learning Outcomes

After completing this practical, I learned how to:

- Organize Terraform configuration files.
- Configure Terraform CLI and AWS provider requirements.
- Connect Terraform with AWS using the AWS provider.
- Define AWS infrastructure using Terraform resources.
- Provision a VPC with a custom CIDR block.
- Execute the Terraform initialization, validation, planning, and deployment workflow.

---

## 👨‍💻 Author

**Alok Maurya**

Cloud & DevOps Learner 🚀

---

⭐ If you found this project helpful, consider giving the repository a star!
