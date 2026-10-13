
# ------------- VPC -------------

output "dev_vpc_id" {
  description = "VPC ID of - dev_vpc"
  value       = aws_vpc.dev_vpc.id
}
output "dev_vpc_region" {
  description = "VPC Region of - dev_vpc"
  value       = aws_vpc.dev_vpc.region
}
output "dev_vpc_cidr" {
  description = "VPC CIDR block of - dev_vpc"
  value       = aws_vpc.dev_vpc.cidr_block
}
output "dev_vpc_name" {
  description = "VPC Name tag of - dev_vpc"
  value       = aws_vpc.dev_vpc.tags["Name"]
}

# --------- mixed outputs for VPC -----------------

output "dev_vpc_details" {
  description = "VPC details of - dev_vpc"
  value = {
    id         = aws_vpc.dev_vpc.id
    region     = aws_vpc.dev_vpc.region
    cidr_block = aws_vpc.dev_vpc.cidr_block
    name       = aws_vpc.dev_vpc.tags["Name"]
  }
}

# ---------------------------- Subnets ----------------------------

output "dev_subnet_1_details" {
  description = "Subnet 1 details"
  value = {
    id   = aws_subnet.dev_subnet_1_public_az_1_bastion.id
    name = aws_subnet.dev_subnet_1_public_az_1_bastion.tags["Name"]
    cidr = aws_subnet.dev_subnet_1_public_az_1_bastion.cidr_block
    az   = aws_subnet.dev_subnet_1_public_az_1_bastion.availability_zone
  }
}
output "dev_subnet_2_details" {
  description = "Subnet 2 details"
  value = {
    id   = aws_subnet.dev_subnet_2_public_az_2_bastion.id
    name = aws_subnet.dev_subnet_2_public_az_2_bastion.tags["Name"]
    cidr = aws_subnet.dev_subnet_2_public_az_2_bastion.cidr_block
    az   = aws_subnet.dev_subnet_2_public_az_2_bastion.availability_zone
  }
}
output "dev_subnet_3_details" {
  description = "Subnet 3 details"
  value = {
    id   = aws_subnet.dev_subnet_3_private_az_1_frontend.id
    name = aws_subnet.dev_subnet_3_private_az_1_frontend.tags["Name"]
    cidr = aws_subnet.dev_subnet_3_private_az_1_frontend.cidr_block
    az   = aws_subnet.dev_subnet_3_private_az_1_frontend.availability_zone
  }
}
output "dev_subnet_4_details" {
  description = "Subnet 4 details"
  value = {
    id   = aws_subnet.dev_subnet_4_private_az_2_frontend.id
    name = aws_subnet.dev_subnet_4_private_az_2_frontend.tags["Name"]
    cidr = aws_subnet.dev_subnet_4_private_az_2_frontend.cidr_block
    az   = aws_subnet.dev_subnet_4_private_az_2_frontend.availability_zone
  }
}
output "dev_subnet_5_details" {
  description = "Subnet 5 details"
  value = {
    id   = aws_subnet.dev_subnet_5_private_az_1_backend.id
    name = aws_subnet.dev_subnet_5_private_az_1_backend.tags["Name"]
    cidr = aws_subnet.dev_subnet_5_private_az_1_backend.cidr_block
    az   = aws_subnet.dev_subnet_5_private_az_1_backend.availability_zone
  }
}
output "dev_subnet_6_details" {
  description = "Subnet 6 details"
  value = {
    id   = aws_subnet.dev_subnet_6_private_az_2_backend.id
    name = aws_subnet.dev_subnet_6_private_az_2_backend.tags["Name"]
    cidr = aws_subnet.dev_subnet_6_private_az_2_backend.cidr_block
    az   = aws_subnet.dev_subnet_6_private_az_2_backend.availability_zone
  }
}
output "dev_subnet_7_details" {
  description = "Subnet 7 details"
  value = {
    id   = aws_subnet.dev_subnet_7_private_az_1_database.id
    name = aws_subnet.dev_subnet_7_private_az_1_database.tags["Name"]
    cidr = aws_subnet.dev_subnet_7_private_az_1_database.cidr_block
    az   = aws_subnet.dev_subnet_7_private_az_1_database.availability_zone
  }
}
output "dev_subnet_8_details" {
  description = "Subnet 8 details"
  value = {
    id   = aws_subnet.dev_subnet_8_private_az_2_database.id
    name = aws_subnet.dev_subnet_8_private_az_2_database.tags["Name"]
    cidr = aws_subnet.dev_subnet_8_private_az_2_database.cidr_block
    az   = aws_subnet.dev_subnet_8_private_az_2_database.availability_zone
  }
}

# ------------------- Availability Zone Outputs -------------------

output "dev_subnet_az_1" {
  description = "Availability Zone 1"
  value       = var.dev_subnet_az_1
}
output "dev_subnet_az_2" {
  description = "Availability Zone 2"
  value       = var.dev_subnet_az_2
}

# mixed output for subnet AZs

output "dev_subnet_azs" {
  description = "Availability Zones"
  value = {
    az_1 = var.dev_subnet_az_1
    az_2 = var.dev_subnet_az_2
  }
}