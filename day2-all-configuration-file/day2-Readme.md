
# Terraform AWS VPC and Subnet Configuration

A Terraform project to provision an AWS Virtual Private Cloud (VPC) and eight subnets across two Availability Zones using reusable input variables and structured outputs.

## Architecture Overview

- **Cloud Provider:** AWS
- **Infrastructure as Code:** Terraform
- **AWS Region:** `us-west-2` (Oregon)
- **VPC CIDR:** `10.0.0.0/16`
- **Availability Zones:** `us-west-2a`, `us-west-2b`
- **Total Subnets:** 8

## Subnet Configuration

| Subnet | Purpose | Availability Zone | CIDR Block |
|---|---|---|---|
| Subnet 1 | Bastion | us-west-2a | 10.0.0.0/24 |
| Subnet 2 | Bastion | us-west-2b | 10.0.1.0/24 |
| Subnet 3 | Frontend | us-west-2a | 10.0.2.0/24 |
| Subnet 4 | Frontend | us-west-2b | 10.0.3.0/24 |
| Subnet 5 | Backend | us-west-2a | 10.0.4.0/24 |
| Subnet 6 | Backend | us-west-2b | 10.0.5.0/24 |
| Subnet 7 | Database | us-west-2a | 10.0.6.0/24 |
| Subnet 8 | Database | us-west-2b | 10.0.7.0/24 |

> **Note:** Subnet names describe their intended purpose. A subnet is not automatically public or private based on its name. Routing configuration determines its actual connectivity.

## Project Structure

```text
day2-all-configuration-file/
├── main.tf
├── output.tf
├── provider.tf
├── terraform.tfvars
└── variable.tf
```

A saved plan file such as `aws-devplan` may also exist locally.

## File Description

### `provider.tf`
Defines the required Terraform version and AWS provider.

### `variable.tf`
Defines input variables for:
- VPC CIDR block
- VPC region and name
- Subnet CIDR blocks and names using object types
- Availability Zones

### `terraform.tfvars`
Provides actual configuration values, including CIDR blocks, subnet names, region, and Availability Zones.

### `main.tf`
Defines the AWS VPC and eight subnets using the configured variables.

### `output.tf`
Defines outputs for:
- VPC ID, region, CIDR, and name
- Combined VPC details
- Individual subnet IDs, names, CIDR blocks, and Availability Zones
- Availability Zone configuration

## Prerequisites

1. Terraform CLI installed.
2. An AWS account.
3. AWS credentials configured with appropriate IAM permissions.
4. Git Bash, PowerShell, or another terminal.

Verify Terraform:

```bash
terraform -version
```

Verify AWS credentials:

```bash
aws sts get-caller-identity
```

## Configuration

Review `terraform.tfvars` before deployment.

The AWS provider region should be configured in `provider.tf`, for example:

```hcl
resource "aws_vpc" "dev_vpc" {
  cidr_block = var.dev_vpc_cidr
  region     = var.dev_vpc_region
  tags = {
    Name = var.dev_vpc_name
  }
}
```

The `region` argument belongs to the AWS provider configuration, not the `aws_vpc` resource.

Ensure that every subnet CIDR belongs to the VPC CIDR range and that subnet ranges do not overlap.

## Terraform Workflow

### 1. Initialize Terraform

```bash
terraform init
```

Initializes the working directory and downloads the required provider plugins.

### 2. Format Configuration

```bash
terraform fmt
```

Formats Terraform configuration files.

### 3. Validate Configuration

```bash
terraform validate
```

Checks the configuration syntax and internal consistency.

### 4. Preview Infrastructure Changes

```bash
terraform plan
```

Displays the proposed infrastructure changes without applying them.

### 5. Save a Plan

```bash
terraform plan -out=aws-devplan
```

Saves the generated plan to a file named `aws-devplan`.

Inspect the saved plan:

```bash
ls *plan*
```

### 6. Apply the Saved Plan

```bash
terraform apply aws-devplan
```

Applies the actions recorded in the saved plan. 

Alternatively, use the interactive workflow:

```bash
terraform apply
```

### 7. View Outputs

Display all outputs:

```bash
terraform output
```

Display VPC details:

```bash
terraform output dev_vpc_details
```

Display subnet details:

```bash
terraform output dev_subnet_1_details
```

Display a nested output as JSON:

```bash
terraform output -json dev_subnet_1_details
```

To extract only the CIDR using `jq` (if its installed):

```bash
terraform output -json dev_subnet_1_details | jq -r '.cidr'
```

Terraform's `output` command accepts declared output names. It does not directly accept nested property expressions such as `dev_subnet_1_details.cidr`.

### 8. Destroy Infrastructure

Preview the destruction plan:

```bash
terraform plan -destroy
```

Destroy the managed infrastructure when it is no longer required:

```bash
terraform destroy
```

**Warning:** Review the target AWS account, region, and planned changes before destroying resources.

## Important Notes

- This project provisions a VPC and subnets only.
- Internet Gateways, NAT Gateways, route tables, security groups, and EC2 instances are not included.
- Terraform state and saved plan files can contain sensitive information.
- Never commit AWS credentials, state files, or saved plans to a public repository.
- Keep `.terraform.lock.hcl` under version control for consistent provider selections.

## Learning Objectives

- Understand Terraform variables and object types.
- Separate configuration values into `terraform.tfvars`.
- Provision AWS VPCs and subnets.
- Reference resources and combine variable values.
- Define individual and nested outputs.
- Use Terraform plan, apply, validate, and destroy workflows.