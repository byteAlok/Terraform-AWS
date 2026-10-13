resource "aws_vpc" "dev_vpc" {
  cidr_block = var.dev_vpc_cidr
  region     = var.dev_vpc_region
  tags = {
    Name = var.dev_vpc_name
  }
}

resource "aws_subnet" "dev_subnet_1_public_az_1_bastion" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.dev_subnet_1_public_az_1_bastion.cidr
  availability_zone = var.dev_subnet_az_1
  tags = {
    Name = "${var.dev_subnet_1_public_az_1_bastion.name}-${var.dev_subnet_az_1}"
  }
}
resource "aws_subnet" "dev_subnet_2_public_az_2_bastion" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.dev_subnet_2_public_az_2_bastion.cidr
  availability_zone = var.dev_subnet_az_2
  tags = {
    Name = "${var.dev_subnet_2_public_az_2_bastion.name}-${var.dev_subnet_az_2}"
  }
}
resource "aws_subnet" "dev_subnet_3_private_az_1_frontend" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.dev_subnet_3_private_az_1_frontend.cidr
  availability_zone = var.dev_subnet_az_1
  tags = {
    Name = "${var.dev_subnet_3_private_az_1_frontend.name}-${var.dev_subnet_az_1}"
  }
}
resource "aws_subnet" "dev_subnet_4_private_az_2_frontend" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.dev_subnet_4_private_az_2_frontend.cidr
  availability_zone = var.dev_subnet_az_2
  tags = {
    Name = "${var.dev_subnet_4_private_az_2_frontend.name}-${var.dev_subnet_az_2}"
  }
}
resource "aws_subnet" "dev_subnet_5_private_az_1_backend" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.dev_subnet_5_private_az_1_backend.cidr
  availability_zone = var.dev_subnet_az_1
  tags = {
    Name = "${var.dev_subnet_5_private_az_1_backend.name}-${var.dev_subnet_az_1}"
  }
}
resource "aws_subnet" "dev_subnet_6_private_az_2_backend" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.dev_subnet_6_private_az_2_backend.cidr
  availability_zone = var.dev_subnet_az_2
  tags = {
    Name = "${var.dev_subnet_6_private_az_2_backend.name}-${var.dev_subnet_az_2}"
  }
}
resource "aws_subnet" "dev_subnet_7_private_az_1_database" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.dev_subnet_7_private_az_1_database.cidr
  availability_zone = var.dev_subnet_az_1
  tags = {
    Name = "${var.dev_subnet_7_private_az_1_database.name}-${var.dev_subnet_az_1}"
  }
}
resource "aws_subnet" "dev_subnet_8_private_az_2_database" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.dev_subnet_8_private_az_2_database.cidr
  availability_zone = var.dev_subnet_az_2
  tags = {
    Name = "${var.dev_subnet_8_private_az_2_database.name}-${var.dev_subnet_az_2}"
  }
}