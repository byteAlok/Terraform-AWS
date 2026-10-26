
resource "aws_s3_bucket" "s3" {
  bucket = var.s3-bucket-name

  # ----- This forces the bucket into var.s3-region ------
  provider = aws.s3-region-name

  tags = {
    Name = var.s3-tag-name
  }
}