# 🚀 Day 7 – Terraform Dependency Block

## 📌 Overview

Terraform Dependency Management determines the order in which infrastructure resources are created, updated, and destroyed. Terraform supports two types of dependencies:

- 🔄 **Implicit Dependency (Automatic):** Terraform automatically identifies dependencies through resource attribute references.
- ⚙️ **Explicit Dependency (`depends_on`):** Manually defines dependencies when Terraform cannot automatically identify the required execution order.

## 📂 Project Structure

```text
day-7-dependency-block/
└── 📄 main.tf
```

---

## 🔄 1. Implicit Dependency (Automatic Dependency)

Implicit dependency occurs when one resource references an attribute of another resource. Terraform automatically detects this relationship and creates resources in the correct order.

### 🛠️ Implementation

- 🔑 Created an AWS Key Pair using `aws_key_pair`.
- 📂 Used the existing local public key file (`id_rsa.pub`).
- 🖥️ Created an EC2 instance using the Terraform AWS EC2 Instance Module.
- 🔗 Referenced `aws_key_pair.user1.key_name` inside the EC2 module's `key_name` argument.

### 🔀 Dependency Flow

```text
┌──────────────────────────────┐
│       AWS Key Pair           │
│       aws_key_pair.user1     │
└──────────────┬───────────────┘
               │
               │ key_name reference
               ▼
┌──────────────────────────────┐
│        EC2 Instance          │
│        module.ec2_instance   │
└──────────────────────────────┘
```

**⚡ Execution Order:**

1. 🔑 Terraform creates the AWS Key Pair.
2. 🖥️ Terraform creates the EC2 instance using that Key Pair.

💡 **Key Concept:** No need to write `depends_on`. Terraform automatically identifies the dependency through the resource reference.

---

## ⚙️ 2. Explicit Dependency (`depends_on`)

Explicit dependency is used when Terraform cannot automatically identify a dependency between resources.

We use the `depends_on` meta-argument to manually define the resource creation order.

### 🔗 Example 1: Chain Dependency

Implemented a dependency chain involving two S3 buckets and one EC2 instance.

**🛠️ Implementation:**

- 🪣 Created S3 Bucket `dev-bucket-1`.
- 🖥️ Created EC2 Instance `server-1` with a dependency on `dev-bucket-1`.
- 🪣 Created S3 Bucket `dev-bucket-2` with a dependency on `server-1`.

### 🔀 Dependency Flow

```text
┌──────────────────────────────┐
│       S3 Bucket 1            │
│       dev-bucket-1           │
└──────────────┬───────────────┘
               │
               │ depends_on
               ▼
┌──────────────────────────────┐
│       EC2 Instance           │
│       server-1               │
└──────────────┬───────────────┘
               │
               │ depends_on
               ▼
┌──────────────────────────────┐
│       S3 Bucket 2            │
│       dev-bucket-2           │
└──────────────────────────────┘
```

**⚡ Execution Order:**

1. 🪣 Create `dev-bucket-1`.
2. 🖥️ Create `server-1`.
3. 🪣 Create `dev-bucket-2`.

💡 **Key Concept:** Each resource waits for its dependency to be created before Terraform proceeds with its creation.

---

### 🔗 Example 2: Multiple Dependencies

Implemented multiple dependencies by making one EC2 instance dependent on two S3 buckets.

**🛠️ Implementation:**

- 🪣 Created S3 Bucket `dev-bucket-3`.
- 🪣 Created S3 Bucket `dev-bucket-4`.
- 🖥️ Created EC2 Instance `server-2`.
- 🔗 Added both S3 buckets inside the EC2 instance's `depends_on` list.

### 🔀 Dependency Flow

```text
┌──────────────────────┐
│     S3 Bucket 3      │
│     dev-bucket-3     │
└──────────┬───────────┘
           │
           │
           ▼
      ┌──────────────────────┐
      │                      │
      │     EC2 Instance     │
      │     server-2         │
      │                      │
      └──────────────────────┘
           ▲
           │
           │
┌──────────┴───────────┐
│     S3 Bucket 4      │
│     dev-bucket-4     │
└──────────────────────┘
```

**⚡ Execution Order:**

1. 🪣 Create `dev-bucket-3`.
2. 🪣 Create `dev-bucket-4`.
3. 🖥️ Create `server-2` after both buckets are created.

💡 **Key Concept:** Both S3 buckets are independent, so Terraform can create them in parallel. The EC2 instance waits until both dependencies are satisfied.

---

## 📊 3. Implicit vs Explicit Dependency

| Feature | 🔄 Implicit | ⚙️ Explicit |
|---|---|---|
| Dependency detection | Automatic | Manual |
| Configuration | Resource reference | `depends_on` |
| Dependency visibility | Through references | Directly specified |
| Execution order | Automatically determined | Manually specified |
| Best suited for | Direct resource relationships | Hidden dependencies |

## 🧠 4. Important Terraform Concepts

- 🔗 **Dependency Graph:** Terraform internally builds a graph to determine resource execution order.
- ⚡ **Parallel Execution:** Independent resources can be created simultaneously.
- 🔄 **Dependency Chain:** Resources are created in a specific sequence.
- 🔀 **Multiple Dependencies:** A resource can depend on multiple resources.
- 🗑️ **Destroy Order:** Terraform generally destroys dependent resources before the resources they depend on.

## 💻 5. Terraform Commands

```bash
# 🔧 Initialize Terraform
terraform init

# ✅ Validate configuration
terraform validate

# 📋 Preview infrastructure changes
terraform plan

# 🚀 Create AWS infrastructure
terraform apply

# 🗑️ Destroy AWS infrastructure
terraform destroy
```

## 🎯 6. Learning Outcomes

After completing this practical, I learned:

- 🔄 Understanding implicit dependencies.
- ⚙️ Implementing explicit dependencies using `depends_on`.
- 🔑 Creating AWS Key Pairs and associating them with EC2 instances.
- 🪣 Managing S3 bucket dependencies.
- 🔗 Implementing chain dependencies.
- 🔀 Configuring multiple dependencies.
- ⚡ Understanding parallel resource creation.
- 🧠 Understanding Terraform's dependency graph and execution order.

---

## 🏁 Practical Summary

```text
          TERRAFORM DEPENDENCIES
                    │
          ┌─────────┴─────────┐
          │                   │
          ▼                   ▼
    🔄 IMPLICIT          ⚙️ EXPLICIT
     AUTOMATIC             MANUAL
          │                   │
          ▼                   ▼
   Resource Reference     depends_on
          │                   │
          ▼                   ▼
     🔑 Key Pair          🔗 Chain
          │                   │
          ▼                   ▼
     🖥️ EC2 Instance      🪣 S3 → EC2 → S3
                             
                          🔀 Multiple
                              │
                              ▼
                         🪣 S3 + S3
                              │
                              ▼
                          🖥️ EC2
```
⚠️ **Note:** `depends_on` controls resource dependency ordering, not application-level readiness or service health.

---

## 👨‍💻 Author

**Alok Maurya**

Cloud & DevOps Learner 🚀

---

⭐ If you found this project helpful, consider giving the repository a star!
