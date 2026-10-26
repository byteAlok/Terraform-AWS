
# -------- S3 bucket name : Variable -----------

variable "s3-bucket-name" {
description = "For s3 bucket name"
  default = ""
  type = string
}

# -------- S3 bucket region name : Variable ----------

variable "s3-region" {
  description = "For s3 bucket region name"
  default = ""
  type = string
}

# -------- S3 bucket tags name : Variable ----------

variable "s3-tag-name" {
  description = "For s3 bucket : tags name"
  default = ""
  type = string
}
