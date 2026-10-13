
# ------------------------ VPC Configuration ------------------------

dev_vpc_cidr   = "10.0.0.0/16"
dev_vpc_region = "us-west-2"
dev_vpc_name   = "dev_vpc"

# ------------------------ Subnet Configuration ------------------------

dev_subnet_az_1 = "us-west-2a"
dev_subnet_az_2 = "us-west-2b"

dev_subnet_1_public_az_1_bastion = {
  cidr = "10.0.0.0/24"
  name = "alok_subnet_1_public_az_1_bastion"
}
dev_subnet_2_public_az_2_bastion = {
  cidr = "10.0.1.0/24"
  name = "alok_subnet_2_public_az_2_bastion"
}
dev_subnet_3_private_az_1_frontend = {
  cidr = "10.0.2.0/24"
  name = "alok_subnet_3_private_az_1_frontend"
}
dev_subnet_4_private_az_2_frontend = {
  cidr = "10.0.3.0/24"
  name = "alok_subnet_4_private_az_2_frontend"
}
dev_subnet_5_private_az_1_backend = {
  cidr = "10.0.4.0/24"
  name = "alok_subnet_5_private_az_1_backend"
}
dev_subnet_6_private_az_2_backend = {
  cidr = "10.0.5.0/24"
  name = "alok_subnet_6_private_az_2_backend"
}
dev_subnet_7_private_az_1_database = {
  cidr = "10.0.6.0/24"
  name = "alok_subnet_7_private_az_1_database"
}
dev_subnet_8_private_az_2_database = {
  cidr = "10.0.7.0/24"
  name = "alok_subnet_8_private_az_2_database"
}

