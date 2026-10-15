# --------- Create a custom VPC in AWS using Terraform --------------

resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "alok-vpc"
  }
}

# --------- Create a custom Subnet in AWS using Terraform --------------

resource "aws_subnet" "tf_subnet_public" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "alok-subnet-public"
  }
}

resource "aws_subnet" "tf_subnet_private" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "alok-subnet-private"
  }
}

# --------- Create a custom Internet Gateway in AWS using Terraform --------------

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "alok-igw"
  }
}

# --------- Create a custom Nat Gateway in AWS using Terraform --------------

resource "aws_eip" "tf_eip" {
  domain = "vpc"
  tags = {
    Name = "alok-eip"
  }
}

resource "aws_nat_gateway" "tf_nat" {
  subnet_id     = aws_subnet.tf_subnet_public.id
  allocation_id = aws_eip.tf_eip.id

  tags = {
    Name = "alok-nat"
  }
}

# ---------- Create a custom Route Table in AWS using Terraform --------------

resource "aws_route_table" "tf_rt_public" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
  tags = {
    Name = "alok-rt-public"
  }
}
resource "aws_route_table" "tf_rt_private" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf_nat.id
  }
  tags = {
    Name = "alok-rt-private"
  }
}

# ------------- Create resource for subnet association in route table --------------

resource "aws_route_table_association" "tf_rt_subnet_associate_public" {
  subnet_id      = aws_subnet.tf_subnet_public.id
  route_table_id = aws_route_table.tf_rt_public.id
}
resource "aws_route_table_association" "tf_rt_subnet_associate_private" {
  subnet_id      = aws_subnet.tf_subnet_private.id
  route_table_id = aws_route_table.tf_rt_private.id
}

# ------------- Create Security group --------------- Method : 1 ----------------

resource "aws_security_group" "tf_sg_ec2" {

  vpc_id      = aws_vpc.tf_vpc.id
  name        = "ec2-sg"
  description = "Common sg for both public and private subnets"
}

# ---------- Rule 1: HTTP inbound ----------
resource "aws_vpc_security_group_ingress_rule" "tf_inbound_http" {
  security_group_id = aws_security_group.tf_sg_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
# ----------- Rule 2: HTTPS inbound ---------
resource "aws_vpc_security_group_ingress_rule" "tf_inbound_https" {
  security_group_id = aws_security_group.tf_sg_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
# ----------- Rule 2: SSH inbound ---------
resource "aws_vpc_security_group_ingress_rule" "tf_inbound_ssh" {
  security_group_id = aws_security_group.tf_sg_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# --------- Rule 1: Allow all traffic - outbound ------
resource "aws_vpc_security_group_egress_rule" "tf_outbound" {
  security_group_id = aws_security_group.tf_sg_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# ------------- Create Security group --------------- Method : 2 ----------------

resource "aws_security_group" "tf_sg_alb" {

  vpc_id      = aws_vpc.tf_vpc.id
  name        = "alb-sg"
  description = "Security group for Load balancer"

  # --------- # Rule 1: Allow HTTP - inbound ----------- 
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  # --------- # Rule 2: Allow HTTPS - inbound ----------- 
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  # --------- Rule 1: Allow all traffic - outbound ------
  egress {
    from_port = 0
    protocol    = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ----------------------- Launch EC2 Instances ------------------------------------

resource "aws_instance" "tf-ec2-public" {

  ami               = "ami-0c766c2cff1b35ed2"
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.tf_subnet_public.id
  availability_zone = "us-west-2a"

  vpc_security_group_ids = [aws_security_group.tf_sg_ec2.id]

  tags = {
    Name = "ec2-public"
  }
}

resource "aws_instance" "tf-ec2-private" {

  ami               = "ami-0c766c2cff1b35ed2"
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.tf_subnet_private.id
  availability_zone = "us-west-2b"

  vpc_security_group_ids = [aws_security_group.tf_sg_ec2.id]

  tags = {
    Name = "ec2-private"
  }
}
