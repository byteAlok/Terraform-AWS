
variable "aws_region" {
    description = "aws region name where create resources..."
    default = ""
    type = string
}

# -------- create variable for s3 bucket - 1 ----- single valued variables ------

variable "s3_1_name" {
    description = "S3 bucket_1 name"
    default = ""
    type = string
}
variable "s3_1_tags" {
    description = "S3 bucket_1 tags values"
    default = ""
    type = string
}

# -------- create variable for s3 bucket - 1 -------- multi valued variables (object type) ------

variable "s3_2_details" {
    description = "this variavle have S3 bucket 2 --->> bucket_name, tags_name"
    
    type = object({
        bucket_name = string
        tags_name = string
    })

    default = {
        bucket_name = ""
        tags_name = ""
    }
}

