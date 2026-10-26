# 🚀 Day 6 — Terraform Module Calling (AWS)

Hey everyone! 👋

Welcome to my **Day 6 of learning Terraform**!

In the previous part, I created separate Terraform modules for AWS resources like **EC2 and S3**. In this part, I learned how to call those modules from another Terraform project and pass values to them.

The main goal was simple: instead of writing everything again, I wanted to reuse the modules I had already created. 😊

This is a small hands-on project, but it helped me understand how Terraform modules communicate with each other.

---

## 🎯 What I Wanted to Learn

While working on this project, I focused on:

- 📦 Calling a Terraform module using the `module` block.
- 🔗 Connecting my calling project with the modules created earlier.
- 📝 Passing values from `terraform.tfvars`.
- 🧩 Using object-type variables to group related values.
- 🖥️ Passing configuration values to an EC2 module.
- 🪣 Passing configuration values to an S3 module.
- 📤 Accessing module outputs using `module.<module-name>.<output-name>`.
- 📋 Collecting individual outputs as well as complete resource details using objects.

---

## 📁 Project Structure

Here is how my project is organized:

```text
day-6-module-calling/
│
├── main.tf             # Calls the required Terraform modules
├── output.tf           # Collects and displays module outputs
├── terraform.tfvars    # Contains values for my variables
├── variable.tf         # Defines the variables used in this project
└── README.md            # Project documentation
```

This project uses the modules created in my previous project, `day-6-modules`.

The relative paths connect both projects:

- `../day-6-modules` → Root module configuration
- `../day-6-modules/compute` → EC2 module
- `../day-6-modules/storage` → S3 module

---

## 🧩 1. Calling the Modules — `main.tf`

This is where the main work happens!

I used three module blocks to connect my calling project with the Terraform configurations I created earlier.

### 🌎 AWS Region Module

```hcl
module "dev-aws-region" {
  source     = "../day-6-modules"
  aws-region = var.aws-region-name
}
```

Here, I passed the AWS region value to my root module.

The region is defined in `terraform.tfvars`, and I access it through the variable `aws-region-name`.

### 🖥️ EC2 Module

```hcl
module "dev-ec2" {
  source = "../day-6-modules/compute"

  ami           = var.ec2.ami-id
  instance-type = var.ec2.instance-type
  name          = var.ec2.tag-name
}
```

Here, I called my EC2 module and passed three values:

- 🆔 `ami` — The AMI ID used for the instance.
- ⚙️ `instance-type` — The EC2 instance type.
- 🏷️ `name` — The name tag assigned to the instance.

Instead of defining these values directly inside the module block, I used variables to keep the configuration organized.

### 🪣 S3 Module

```hcl
module "dev-s3" {
  source = "../day-6-modules/storage"

  s3-bucket-name = var.s3.bucket-name
  s3-region      = var.s3.region
  s3-tag-name    = var.s3.tag-name
}
```

Similarly, I called the S3 module and passed the bucket name, AWS region and tag name.

This helped me understand how the same approach can be used for different AWS resources.

---

## 📝 2. Managing Values — `terraform.tfvars`

I used `terraform.tfvars` to provide the actual values for my variables.

```hcl
# 🌎 AWS Region
aws-region-name = "us-east-1"

# 🖥️ EC2 Configuration
ec2 = {
  ami-id        = "ami-04b938437b69a2c9c"
  instance-type = "t2.micro"
  tag-name      = "dev-server"
}

# 🪣 S3 Configuration
s3 = {
  bucket-name = "dev-akjw747isi93-bucket"
  region      = "us-west-2"
  tag-name    = "dev-bucket"
}
```

### 💡 Why did I use object-type variables?

Instead of creating separate top-level variables for every EC2 and S3 setting, I grouped related values into objects.

For example:

```hcl
ec2 = {
  ami-id        = "ami-04b938437b69a2c9c"
  instance-type = "t2.micro"
  tag-name      = "dev-server"
}
```

Now I can access individual values using expressions like:

```hcl
var.ec2.ami-id
var.ec2.instance-type
var.ec2.tag-name
```

The same idea applies to my S3 configuration:

```hcl
var.s3.bucket-name
var.s3.region
var.s3.tag-name
```

**My takeaway:** Grouping related values makes the configuration easier to read and manage. 🙌

---

## 🔧 3. Defining Variables — `variable.tf`

In `variable.tf`, I defined the variables required by the calling project.

For AWS region, I used a string variable:

```hcl
variable "aws-region-name" {
  description = "value for aws region name"
  default     = ""
  type        = string
}
```

For EC2, I used an object containing the AMI ID, instance type and tag name:

```hcl
variable "ec2" {
  description = "Using object type variable for required ec2 values"

  type = object({
    ami-id        = string
    instance-type = string
    tag-name      = string
  })

  default = {
    ami-id        = ""
    instance-type = ""
    tag-name      = ""
  }
}
```

For S3, I used another object:

```hcl
variable "s3" {
  description = "Using object type variable for required S3 values"

  type = object({
    bucket-name = string
    region      = string
    tag-name    = string
  })

  default = {
    bucket-name = ""
    region      = ""
    tag-name    = ""
  }
}
```

This helped me understand how Terraform object types can keep related configuration values together.

---

## 📤 4. Accessing Module Outputs — `output.tf`

This was one of the most interesting parts of the project! 😎

After calling a module, I can access the outputs it exposes using this syntax:

```hcl
module.<module-name>.<output-name>
```

For example:

```hcl
module.dev-ec2.ec2-id
```

Let's break it down:

- `module` → Tells Terraform that I am accessing a module.
- `dev-ec2` → The name I gave to the module in `main.tf`.
- `ec2-id` → The output name defined inside the EC2 module.

### 🖥️ EC2 Outputs

I created outputs to access the following EC2 details:

| Output | What it gives me |
|---|---|
| `out-ec2-id` | EC2 instance ID |
| `out-ec2-ami` | AMI ID |
| `out-ec2-instance` | Instance type |
| `out-ec2-name` | Instance name |
| `out-ec2-details` | A combined object containing EC2 details |

For example:

```hcl
output "out-ec2-id" {
  description = "Output value of EC2 ID"
  value       = module.dev-ec2.ec2-id
}
```

### 🪣 S3 Outputs

I also collected outputs from my S3 module:

| Output | What it gives me |
|---|---|
| `out-s3-id` | S3 bucket ID |
| `out-s3-bucket-name` | S3 bucket name |
| `out-s3-region` | S3 bucket region |
| `out-s3-tag-name` | S3 bucket tag name |
| `out-s3-details` | A combined object containing S3 details |

For example:

```hcl
output "out-s3-bucket-name" {
  value = module.dev-s3.s3-bucket-name
}
```

### 🌎 AWS Region Output

I also accessed the region output exposed by my root module:

```hcl
output "out-aws-region" {
  value = module.dev-aws-region.aws-region
}
```

This works because the called module exposes an output named `aws-region`.

### 📋 What about the combined details?

I also used object outputs:

```hcl
output "out-ec2-details" {
  value = module.dev-ec2.ec2-details
}

output "out-s3-details" {
  value = module.dev-s3.s3-details
}
```

These outputs allow me to retrieve multiple related details together instead of accessing every value separately.

Pretty useful, right? 😄

---

## ⚡ 5. Running the Project

Here are the commands I used to work with the configuration.

Run these commands from the `day-6-module-calling` directory.

### Step 1: Initialize Terraform

```bash
terraform init
```

This initializes the working directory and prepares the required providers and modules.

### Step 2: Format the Configuration

```bash
terraform fmt -recursive
```

This formats the Terraform files for better readability.

### Step 3: Validate the Configuration

```bash
terraform validate
```

This checks whether the Terraform configuration is syntactically valid and internally consistent.

### Step 4: Review the Execution Plan

```bash
terraform plan
```

This shows the proposed infrastructure changes before applying them.

### Step 5: Apply the Configuration

```bash
terraform apply
```

After reviewing the plan, confirm the operation when prompted.

**Note:** Applying the configuration can create real AWS resources and incur charges.

### Step 6: View All Outputs

```bash
terraform output
```

To view a specific output, I can use commands like:

```bash
terraform output out-aws-region
terraform output out-ec2-id
terraform output out-ec2-details
terraform output out-s3-details
```

These commands display the values exposed by my root configuration after a successful apply.

---

## 🧠 What I Learned Today

This project helped me understand a few important Terraform concepts:

- 📦 How to call modules using the `module` block.
- 🔗 How the `source` argument connects a calling project to another Terraform configuration.
- 📝 How values from `terraform.tfvars` flow into input variables.
- 🧩 How object-type variables group related settings.
- 🖥️ How to pass configuration values to an EC2 module.
- 🪣 How to pass configuration values to an S3 module.
- 📤 How to access child module outputs from the calling configuration.
- 📋 How object outputs can return multiple related values together.
- 🔄 How reusable modules help avoid repeating the same resource configuration.

The biggest thing I learned is that **creating a module is only one part of the process; calling it, passing values and accessing its outputs are equally important.**

---

## 🎉 Final Thoughts

Day 6 was a good learning experience!

Earlier, I was working on the modules themselves. Now, I have a separate calling project that uses those modules and collects their outputs.

This gave me a better understanding of how Terraform projects can be organized into reusable parts.

I'm still learning, and every hands-on project helps me understand Terraform a little better. One step at a time! 💪

Thanks for checking out my project. ❤️

⭐ If you're also learning Terraform, feel free to explore the code and practice along with me!

**#Terraform #AWS #DevOps #InfrastructureAsCode #LearningInPublic**