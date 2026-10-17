
# --> Create a resource for VPC 
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "project-vpc"
  }
}

# --> Create a resource for subnet - 1
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "project-subnet-1"
  }
}

# --> Create a resource for subnet - 2
resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2c"
  tags = {
    Name = "project-subnet-2"
  }
}

# --> Create resource for AWS DB Subnet group 
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
}

# --> Create a resource for internet gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "project-igw"
  }
}

# --> Create a resource for route table 
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# --> Create resource for route table inside subnet association 
resource "aws_route_table_association" "rt-subnet-1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_route_table_association" "rt-subnet-2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.rt.id
}

# --> Create a resource for Security Group 
resource "aws_security_group" "sg" {
  name        = "project-sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.my_vpc.id
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --> Create a resource for RDS DB 
resource "aws_db_instance" "db-primary" {

  allocated_storage = 25
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  identifier        = "my-db-instance"

  username = "admin"
  password = "admin123"

  #   managed_master_user_password = true  #enable password management by AWS Secrets Manager

  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name

#   publicly_accessible = true

  skip_final_snapshot = true # --> if false then use -> final_snapshot_identifier 
  #   final_snapshot_identifier = "my-db-final-snapshot"

  maintenance_window      = "fri:04:00-fri:05:00"
  backup_retention_period = 7
}

# --> Create a resource for creating - DB instance Replica 
resource "aws_db_instance" "db-replica" {

  identifier          = "my-db-replica"
  replicate_source_db = aws_db_instance.db-primary.identifier
  instance_class      = "db.t3.micro"

  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.sg.id]

}
