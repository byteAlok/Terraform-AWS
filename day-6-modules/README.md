# 🚀 Day 6: Terraform Modules

<p align="center">
  <img src="https://img.shields.io/badge/Terraform-Learning-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform"/>
  <img src="https://img.shields.io/badge/AWS-Cloud-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white" alt="AWS"/>
  <img src="https://img.shields.io/badge/EC2-Compute-ED7100?style=for-the-badge&logo=amazonec2&logoColor=white" alt="EC2"/>
  <img src="https://img.shields.io/badge/S3-Storage-569A31?style=for-the-badge&logo=amazons3&logoColor=white" alt="S3"/>
</p>

## 📖 About This Project

Today, I started learning **Terraform Modules** and how they help organize Terraform code into separate, reusable components.

Instead of writing everything in a single directory, I created two modules:

- 🖥️ **Compute Module** — to create an AWS EC2 instance.
- 🪣 **Storage Module** — to create an AWS S3 bucket.

For now, I am focusing on creating the modules and understanding how they work. I will create another configuration later to call these modules.

This is a learning project, so the main goal is to understand the concepts by writing and experimenting with code. 💻

---

## 🛠️ Technologies Used

- 🟣 Terraform
- ☁️ Amazon Web Services (AWS)
- 🖥️ Amazon EC2
- 🪣 Amazon S3
- 📝 HCL (HashiCorp Configuration Language)

---

## 📂 Project Structure

```text
day-6-modules/
│
├── 📁 compute/
│   ├── main.tf
│   ├── output.tf
│   └── variable.tf
│
├── 📁 storage/
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   └── variable.tf
│
├── provider.tf
├── variable.tf
└── README.md
```

---

## 🖥️ 1. Compute Module

📁 **Directory:** `compute/`

In this module, I created an EC2 instance using the `aws_instance` resource.

### What I learned

- ⚙️ How to use variables for the AMI ID and instance type.
- 🏷️ How to assign a Name tag to an EC2 instance.
- 📤 How to retrieve resource information using outputs.
- 📦 How to collect multiple resource attributes in a single output.

### 📥 Variables

| Variable | Description |
|---|---|
| `ami` | AMI ID for the EC2 instance |
| `instance-type` | Type of EC2 instance |
| `name` | Name tag of the instance |

### 📤 Outputs

| Output | Description |
|---|---|
| `ec2-id` | EC2 instance ID |
| `ec2-ami` | AMI ID |
| `ec2-instance-type` | Instance type |
| `ec2-name` | Instance Name tag |
| `ec2-details` | Important EC2 details in one output |

💡 **My learning:** Variables help me customize the EC2 configuration, while outputs help me retrieve the information I need after creating the resource.

---

## 🪣 2. Storage Module

📁 **Directory:** `storage/`

In this module, I created an S3 bucket using the `aws_s3_bucket` resource.

I also explored how to configure a separate AWS provider for the S3 bucket's region.

### What I learned

- 🪣 How to define an S3 bucket resource.
- 📥 How to use variables for the bucket name, region, and tag.
- 📤 How to retrieve S3 bucket details using outputs.
- 🌍 How AWS provider aliases work.
- 🔀 How a provider alias can be used to select a different AWS region.

### 📥 Variables

| Variable | Description |
|---|---|
| `s3-bucket-name` | Name of the S3 bucket |
| `s3-region` | AWS region for the bucket |
| `s3-tag-name` | Name tag for the bucket |

### 📤 Outputs

| Output | Description |
|---|---|
| `s3-bucket-id` | S3 bucket ID |
| `s3-bucket-name` | S3 bucket name |
| `s3-bucket-region` | Region of the bucket |
| `s3-bucket-tag-name` | Bucket Name tag |
| `s3-details` | Important S3 details in one output |

### 🌍 Provider Alias

In `storage/provider.tf`, I configured a secondary AWS provider:

```hcl
provider "aws" {
  alias  = "s3-region-name"
  region = var.s3-region
}
```

Then, I used that provider in the S3 resource:

```hcl
provider = aws.s3-region-name
```

💡 **My learning:** A provider alias lets me work with different AWS provider configurations. Here, I am using it to learn how to configure the S3 bucket's region separately from the default AWS region.

---

## ⚙️ 3. Root Configuration

The root directory contains the default AWS provider configuration and a variable for the AWS region.

### `provider.tf`

```hcl
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws-region
}
```

### `variable.tf`

```hcl
variable "aws-region" {
  description = "This variable for assigned specific region as per your choice"
  default     = "us-east-1"
  type        = string
}
```

💡 **My learning:** Instead of hardcoding the AWS region directly into the provider configuration, I can manage it through a variable.

---

## 📤 4. Understanding Terraform Outputs

I created separate outputs for individual resource attributes and one additional output to collect important details together.

For example:

```hcl
output "ec2-id" {
  description = "EC2 ID"
  value       = aws_instance.ec2-public.id
}
```

I also created an output called `ec2-details` that contains the instance ID, AMI, instance type, and Name tag.

This helps me understand how Terraform outputs can make resource information easier to access.

---

## 🧠 What I Learned Today

Here are the main concepts I practiced in this project:

- 📁 Organizing Terraform code into separate directories.
- 🧩 Creating Compute and Storage modules.
- 📥 Using input variables to configure resources.
- 📤 Exporting resource information through outputs.
- 🖥️ Understanding the `aws_instance` resource.
- 🪣 Understanding the `aws_s3_bucket` resource.
- 🌍 Exploring AWS provider aliases.
- 🔗 Preparing modules that I can call from another Terraform configuration.

---

## ⏭️ What's Next?

This is just the beginning of my Terraform modules practice.

In the next step, I plan to:

- 🔗 Create a root configuration to call these modules.
- 📥 Pass variables to the modules.
- 📤 Access module outputs from the root configuration.
- 🌍 Practice passing provider configurations to modules.
- 🧪 Run Terraform commands and observe how everything works.

---

## 👨‍💻 My Learning Journey

I am learning Terraform step by step by writing code, trying new concepts, and understanding how things work in practice.

This project is part of my hands-on learning journey with **Terraform and AWS**. 🚀

> 💡 Learn by doing. Make mistakes, understand them, and keep building! 🔥

---
<p align="center">
  ⭐ <b>One step closer to mastering Terraform!</b> ☁️
</p>