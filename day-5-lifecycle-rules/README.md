# 🚀 Day 5 – Terraform Lifecycle Rules

## 📌 Overview

This practical demonstrates Terraform Lifecycle Rules, which control how Terraform creates, updates, replaces, and destroys infrastructure resources.

In this practical, I explored four important lifecycle meta-arguments and implemented them using AWS EC2 instances.

- 🔄 `ignore_changes`
- 🛡️ `prevent_destroy`
- ⚡ `create_before_destroy`
- 🔗 `replace_triggered_by`

Additionally, I configured Terraform output values to retrieve individual EC2 details and multiple resource attributes together.

## 📂 Project Structure

```text
day-5-lifecycle-rules/
├── 📄 main.tf
├── 📄 output.tf
└── 📄 provider.tf
```

---

## 🛠️ 1. Lifecycle Rules (`main.tf`)

Lifecycle rules are Terraform features, not AWS features. They control Terraform's resource management behavior.

### 🔄 A. `ignore_changes`

- Ignores changes to specified resource attributes during Terraform planning.
- Prevents Terraform from updating those attributes when their actual values differ from the configuration.

**Implementation:**

```hcl
lifecycle {
  ignore_changes = [tags]
}
```

💡 **Example:** If someone manually modifies EC2 tags from the AWS Console, Terraform ignores those tag changes during planning.

### 🛡️ B. `prevent_destroy`

- Prevents Terraform from destroying a resource.
- Terraform returns an error if a proposed operation requires destroying that resource while this rule is active.

**Implementation:**

```hcl
lifecycle {
  prevent_destroy = true
}
```

💡 **Example:** Protects important EC2 instances from accidental destruction through Terraform.

<text color="secondary" size="xs">Note: This rule is commented out in the actual EC2 configuration, so it is not currently active.</text>

### ⚡ C. `create_before_destroy`

- Creates a replacement resource before destroying the existing resource.
- Helps reduce downtime during resource replacement.

**Implementation:**

```hcl
lifecycle {
  create_before_destroy = true
}
```

**🔀 Execution Flow:**

```text
   🔄 Resource Replacement
             │
             ▼
   🆕 Create New EC2
             │
             ▼
   ✅ New EC2 Created
             │
             ▼
   🗑️ Destroy Old EC2
```

💡 **Example:** When an EC2 replacement is required, Terraform creates the new instance first and then destroys the old instance, subject to AWS resource constraints.

### 🔗 D. `replace_triggered_by`

- Replaces a resource when a referenced resource or its specified attributes undergo relevant changes.
- Establishes a replacement relationship between resources.

**Implementation:**

```hcl
lifecycle {
  replace_triggered_by = [
    aws_instance.my_ec2_1.id
  ]
}
```

💡 **Example:** If `my_ec2_1` is replaced and its ID changes, Terraform also replaces `my_ec2_2`.

**🔀 Replacement Flow:**

```text
┌──────────────────────────┐
│   🖥️ EC2 Instance 1      │
│      my_ec2_1            │
└────────────┬─────────────┘
             │
             │ ID Changes
             ▼
┌──────────────────────────┐
│   🔗 Replacement Trigger │
│   replace_triggered_by   │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│   🖥️ EC2 Instance 2      │
│      my_ec2_2            │
└──────────────────────────┘
             │
             ▼
       🔄 Replacement
```

---

## ☁️ 2. EC2 Resource Implementation

Created two EC2 instances in different Availability Zones.

| Configuration | EC2 Instance 1 | EC2 Instance 2 |
|---|---|---|
| Resource Name | `my_ec2_1` | `my_ec2_2` |
| AMI | `ami-0ed59cbb87dfa8dba` | Same AMI |
| Instance Type | `t2.micro` | `t2.micro` |
| Availability Zone | `us-east-1c` | `us-east-1d` |
| Name Tag | `dev-server-1` | `dev-server-2` |

### 🔄 Lifecycle Configuration

**EC2 Instance 1:**
- 🔄 `ignore_changes = [tags]`
- ⚡ `create_before_destroy = true`
- 🛡️ `prevent_destroy` commented out.

**EC2 Instance 2:**
- 🔗 `replace_triggered_by = [aws_instance.my_ec2_1.id]`

---

## 📤 3. Output Variables (`output.tf`)

Terraform output blocks allow us to retrieve and display resource attributes after infrastructure deployment.

Implemented two types of outputs:

### A. 🎯 Single-Valued Outputs

Created individual output blocks to retrieve specific EC2 attributes.

| Output Variable | Resource Attribute | Description |
|---|---|---|
| `ec2_id` | `.id` | EC2 Instance ID |
| `ec2_name` | `.tags["Name"]` | EC2 Instance Name |
| `ec2_az` | `.availability_zone` | Availability Zone |
| `ec2_instance_type` | `.instance_type` | Instance Type |
| `ec2_ami` | `.ami` | AMI ID |

### B. 📦 Multiple-Valued Output

Created a single output variable named `ec2_details` containing multiple EC2 attributes in an object.

**Included Attributes:**

- 🆔 Instance ID
- 🖼️ AMI ID
- 🌎 Availability Zone
- 🏷️ Instance Name
- 🖥️ Instance Type

**Output Structure:**

```hcl
output "ec2_details" {
  description = "All details of EC2 values"
  value = {
    id            = aws_instance.my_ec2_1.id
    ami           = aws_instance.my_ec2_1.ami
    az            = aws_instance.my_ec2_1.availability_zone
    name          = aws_instance.my_ec2_1.tags["Name"]
    instance_type = aws_instance.my_ec2_1.instance_type
  }
}
```

💡 **Key Concept:** Individual outputs retrieve specific attributes, whereas an object output groups multiple attributes under one output variable.

---

## ⚙️ 4. Provider Configuration (`provider.tf`)

Configured Terraform and AWS provider requirements.

| Configuration | Value |
|---|---|
| Terraform Version | `>= 1.0.0` |
| Provider Source | `hashicorp/aws` |
| AWS Provider Version | `~> 6.0` |
| AWS Region | `us-east-1` |

---

## 🔄 5. Terraform Execution Workflow

```text
       📄 Terraform Configuration
                  │
                  ▼
           🔧 terraform init
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
           ☁️ AWS EC2 Instances
                  │
                  ▼
           📤 Terraform Outputs
                  │
                  ▼
            📊 EC2 Details
```

## 💻 6. Terraform Commands

```bash
# 🔧 Initialize Terraform
terraform init

# ✅ Validate configuration
terraform validate

# 📋 Preview infrastructure changes
terraform plan

# 🚀 Deploy infrastructure
terraform apply

# 📤 Display all output values
terraform output

# 🎯 Display a specific output
terraform output ec2_id

# 📦 Display grouped EC2 details
terraform output ec2_details

# 🗑️ Destroy infrastructure
terraform destroy
```

## 🧠 7. Important Concepts Learned

- 🔄 Terraform Lifecycle Meta-Arguments.
- 🛡️ Resource Protection using `prevent_destroy`.
- ⚡ Resource Replacement using `create_before_destroy`.
- 🔗 Change Tracking using `replace_triggered_by`.
- 🏷️ Attribute Management using `ignore_changes`.
- 📤 Terraform Output Variables.
- 🎯 Single-Valued Outputs.
- 📦 Object-Based Multiple Outputs.
- ☁️ AWS EC2 Resource Management.
- 🌎 AWS Availability Zones.

## 🎯 8. Learning Outcomes

After completing this practical, I learned how to:

- Control Terraform resource lifecycle behavior.
- Ignore changes to specific resource attributes.
- Prevent accidental resource destruction.
- Create replacement resources before destroying existing ones.
- Trigger replacement of one resource based on another resource's changes.
- Retrieve individual EC2 resource attributes using output blocks.
- Group multiple resource attributes into a single output object.

---

## 👨‍💻 Author

**Alok Maurya**

Cloud & DevOps Learner 🚀

---

⭐ If you found this project helpful, consider giving the repository a star!
