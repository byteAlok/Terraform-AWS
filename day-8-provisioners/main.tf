
# --> AWS VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "project-vpc"
  }
}

# --> Key pair
resource "aws_key_pair" "server-key" {
  key_name   = "server-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Subnet 
resource "aws_subnet" "subnet-1-public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"

  map_public_ip_on_launch = true # --> Automatically assigned Public IPv4 

  tags = {
    Name = "project-subnet-1-public"
  }
}

# Internet Gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "project-igw"
  }
}

# Route Table 
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "project-public-rt"
  }
}

# Route table - Subnet association
resource "aws_route_table_association" "rt-sub" {
  subnet_id      = aws_subnet.subnet-1-public.id
  route_table_id = aws_route_table.public-rt.id
}

# Security Group 
resource "aws_security_group" "public-server-sg" {
  name   = "project-public-server-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "allow port 22 for SSh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow port 80 for HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance (ubuntu) - 1
resource "aws_instance" "server-1" {
  ami                         = "ami-0d97d7f07b25dd693"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.server-key.key_name
  subnet_id                   = aws_subnet.subnet-1-public.id
  vpc_security_group_ids      = [aws_security_group.public-server-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "public-server-1"
  }

  # --> Old User Data - Version 1 
  #   user_data = <<-EOF
  #               #!/bin/bash
  #               apt update -y
  #               apt install apache2 -y

  #               systemctl enable apache2
  #               systemctl start apache2

  #               echo "<h1>Hello from Terraform User Data!</h1>" > /var/www/html/index.html
  #               EOF

  # --> New User Data Update - Version 2
  user_data = <<-EOF
            #!/bin/bash
            apt update -y
            apt install apache2 -y

            systemctl enable apache2
            systemctl start apache2

            echo "<h1>User Data Updated Successfully!</h1>" > /var/www/html/index.html
            EOF
}

# EC2 Instance (ubuntu) - 2 ==> Using Provisioners 
resource "aws_instance" "server-2" {
  ami                         = "ami-0d97d7f07b25dd693"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.server-key.key_name
  subnet_id                   = aws_subnet.subnet-1-public.id
  vpc_security_group_ids      = [aws_security_group.public-server-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "public-server-2"
  }

  # SSh connection
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")

    host    = self.public_ip
    timeout = "3m"
  }

  # ---------------- File Provisioner --------------------

  # --> Create a <docs.txt> file locally (our pc/laptop)
  # --> Then give destination of remote server where you want to copy this file
  provisioner "file" {
    source      = "docs.txt"
    destination = "/home/ubuntu/docs.txt"
  }
}

# EC2 Instance (ubuntu) - 3 ==> Using Provisioners 
resource "aws_instance" "server-3" {
  ami                         = "ami-0d97d7f07b25dd693"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.server-key.key_name
  subnet_id                   = aws_subnet.subnet-1-public.id
  vpc_security_group_ids      = [aws_security_group.public-server-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "public-server-3"
  }

  # SSh connection
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")

    host    = self.public_ip
    timeout = "3m"
  }

  # ==>> Terraform Provisioners execute one by one in the order they are defined.

  # ---------------- Local Provisioner --------------------
  # --> Create a folder and notes.txt file on local PC

  provisioner "local-exec" {

    # --> Uses Git Bash from the system PATH to execute local commands.
    interpreter = ["bash", "-c"]

    command = "mkdir -p test-folder && cd test-folder && echo Hello > notes.txt"
  }

  # ---------------- File Provisioner --------------------
  # --> Copy the locally created file to the remote EC2 instance

  provisioner "file" {
    source      = "test-folder/notes.txt"
    destination = "/home/ubuntu/notes.txt"
  }

  # ===========================================================================================
  # Method 1: Using && — Executes the next command only if the previous command succeeds.
  #   provisioner "local-exec" {
  #     command = "mkdir test-folder && cd test-folder && echo Hello > notes.txt"
  #   }

  # -------------------------------------------------------------------------------------------
  # Method 2: Using ; — Executes the next command regardless of the previous command's success or failure.
  #   provisioner "local-exec" {
  #     command = "mkdir test-folder; cd test-folder; echo 'Hello from Terraform' > notes.txt; echo 'File created successfully!'"
  #   }

  # -------------------------------------------------------------------------------------------
  # Method 3: Using Heredoc (EOT) — Writes multiple commands on separate lines inside a single command block.
  #   provisioner "local-exec" {
  #     command = <<-EOT
  #     mkdir test-folder
  #     cd test-folder
  #     echo "Hello from Terraform" > notes.txt
  #     echo "Local provisioner executed successfully!"
  #   EOT
  #   }
  # ===========================================================================================
}

# EC2 Instance (ubuntu) - 4 ==> Using Provisioners 
resource "aws_instance" "server-4" {
  ami                         = "ami-0d97d7f07b25dd693"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.server-key.key_name
  subnet_id                   = aws_subnet.subnet-1-public.id
  vpc_security_group_ids      = [aws_security_group.public-server-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "public-server-4"
  }

  # SSh connection
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")

    host    = self.public_ip
    timeout = "3m"
  }

  # ==>> Terraform executes provisioners sequentially in the order they are defined.

  # ---------------- Local Provisioner --------------------
  # --> Creates a file (new1.txt) on the local PC.
  # --> Executes the command using Git Bash.

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "echo Hello world > new1.txt"
  }

  # -------------- Remote Execution Provisioner -------------
  # --> Creates a folder (new-folder) on the remote EC2 instance.
  # --> Executes commands on the remote server using SSH.

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ubuntu/new-folder"
    ]
  }

  # ---------------- File Provisioner --------------------
  # --> Copies the locally created file (new1.txt) to the remote EC2 instance.
  # --> Stores the copied file as notes.txt inside the new-folder directory.

  provisioner "file" {
    source = "new1.txt"
    # destination = "/home/ubuntu/new-folder/new1.txt"

    # --> Remote destination can use any filename; the source file's content is copied into it.
    destination = "/home/ubuntu/new-folder/myfile.txt"
  }

}
