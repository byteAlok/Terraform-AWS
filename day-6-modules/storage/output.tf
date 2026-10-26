
# ----- S3 bucket id ------

output "s3-bucket-id" {
  description = "S3 bucket id"
  value       = aws_s3_bucket.s3.id
}

# ----- S3 bucket name ------

output "s3-bucket-name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.s3.bucket
}

# ----- S3 bucket region (provider) ------

output "s3-bucket-region" {
  description = "S3 bucket region"
  value       = aws_s3_bucket.s3.region
}

# ----- S3 bucket - tag name ------

output "s3-bucket-tag-name" {
  description = "S3 bucket tag name"
  value       = aws_s3_bucket.s3.tags["Name"]
}

# ------ S3 bucket all details --------

output "s3-details" {
  description = "S3 bucket all details in one variable"
  value = {
    id          = aws_s3_bucket.s3.id
    bucket-name = aws_s3_bucket.s3.bucket
    region      = aws_s3_bucket.s3.region
    tag-name    = aws_s3_bucket.s3.tags["Name"]
  }
}
