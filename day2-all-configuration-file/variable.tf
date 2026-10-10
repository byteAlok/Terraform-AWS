# ------------------------ vpc variables (single valued variables) ---------------------------

variable "dev_vpc_cidr" {
  description = "CIDR block for the VPC - dev_vpc"
  default     = ""
  type        = string
}
variable "dev_vpc_region" {
  description = "Region for the VPC - dev_vpc"
  default     = ""
  type        = string
}
variable "dev_vpc_name" {
  description = "Name tag for the VPC - dev_vpc"
  default     = ""
  type        = string
}

# ------ subnet CIDR block variables using object type for multiple values written in same variable --------

variable "dev_subnet_1_public_az_1_bastion" {
  description = "CIDR block for - dev_subnet_1_public_az_1_cidr_bastion"
  type = object({
    cidr = string
    name = string
  })
  default = {
    cidr = ""
    name = ""
  }
}
variable "dev_subnet_2_public_az_2_bastion" {
  description = "CIDR block for - dev_subnet_2_public_az_2_cidr_bastion"
  type = object({
    cidr = string
    name = string
  })
  default = {
    cidr = ""
    name = ""
  }
}
variable "dev_subnet_3_private_az_1_frontend" {
  description = "CIDR block for - dev_subnet_3_private_az_1_cidr_frontend"
  type = object({
    cidr = string
    name = string
  })
  default = {
    cidr = ""
    name = ""
  }
}

# ---------- here default configuration id not necessary to fill it blank string 
# because we will pass the values from terraform.tfvars file ----------------------------

variable "dev_subnet_4_private_az_2_frontend" {
  description = "CIDR block for - dev_subnet_4_private_az_2_cidr_frontend"
  type = object({
    cidr = string
    name = string
  })
}
variable "dev_subnet_5_private_az_1_backend" {
  description = "CIDR block for - dev_subnet_5_private_az_1_cidr_backend"
  type = object({
    cidr = string
    name = string
  })
}
variable "dev_subnet_6_private_az_2_backend" {
  description = "CIDR block for - dev_subnet_6_private_az_2_cidr_backend"
  type = object({
    cidr = string
    name = string
  })
}
variable "dev_subnet_7_private_az_1_database" {
  description = "CIDR block for - dev_subnet_7_private_az_1_cidr_database"
  type = object({
    cidr = string
    name = string
  })
}
variable "dev_subnet_8_private_az_2_database" {
  description = "CIDR block for - dev_subnet_8_private_az_2_cidr_database"
  type = object({
    cidr = string
    name = string
  })
}

# ------- subnet AZ variables (here also single valued variables) -----------

variable "dev_subnet_az_1" {
  description = "Availability Zone for - dev_subnet_az_1"
  default     = ""
  type        = string
}
variable "dev_subnet_az_2" {
  description = "Availability Zone for - dev_subnet_az_2"
  default     = ""
  type        = string
}