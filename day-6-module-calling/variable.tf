
# ---------------- dev-provider : variable -----------------

variable "aws-region-name" {
  description = "value for aws region name"
  default     = ""
  type        = string
}

# --------------- dev-EC2 : variable -------------------
variable "ec2" {

  description = "Using object type variable for required ec2 values"

  type = object({
    ami-id        = string
    instance-type = string
    tag-name      = string
  })
  default = {
    ami-id        = ""
    instance-type = ""
    tag-name      = ""
  }
}

# --------------- dev-S3 : variable -------------------
variable "s3" {

  description = "Using object type variable for required S3 values"

  type = object({
    bucket-name = string
    region      = string
    tag-name    = string
  })
  default = {
    bucket-name = ""
    region      = ""
    tag-name    = ""
  }
}
