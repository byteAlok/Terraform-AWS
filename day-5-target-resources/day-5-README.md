# 🚀 Day 5: Terraform Target Resources & Variable Files

## 📁 Project Structure

```text
day-5-target-resources/
├── custom_var.tfvars
├── main.tf
├── provider.tf
├── terraform.tfvars
├── variable.tf
└── day-5-README.md
```

---

## 📌 1. Terraform Commands Without Target

### ✅ A. Using Default Variable File (`terraform.tfvars`)

Terraform automatically loads `terraform.tfvars`.

**Preview changes:**
```bash
terraform plan
```

**Apply changes with confirmation:**
```bash
terraform apply
```

**Apply changes without confirmation:**
```bash
terraform apply -auto-approve
```

**Destroy resources with confirmation:**
```bash
terraform destroy
```

**Destroy resources without confirmation:**
```bash
terraform destroy -auto-approve
```

📌 **Explanation:**
- `terraform plan` → Previews the changes.
- `terraform apply` → Creates or updates resources.
- `terraform destroy` → Destroys managed resources.
- `-auto-approve` → Skips the interactive confirmation.

---

## 🎯 2. Terraform Commands With Target

### ✅ A. Using Default Variable File (`terraform.tfvars`)

**Preview changes for S3 Bucket 1:**
```bash
terraform plan -target=aws_s3_bucket.my_s3_1
```

**Apply changes with confirmation:**
```bash
terraform apply -target=aws_s3_bucket.my_s3_1
```

**Apply changes without confirmation:**
```bash
terraform apply -target=aws_s3_bucket.my_s3_1 -auto-approve
```

**Destroy S3 Bucket 1 with confirmation:**
```bash
terraform destroy -target=aws_s3_bucket.my_s3_1
```

**Destroy S3 Bucket 1 without confirmation:**
```bash
terraform destroy -target=aws_s3_bucket.my_s3_1 -auto-approve
```

📌 **Explanation:**
- `-target=aws_s3_bucket.my_s3_1` → Focuses on the first S3 bucket.
- `aws_s3_bucket` → Terraform resource type.
- `my_s3_1` → Resource name defined in `main.tf`.

🎯 For S3 Bucket 2, replace the target with:

```bash
-target=aws_s3_bucket.my_s3_2
```

---

## 🗂️ 3. Terraform Commands Without Target Using a Custom Variable File

### ✅ B. Using `custom_var.tfvars`

Terraform does not automatically load arbitrarily named variable files.

Therefore, use `-var-file="custom_var.tfvars"`.

**Preview changes:**
```bash
terraform plan -var-file="custom_var.tfvars"
```

**Apply changes with confirmation:**
```bash
terraform apply -var-file="custom_var.tfvars"
```

**Apply changes without confirmation:**
```bash
terraform apply -var-file="custom_var.tfvars" -auto-approve
```

**Destroy resources with confirmation:**
```bash
terraform destroy -var-file="custom_var.tfvars"
```

**Destroy resources without confirmation:**
```bash
terraform destroy -var-file="custom_var.tfvars" -auto-approve
```

📌 **Explanation:**

- `-var-file="custom_var.tfvars"` → Loads variables from the specified file.
- `-auto-approve` → Skips interactive confirmation.
- The custom file provides values such as AWS region, bucket names, and tags.

---

## 🎯 4. Terraform Commands With Target Using a Custom Variable File

### ✅ C. Using `custom_var.tfvars`

**Preview changes for S3 Bucket 1:**
```bash
terraform plan -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_1
```

**Apply changes with confirmation:**
```bash
terraform apply -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_1
```

**Apply changes without confirmation:**
```bash
terraform apply -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_1 -auto-approve
```

**Destroy S3 Bucket 1 with confirmation:**
```bash
terraform destroy -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_1
```

**Destroy S3 Bucket 1 without confirmation:**
```bash
terraform destroy -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_1 -auto-approve
```

📌 **Explanation:**

Here, two options are used together:

1. `-var-file="custom_var.tfvars"` → Loads custom variable values.
2. `-target=aws_s3_bucket.my_s3_1` → Targets the first S3 bucket.

🎯 For S3 Bucket 2, use:

```bash
terraform plan -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_2
```

```bash
terraform apply -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_2 -auto-approve
```

```bash
terraform destroy -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_2 -auto-approve
```

---

## 🧠 5. Important Concepts

### 📌 `terraform.tfvars` vs `custom_var.tfvars`

| Feature | `terraform.tfvars` | `custom_var.tfvars` |
|---|---|---|
| Automatically loaded | ✅ Yes | ❌ No |
| Requires `-var-file` | ❌ No | ✅ Yes |
| Supports custom values | ✅ Yes | ✅ Yes |

### 📌 Resource Targeting

| Command | Purpose |
|---|---|
| `terraform plan` | Preview all planned changes |
| `terraform apply` | Apply the full configuration |
| `terraform destroy` | Destroy managed resources |
| `-target=aws_s3_bucket.my_s3_1` | Focus on S3 Bucket 1 |
| `-target=aws_s3_bucket.my_s3_2` | Focus on S3 Bucket 2 |
| `-auto-approve` | Skip confirmation |

⚠️ **Important:** Terraform recommends using `-target` only for exceptional situations, such as recovering from errors. Prefer a complete plan and apply during normal workflows.

---

## ⚠️ 6. Important Notes

1. **Variable files:** Always specify `-var-file="custom_var.tfvars"` when you want to use that custom file.

2. **Different values:** Your `terraform.tfvars` and `custom_var.tfvars` contain different bucket names and AWS regions. The selected file determines the input values.

3. **Terraform state:** Both configurations normally use the same state unless you configure separate workspaces or backends. Switching variable files does not create a separate state.

4. **Targeting:** A targeted operation can leave other configuration changes unapplied.

5. **S3 bucket names:** S3 bucket names must be globally unique. If a bucket name is already taken, AWS may reject its creation.

6. **Destroy warning:** `terraform destroy -auto-approve` can delete managed infrastructure without asking for confirmation. Review your target and state before running it.

---

## 🏁 7. Quick Revision

### Default Variable File
```bash
terraform plan
terraform apply -auto-approve
terraform destroy -auto-approve
```

### Default Variable File + Target
```bash
terraform plan -target=aws_s3_bucket.my_s3_1
terraform apply -target=aws_s3_bucket.my_s3_1 -auto-approve
terraform destroy -target=aws_s3_bucket.my_s3_1 -auto-approve
```

### Custom Variable File
```bash
terraform plan -var-file="custom_var.tfvars"
terraform apply -var-file="custom_var.tfvars" -auto-approve
terraform destroy -var-file="custom_var.tfvars" -auto-approve
```

### Custom Variable File + Target
```bash
terraform plan -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_1
terraform apply -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_1 -auto-approve
terraform destroy -var-file="custom_var.tfvars" -target=aws_s3_bucket.my_s3_1 -auto-approve
```

---

**✅ Day 5 Completed: Terraform Resources, Variables, Variable Files, Targeting, Apply, and Destroy.**
