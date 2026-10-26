
# -------- EC2 AMI ID : Variable --------

variable "ami" {
  description = "Enter value of EC2 AMI id"
  default     = ""
  type        = string
}

# -------- EC2 instance type : Variable ---------

variable "instance-type" {
  description = "Enter value of EC2 instance type"
  default     = ""
  type        = string
}

# ------- EC2 tags Name : Variable ---------

variable "name" {
  description = "Enter value of tag name of EC2"
  default     = ""
  type        = string
}
