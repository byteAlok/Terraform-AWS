
# ------------------ dev-aws-region name ------------------
module "dev-aws-region" {

  source = "../day-6-modules"

  aws-region = var.aws-region-name
}

# ----------------- compute/ here EC2 module -----------------
module "dev-ec2" {
  
  source = "../day-6-modules/compute"

  ami = var.ec2.ami-id
  instance-type = var.ec2.instance-type
  name = var.ec2.tag-name
}

# ----------------- storage/ here S3 bucket module -----------------
module "dev-s3" {
  
  source = "../day-6-modules/storage"

  s3-bucket-name = var.s3.bucket-name
  s3-region = var.s3.region
  s3-tag-name = var.s3.tag-name
}
