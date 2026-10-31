# 🚀 Day 8 – Terraform Provisioners

## 📌 Overview

This practical demonstrates how Terraform Provisioners execute commands and transfer files during infrastructure provisioning.

In this practical, I explored three types of Terraform Provisioners:

- 💻 **Local Provisioner (`local-exec`):** Executes commands on the local PC/Laptop.
- ☁️ **Remote Execution Provisioner (`remote-exec`):** Executes commands on a remote server through SSH.
- 📂 **File Provisioner (`file`):** Transfers files from the local machine to a remote server.

Additionally, I configured SSH connections, tested Ubuntu EC2 User Data behaviour, and practiced transferring locally created files to remote EC2 instances.

## 📂 Project Structure

```text
day-8-provisioners/
├── 📁 test-folder/
│   └── 📄 notes.txt
├── 📄 docs.txt
├── 📄 main.tf
├── 📄 new1.txt
├── 📄 provider.tf
└── 📄 README.md
```

---

## ☁️ 1. AWS Infrastructure Setup

Before implementing provisioners, configured the required AWS infrastructure using Terraform.

### 🛠️ Resources Created

| AWS Resource | Configuration | Purpose |
|---|---|---|
| 🌐 VPC | `10.0.0.0/16` | Virtual Private Cloud |
| 🔑 Key Pair | `server-key` | SSH authentication |
| 🌍 Public Subnet | `10.0.0.0/24` | Hosts public EC2 instances |
| 🌐 Internet Gateway | `igw` | Internet connectivity |
| 🛣️ Route Table | `0.0.0.0/0` → IGW | Internet routing |
| 🔐 Security Group | SSH (22), HTTP (80) | Controls inbound traffic |
| 🖥️ EC2 Instances | 4 Ubuntu instances | Provisioner practicals |

### 🔄 Infrastructure Flow

```text
              ☁️ AWS
                |
                ▼
          🌐 VPC (10.0.0.0/16)
                |
                ▼
          🌍 Public Subnet
                |
        ┌───────┴────────┐
        │                │
        ▼                ▼
  🌐 Internet       🔐 Security
     Gateway           Group
        │                │
        └───────┬────────┘
                |
                ▼
        🖥️ Ubuntu EC2 Instances
          ┌─────┼─────┐
          │     │     │
         EC2   EC2   EC2   EC2
          1     2     3     4
```

---

## 📜 2. EC2 Instance 1 – User Data Testing

Created an Ubuntu EC2 instance and configured User Data to automatically install and start Apache Web Server during the instance's first boot.

### 🛠️ Implementation

- 📦 Updated Ubuntu packages using `apt update`.
- 🌐 Installed Apache2 Web Server.
- ▶️ Enabled and started the Apache service.
- 📄 Created a custom HTML webpage.

**User Data – Version 1:**

```bash
echo "<h1>Hello from Terraform User Data!</h1>" > /var/www/html/index.html
```

**User Data – Version 2:**

```bash
echo "<h1>User Data Updated Successfully!</h1>" > /var/www/html/index.html
```

### 🔍 User Data Update Behaviour

Tested what happens when User Data is modified in Terraform for an existing EC2 instance.

**Observations:**

- ✏️ Modified the User Data script from Version 1 to Version 2.
- 🔍 Terraform detected the User Data configuration change.
- 🔄 The instance could be stopped and started depending on the update behaviour and configuration.
- ⚠️ The updated User Data script did not automatically execute again on the existing Ubuntu instance because cloud-init normally runs user scripts only during the initial boot.

**Verification:**

```bash
sudo cat /var/log/cloud-init-output.log
```

💡 **Key Concept:** User Data is primarily used for initial EC2 instance bootstrapping. Modifying User Data does not automatically rerun the script on an existing Ubuntu instance.

---

## 🔐 3. SSH Connection Configuration

Configured SSH connection details inside EC2 resource blocks to allow Terraform to communicate with remote Ubuntu instances.

**Implementation:**

```hcl
connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = file("~/.ssh/id_rsa")

  host    = self.public_ip
  timeout = "3m"
}
```

**Configuration Breakdown:**

| Argument | Value | Purpose |
|---|---|---|
| `type` | `ssh` | Connection protocol |
| `user` | `ubuntu` | Remote login username |
| `private_key` | `~/.ssh/id_rsa` | SSH private key |
| `host` | `self.public_ip` | EC2 public IP address |
| `timeout` | `3m` | Connection timeout |

💡 **Key Concept:** SSH connection configuration is required for remote operations such as `file` and `remote-exec` provisioners. It is not required by `local-exec`.

---

## 💻 4. Local Provisioner (`local-exec`)

The `local-exec` provisioner executes commands directly on the local machine where Terraform is running.

### 🛠️ Implementation

```hcl
provisioner "local-exec" {
  interpreter = ["bash", "-c"]

  command = "mkdir -p test-folder && cd test-folder && echo Hello > notes.txt"
}
```

**Implemented:**

- 📁 Created a local directory named `test-folder`.
- 📄 Created a `notes.txt` file inside the directory.
- ✍️ Added `Hello` as file content.
- 🖥️ Used Git Bash from the system PATH to execute local commands.

### 🔀 Execution Flow

```text
       🚀 Terraform Apply
                |
                ▼
       ⚙️ local-exec
                |
                ▼
        💻 Local PC/Laptop
                |
                ▼
          📁 test-folder
                |
                ▼
           📄 notes.txt
                |
                ▼
          ✍️ Hello
```

### 🧩 Multiple Command Execution Methods

Practiced three different ways to execute multiple commands.

**Method 1: Using `&&`**

```hcl
provisioner "local-exec" {
  command = "mkdir test-folder && cd test-folder && echo Hello > notes.txt"
}
```

- ✅ Executes the next command only if the previous command succeeds.

**Method 2: Using `;`**

```hcl
provisioner "local-exec" {
  command = "mkdir test-folder; cd test-folder; echo 'Hello from Terraform' > notes.txt; echo 'File created successfully!'"
}
```

- 🔄 Executes the next command regardless of the previous command's success or failure.

**Method 3: Using Heredoc (`EOT`)**

```hcl
provisioner "local-exec" {
  command = <<-EOT
    mkdir test-folder
    cd test-folder
    echo "Hello from Terraform" > notes.txt
    echo "Local provisioner executed successfully!"
  EOT
}
```

- 📝 Writes multiple commands on separate lines inside a single command block.

### ⚙️ Git Bash Interpreter

```hcl
interpreter = ["bash", "-c"]
```

- 🐚 `bash` → Uses Bash shell.
- ⚙️ `-c` → Executes the following string as a command.
- 🔍 Verified Bash availability through the system PATH.

---

## ☁️ 5. Remote Execution Provisioner (`remote-exec`)

The `remote-exec` provisioner executes commands directly on a remote EC2 instance through an SSH connection.

### 🛠️ Implementation

```hcl
provisioner "remote-exec" {
  inline = [
    "mkdir -p /home/ubuntu/new-folder",
    "echo Hello from Terraform > /home/ubuntu/new-folder/notes.txt",
    "ls -l /home/ubuntu/new-folder"
  ]
}
```

**Implemented:**

- 📁 Created a directory named `new-folder` on the remote Ubuntu EC2.
- 📄 Created a `notes.txt` file on the remote instance.
- 🔍 Verified the file using `ls -l`.
- 🔗 Executed all commands through SSH.

**Note:**

- All commands execute on the remote EC2 instance.
- The command output, including 'ls -l', can also be displayed in the local terminal during terraform apply.
- No need to SSH manually just to check the directory listing.

### 🔍 Important Commands

| Command | Purpose |
|---|---|
| `mkdir -p` | Creates a directory if it does not exist |
| `echo` | Writes text into a file |
| `ls` | Lists files and directories |
| `ls -l` | Displays detailed file information |


### 🔀 Execution Flow

```text
       🚀 Terraform Apply
                |
                ▼
        🔗 SSH Connection
                |
                ▼
        ☁️ Remote Ubuntu EC2
                |
                ▼
          ⚙️ remote-exec
                |
                ▼
          📁 new-folder
                |
                ▼
           📄 notes.txt
                |
                ▼
          🔍 ls -l Verification
```

💡 **Key Concept:** The `inline` argument accepts multiple commands as a list, which are executed sequentially on the remote machine.

---

## 📂 6. File Provisioner (`file`)

The `file` provisioner transfers files from the local machine to a remote server.

### 🛠️ Implementation – Example 1

Created a local file named `docs.txt` containing:

```text
Hello
📍This is local file <docs.txt> which I'm copy to remote server.
Bye.......
```

**Terraform Configuration:**

```hcl
provisioner "file" {
  source      = "docs.txt"
  destination = "/home/ubuntu/docs.txt"
}
```

**Implemented:**

- 📄 Used the existing local `docs.txt` file.
- 📤 Transferred the file to the remote Ubuntu EC2 instance.
- 📂 Stored it inside `/home/ubuntu/`.

### 🔀 File Transfer Flow

```text
       💻 Local PC
             |
             ▼
        📄 docs.txt
             |
             ▼
      📤 File Provisioner
             |
             | SSH
             ▼
       ☁️ Ubuntu EC2
             |
             ▼
      📂 /home/ubuntu/
             |
             ▼
        📄 docs.txt
```

### 🛠️ Implementation – Example 2

Combined all three provisioners to demonstrate local file creation, remote directory creation, and file transfer.

**Step 1: Local Provisioner**

```hcl
provisioner "local-exec" {
  interpreter = ["bash", "-c"]
  command     = "echo Hello world > new1.txt"
}
```

- 💻 Created `new1.txt` on the local PC.
- ✍️ Added `Hello world` as file content.

**Step 2: Remote Execution Provisioner**

```hcl
provisioner "remote-exec" {
  inline = [
    "mkdir -p /home/ubuntu/new-folder"
  ]
}
```

- ☁️ Created `new-folder` on the remote Ubuntu EC2.

**Step 3: File Provisioner**

```hcl
provisioner "file" {
  source      = "new1.txt"
  destination = "/home/ubuntu/new-folder/myfile.txt"
}
```

- 📤 Copied the locally created `new1.txt` file to the remote EC2.
- 📄 Stored the copied file as `myfile.txt`.

💡 **Important:** The destination can use a different filename. The source file's content is copied into the destination file; the original filename does not need to be preserved.

### 🔀 Combined Provisioner Execution Flow

```text
       🚀 Terraform Apply
                |
                ▼
       💻 LOCAL-EXEC
                |
                ▼
       📄 Create new1.txt
         (Local PC)
                |
                ▼
       ☁️ REMOTE-EXEC
                |
                ▼
       📁 Create new-folder
         (Remote EC2)
                |
                ▼
       📂 FILE PROVISIONER
                |
                ▼
       📤 Copy new1.txt
                |
                ▼
       ☁️ Remote Ubuntu EC2
                |
                ▼
       📁 /home/ubuntu/new-folder/
                |
                ▼
          📄 myfile.txt
```

**⚡ Important Execution Rule:**

Terraform executes provisioners sequentially in the order they are defined within the resource block.

In this example:

1. 💻 `local-exec` creates the local file.
2. ☁️ `remote-exec` creates the remote directory.
3. 📤 `file` copies the local file to the remote directory.

---

## 📊 7. Provisioners Comparison

| Feature | 💻 local-exec | ☁️ remote-exec | 📂 file |
|---|---|---|---|
| Purpose | Execute commands | Execute remote commands | Transfer files |
| Execution | Local PC | Remote server | Local → Remote |
| SSH Required | ❌ No | ✅ Yes | ✅ Yes |
| Main Argument | `command` | `inline` | `source`, `destination` |
| Example | Create local file | Create remote folder | Copy local file |

## 🧠 8. Important Concepts Learned

- 🏗️ Terraform Provisioners.
- 💻 Local Provisioner (`local-exec`).
- ☁️ Remote Execution Provisioner (`remote-exec`).
- 📂 File Provisioner (`file`).
- 🔐 SSH Connection Configuration.
- 🐚 Git Bash Interpreter Configuration.
- ⚙️ Multiple Command Execution using `&&`, `;`, and Heredoc.
- 📁 Local and Remote File Management.
- 📤 Local-to-Remote File Transfer.
- 🔄 Sequential Provisioner Execution.
- 📜 AWS EC2 User Data Behaviour.
- 🔍 Linux Commands (`mkdir`, `echo`, `ls -l`).

## 🎯 9. Learning Outcomes

After completing this practical, I learned how to:

- Configure SSH connectivity between Terraform and Ubuntu EC2 instances.
- Execute local commands using `local-exec`.
- Execute remote Linux commands using `remote-exec`.
- Transfer local files to remote EC2 instances using `file`.
- Use multiple provisioners within a single EC2 resource.
- Execute multiple commands using different shell syntax.
- Configure Git Bash as the local command interpreter.
- Understand the difference between local and remote execution.
- Understand the execution order of Terraform provisioners.
- Understand the behaviour of EC2 User Data when modified after initial boot.

---

## 👨‍💻 Author

**Alok Maurya**

Cloud & DevOps Learner 🚀

---

⭐ If you found this project helpful, consider giving the repository a star!
