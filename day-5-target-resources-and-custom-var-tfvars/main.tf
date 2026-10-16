
# ---------- Create resource for S3 bucket_1 ---------

resource "aws_s3_bucket" "my_s3_1" {
  bucket = var.s3_1_name
  tags = {
    Name = var.s3_1_tags
  }
}

# ---------- Create resource for S3 bucket_1 ---------

resource "aws_s3_bucket" "my_s3_2" {
  bucket = var.s3_2_details.bucket_name
  tags = {
    Name = var.s3_2_details.tags_name
  }
}
