<div align="center">

# 🚀 Day 6: Terraform Registry Modules

### ☁️ AWS + Terraform | My Learning Journey

🧩 Terraform Modules • 🪣 S3 Bucket • 🖥️ EC2 Instances • 🔐 SSH Key Pair

</div>

---

## 📚 What I Learned

In this project, I practised using pre-built modules from the Terraform Registry to create AWS resources.

- 🪣 Created an S3 bucket using a Terraform Registry module.
- 🖥️ Used a Terraform module to create multiple EC2 instances.
- 🔁 Used `for_each` to create three EC2 instances.
- 🔐 Generated an SSH key pair and registered the public key with AWS.
- 🔑 Connected to an EC2 instance using SSH.
- 🛠️ Troubleshot AWS Key Pair and SSH errors.

## 🪣 1. S3 Bucket Module

**Module:** `terraform-aws-modules/s3-bucket/aws`

```hcl
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket-wutige7d3"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
```

### 📝 Configuration Details

- `source` — Specifies the Terraform Registry module.
- `bucket` — Defines the S3 bucket name.
- `acl` — Sets the bucket ACL to private.
- `control_object_ownership` — Enables management of object ownership controls.
- `object_ownership` — Configures the object ownership mode.
- `versioning` — Enables S3 object versioning.

## 🖥️ 2. Create Multiple EC2 Instances

**Module:** `terraform-aws-modules/ec2-instance/aws`

```hcl
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["1", "2", "3"])

  name = "instance-${each.key}"

  instance_type = "t2.micro"
  monitoring    = true
  subnet_id     = "subnet-0592c0bbd702057a7"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "server-${each.key}"
  }
}
```

### 🔍 How `for_each` Works

```hcl
for_each = toset(["1", "2", "3"])
```

This creates three module instances.

| Module Key | Instance Name | Name Tag |
|---|---|---|
| `1` | `instance-1` | `server-1` |
| `2` | `instance-2` | `server-2` |
| `3` | `instance-3` | `server-3` |

Terraform tracks these module instances separately using their keys.

## 🔐 3. EC2 Instance with SSH Key Pair

```hcl
module "ec2_instance-2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "server-key-pair"

  instance_type = "t2.micro"
  key_name      = aws_key_pair.user1.key_name
  monitoring    = true
  subnet_id     = "subnet-042fd5ee292ec98c4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### 🔑 Create an AWS Key Pair Using My SSH Public Key

```hcl
resource "aws_key_pair" "user1" {
  key_name   = "user1"
  public_key = file("C:/Users/Alok/.ssh/id_rsa.pub")
}
```

### 📝 What I Learned

- `id_rsa` is my private SSH key.
- `id_rsa.pub` is my public SSH key.
- The public key is registered with AWS.
- The EC2 module uses `aws_key_pair.user1.key_name` to reference the AWS Key Pair.
- The EC2 instance and Key Pair must be in the same AWS region.

## 🔑 4. Connect to EC2 Using SSH

Initially, I used the public key file in the SSH command.

### ❌ Incorrect Command

```bash
ssh -i ~/.ssh/id_rsa.pub ec2-user@<EC2-PUBLIC-IP>
```

This produced an error:

```text
Load key: invalid format
Permission denied (publickey)
```

### ✅ Correct Command

```bash
ssh -i ~/.ssh/id_rsa ec2-user@<EC2-PUBLIC-IP>
```

I fixed the issue by using the private key instead of the public key.

- 🔒 `id_rsa` — Used for SSH authentication.
- 🔓 `id_rsa.pub` — Used to register the public key with AWS.

**Note:** Replace `<EC2-PUBLIC-IP>` with the actual public IP address of your EC2 instance.

## 🛠️ 5. Errors I Encountered

### ❌ Error 1: AWS Key Pair Not Found

```text
InvalidKeyPair.NotFound:
The key pair 'user1' does not exist
```

**Reason:** AWS could not find the `user1` Key Pair in the selected region.

**Solution:** I registered my existing SSH public key with AWS using the `aws_key_pair` resource.

### ❌ Error 2: SSH Invalid Key Format

```text
Load key: invalid format
Permission denied (publickey)
```

**Reason:** I used `id_rsa.pub` instead of the private key.

**Solution:**

```bash
ssh -i ~/.ssh/id_rsa ec2-user@<EC2-PUBLIC-IP>
```

## 🧪 6. Terraform Commands Used

```bash
terraform init
```

📦 Initializes Terraform and downloads the required modules and providers.

```bash
terraform plan
```

🔍 Previews the proposed infrastructure changes.

```bash
terraform apply
```

🚀 Applies the planned infrastructure changes after confirmation.

```bash
terraform apply -auto-approve
```

⚡ Applies changes without the interactive approval prompt.

---

<div align="center">

### 🌱 Learn • Practise • Troubleshoot • Improve

**Day 6 — Terraform Registry Modules** 🚀

</div>