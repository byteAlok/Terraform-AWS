# 🚀 Terraform with AWS 
 
![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/Amazon_AWS-Cloud-FF9900?logo=amazonaws&logoColor=white)
![HCL](https://img.shields.io/badge/Language-HCL-blue)
![Status](https://img.shields.io/badge/Learning-In_Progress-blue)

A hands-on learning repository dedicated to **Terraform and Infrastructure as Code (IaC) on Amazon Web Services (AWS)**. This repository contains notes, configuration files, essential commands, and practical examples for provisioning and managing AWS infrastructure using Terraform.

## 📌 About This Repository

The goal of this repository is to understand how Terraform automates cloud infrastructure management on AWS using declarative configuration files written in HashiCorp Configuration Language (HCL).

Topics and practical exercises will be added progressively as I learn and practice Terraform.

## 🎯 Learning Objectives

- 🚀 Understand Infrastructure as Code (IaC) concepts.
- 🧩 Learn HCL syntax and Terraform configuration.
- ⚙️ Work with Terraform providers, resources, and data sources.
- 🔄 Understand the Terraform workflow: Init, Plan, Apply, and Destroy.
- ☁️ Provision and manage AWS resources using Terraform.
- 🔐 Learn secure AWS authentication and credential management.
- 📦 Manage Terraform state and reusable configurations.
- 🛠️ Practice infrastructure automation through hands-on exercises.

## 🧰 Tech Stack

| Technology | Purpose |
|---|---|
| Terraform | Infrastructure provisioning and automation |
| Amazon Web Services (AWS) | Cloud infrastructure provider |
| HCL | Terraform configuration language |
| AWS CLI | AWS command-line interaction |
| Git & GitHub | Version control and project documentation |
| Visual Studio Code | Code editor |

## 📚 Topics Covered

### 1. Terraform Fundamentals
- Introduction to Terraform and IaC
- Terraform architecture and workflow
- Installation and setup
- HCL syntax and configuration blocks
- Providers, resources, and data sources
- Input variables and output values
- Local values and expressions

### 2. Essential Terraform Commands
- `terraform -version` — Check the installed version
- `terraform init` — Initialize the working directory
- `terraform fmt` — Format configuration files
- `terraform validate` — Validate configuration syntax
- `terraform plan` — Preview infrastructure changes
- `terraform apply` — Apply configuration changes
- `terraform destroy` — Destroy managed infrastructure
- `terraform state list` — List resources tracked in state

### 3. Terraform with AWS
- Configure the AWS provider
- Set up AWS credentials securely
- Create and manage AWS resources
- Configure AWS regions
- Work with resource dependencies
- Reference existing AWS resources
- Review infrastructure changes before deployment

### 4. AWS Infrastructure Practice

Practical exercises may include:

- ☁️ Amazon EC2 — Virtual servers
- 🪣 Amazon S3 — Object storage
- 🌐 Amazon VPC — Virtual private networking
- 🔒 Security Groups — Instance traffic control
- 🔑 IAM — Identity and access management
- ⚖️ Elastic Load Balancing — Traffic distribution

*These are planned learning areas; resources will be added as the exercises are completed.*

### 5. State Management & Reusability
- Terraform state fundamentals
- Local and remote state
- AWS S3-based remote state storage
- State locking and concurrent operations
- Variables, outputs, and reusable modules
- Environment-specific configurations

## 📂 Repository Structure

```text
Terraform-AWS/
│
├── README.md
├── basics/
│   ├── provider.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── ec2/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── s3/
│   └── main.tf
│
├── vpc/
│   └── main.tf
│
└── modules/
```

*This is a suggested structure. Directories and files will be created as the repository grows.*

## ⚙️ Getting Started

### Prerequisites

Install the following tools before starting:

- [Terraform CLI](https://developer.hashicorp.com/terraform/install)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [AWS Account](https://aws.amazon.com/)
- [Visual Studio Code](https://code.visualstudio.com/)

### Step 1: Configure AWS Credentials

Configure the AWS CLI using an appropriate IAM identity:

```bash
aws configure
```

Verify your AWS identity:

```bash
aws sts get-caller-identity
```

Use IAM roles or temporary credentials when appropriate. Never commit AWS access keys or secret keys to GitHub.

### Step 2: Create a Terraform Configuration

Create a file named `main.tf`:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket_prefix = "terraform-learning-"
}
```

This example configures the AWS provider and defines an S3 bucket with a generated unique suffix. Choose a provider version compatible with your installed Terraform version and project requirements.

### Step 3: Initialize Terraform

```bash
terraform init
```

### Step 4: Validate the Configuration

```bash
terraform fmt
terraform validate
```

### Step 5: Preview and Apply Changes

```bash
terraform plan
terraform apply
```

Review the plan before approving the changes. AWS resources may incur charges.

### Step 6: Clean Up Resources

When you no longer need the resources created by this configuration:

```bash
terraform destroy
```

Review the destruction plan carefully before confirming.

## 🔐 Security Best Practices

- Never upload AWS access keys, secret keys, or session tokens.
- Add sensitive files such as `.env` and local credentials to `.gitignore`.
- Never commit `terraform.tfstate` or `terraform.tfstate.backup` if they contain sensitive information.
- Treat Terraform plan files as potentially sensitive.
- Use least-privilege IAM permissions.
- Review every plan before applying or destroying infrastructure.
- Configure remote state storage and locking securely when required.
- Check AWS resources for ongoing costs and clean up unused resources.

## 🗓️ Learning Progress

- [x] Create the Terraform-AWS repository
- [ ] Terraform installation and configuration
- [ ] HCL fundamentals
- [ ] Essential Terraform commands
- [ ] AWS provider configuration
- [ ] EC2 and S3 provisioning
- [ ] VPC and networking
- [ ] Variables and outputs
- [ ] State management
- [ ] Reusable modules
- [ ] Advanced Terraform practices

*Progress will be updated as each topic is completed.*

## 🌐 Related Repositories

- ☁️ **Terraform-AWS** — Terraform and Amazon Web Services
- 🔷 **Terraform-Azure** — Terraform and Microsoft Azure
- 🌎 **Terraform-GCP** — Terraform and Google Cloud Platform

Each repository will maintain provider-specific configurations, examples, and learning notes.

## 👨‍💻 Author

**Alok Maurya**  
Full Stack Engineer | Cloud & DevOps Learner

- GitHub: [@byteAlok](https://github.com/byteAlok)

---

⭐ If you find this repository useful, consider giving it a star.

**Learning by building. Automating infrastructure with Terraform.**
