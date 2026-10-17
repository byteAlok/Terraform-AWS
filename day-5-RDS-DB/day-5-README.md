# ☁️ AWS VPC & RDS MySQL with Terraform

🚀 **A beginner-friendly Infrastructure as Code (IaC) project** to provision AWS networking resources, a MySQL RDS primary database, and a read replica using Terraform.

## 📌 Project Overview

This project uses Terraform to create an AWS infrastructure consisting of a custom VPC, two subnets across different Availability Zones, an Internet Gateway, a Route Table, a Security Group, and MySQL RDS database instances.

The primary database is configured with a MySQL read replica to support read scaling.

## 🏗️ Architecture

```text
                     🌐 AWS Cloud
                          |
                    🏢 Custom VPC
                    10.0.0.0/16
                          |
              ┌───────────┴───────────┐
              |                       |
       📦 Subnet 1              📦 Subnet 2
       10.0.0.0/24              10.0.1.0/24
       us-west-2b               us-west-2c
              |                       |
              └───────────┬───────────┘
                          |
                 🗄️ DB Subnet Group
                          |
                   🐬 MySQL RDS
                          |
                 🪞 Read Replica
```

> **Note:** The diagram represents the logical database networking layout. The Internet Gateway and Route Table are also created, but the database instances are not automatically made publicly accessible.

## 🛠️ Technologies Used

- ☁️ **Amazon Web Services (AWS)** — Cloud infrastructure
- 🏗️ **Terraform** — Infrastructure as Code (IaC)
- 🗄️ **Amazon RDS** — Managed relational database service
- 🐬 **MySQL 8.0** — Relational database engine
- 🌐 **Amazon VPC** — Isolated virtual network
- 🔐 **Security Groups** — Network traffic control

## 📦 AWS Resources Created

| Resource | Terraform Resource | Description |
|---|---|---|
| 🌐 VPC | `aws_vpc` | Creates a custom VPC with CIDR `10.0.0.0/16`. |
| 📦 Subnet 1 | `aws_subnet` | Creates a subnet in `us-west-2b`. |
| 📦 Subnet 2 | `aws_subnet` | Creates a subnet in `us-west-2c`. |
| 🗂️ DB Subnet Group | `aws_db_subnet_group` | Groups both subnets for RDS networking. |
| 🌍 Internet Gateway | `aws_internet_gateway` | Provides an internet gateway for the VPC. |
| 🛣️ Route Table | `aws_route_table` | Defines a default route to the Internet Gateway. |
| 🔗 Route Associations | `aws_route_table_association` | Associates the route table with both subnets. |
| 🔐 Security Group | `aws_security_group` | Defines inbound and outbound network rules. |
| 🗄️ Primary Database | `aws_db_instance` | Creates a MySQL RDS primary instance. |
| 🪞 Read Replica | `aws_db_instance` | Creates a replica of the primary database. |

## 🌐 Networking Configuration

### 1. VPC

The project creates a custom Virtual Private Cloud with the following configuration:

- **VPC CIDR:** `10.0.0.0/16`
- **DNS Support:** Enabled
- **DNS Hostnames:** Enabled

A VPC provides an isolated virtual network for AWS resources.

### 2. Subnets

Two subnets are created in separate Availability Zones:

| Subnet | CIDR Block | Availability Zone |
|---|---|---|
| Subnet 1 | `10.0.0.0/24` | `us-west-2b` |
| Subnet 2 | `10.0.1.0/24` | `us-west-2c` |

Using multiple Availability Zones helps provide network placement options for database deployments.

### 3. Internet Gateway & Route Table

An Internet Gateway is attached to the VPC.

A route table contains the following default route:

```text
Destination: 0.0.0.0/0
Target:      Internet Gateway
```

Both subnets are associated with this route table.

⚠️ **Important:** An Internet Gateway route alone does not make a resource publicly accessible. Public IP configuration and appropriate security rules are also required. For production database deployments, private database subnets are generally recommended.

## 🔐 Security Group Configuration

The project creates a Security Group with the following inbound rules:

| Protocol | Port | Source | Purpose |
|---|---:|---|---|
| SSH | 22 | `0.0.0.0/0` | Remote server access |
| HTTP | 80 | `0.0.0.0/0` | Web traffic |
| MySQL | 3306 | `0.0.0.0/0` | Database connections |

Outbound traffic is allowed to all destinations.

⚠️ **Security Warning:**

The current configuration allows SSH and MySQL traffic from any IPv4 address.

For better security:

- 🔒 Restrict SSH access to your trusted IP address.
- 🔒 Allow MySQL access only from the application server's Security Group.
- 🔒 Avoid exposing database ports directly to the internet.
- 🔒 Use least-privilege network access rules.

## 🗄️ Amazon RDS Configuration

### Primary Database

The primary database uses the following settings:

| Property | Value |
|---|---|
| Database Engine | MySQL |
| Engine Version | 8.0 |
| Instance Class | `db.t3.micro` |
| Allocated Storage | 25 GiB |
| Identifier | `my-db-instance` |
| Backup Retention | 7 days |
| Maintenance Window | Friday, 04:00–05:00 UTC |
| Public Accessibility | AWS default; not explicitly configured |

The primary instance stores the main database and acts as the replication source.

### Read Replica

The read replica is configured with:

- **Identifier:** `my-db-replica`
- **Instance Class:** `db.t3.micro`
- **Replication Source:** `my-db-instance`
- **Public Accessibility:** Disabled

A read replica can help distribute read-heavy database workloads.

📌 **Note:** Read replicas replicate data asynchronously, so changes made to the primary database might not appear immediately on the replica.

## 📋 Prerequisites

Before deploying this project, make sure you have:

- ✅ An AWS account
- ✅ An IAM identity with the required permissions
- ✅ AWS CLI installed and configured
- ✅ Terraform installed
- ✅ Access to the AWS `us-west-2` region

Verify your Terraform installation:

```bash
terraform -version
```

Verify your AWS CLI configuration:

```bash
aws sts get-caller-identity
```

## 🚀 Deployment Steps

### Step 1: Clone the Repository

```bash
git clone <your-repository-url>
cd <your-project-directory>
```

Replace the placeholders with your actual repository URL and directory name.

### Step 2: Initialize Terraform

```bash
terraform init
```

This command downloads the required Terraform provider plugins and initializes the working directory.

### Step 3: Validate the Configuration

```bash
terraform validate
```

This checks whether the Terraform configuration is syntactically valid and internally consistent.

### Step 4: Review the Execution Plan

```bash
terraform plan
```

Review the proposed infrastructure changes before applying them.

### Step 5: Deploy the Infrastructure

```bash
terraform apply
```

Review the plan and type `yes` when Terraform requests confirmation.

Terraform will attempt to create the configured AWS resources.

### Step 6: Verify the Resources

Open the AWS Management Console and check:

- 🌐 VPC Dashboard
- 📦 Subnets
- 🌍 Internet Gateways
- 🛣️ Route Tables
- 🔐 Security Groups
- 🗄️ RDS Databases

RDS provisioning and read replica creation can take several minutes.

## 🧹 Cleanup

To remove the resources created by Terraform, run:

```bash
terraform destroy
```

Review the destruction plan and confirm when prompted.

⚠️ **Warning:** The current configuration uses `skip_final_snapshot = true`. Destroying an RDS instance with this setting can remove the database without creating a final snapshot. Back up important data before destroying any resources.

## 🔒 Best Practices

For a more secure and production-ready deployment:

1. 🔐 Store database credentials in AWS Secrets Manager or another secure secrets-management system.
2. 🚫 Never commit passwords, access keys, or other secrets to GitHub.
3. 🌐 Place databases in private subnets without direct internet routing.
4. 🛡️ Restrict Security Group inbound rules to trusted sources.
5. 💾 Enable appropriate backups and final snapshots.
6. 🧩 Use Terraform variables instead of hardcoding configuration values.
7. 📌 Pin the AWS provider version and manage Terraform state securely.
8. 💰 Review AWS pricing before deploying resources.

## 📚 Learning Outcomes

By completing this project, you will learn how to:

- Create AWS networking infrastructure using Terraform.
- Configure VPCs and subnets across Availability Zones.
- Attach an Internet Gateway and configure route tables.
- Create and associate AWS Security Groups.
- Configure Amazon RDS for MySQL.
- Configure an RDS read replica.
- Manage infrastructure using Terraform commands.
- Apply basic cloud networking and security practices.

## 👨‍💻 Author

**Alok Maurya**

Cloud & DevOps Learner 🚀

---

⭐ If you found this project helpful, consider giving the repository a star!
