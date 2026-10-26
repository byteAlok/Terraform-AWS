
# ----> Syntax => module.<module-name>.<output-name> 

# ----- Output for AWS Region name : from module inside output.tf ------

output "out-aws-region" {
  value = module.dev-aws-region.aws-region
}

# ----- Output values for EC2 : from module inside compute/output.tf ------

output "out-ec2-id" {
  description = "Output value of EC2 ID"
  value       = module.dev-ec2.ec2-id
}

output "out-ec2-ami" {
  value = module.dev-ec2.ec2-ami
}

output "out-ec2-instance" {
  value = module.dev-ec2.ec2-instance-type
}

output "out-ec2-name" {
  value = module.dev-ec2.ec2-name
}

# ===>>> All details(object) of EC2 

output "out-ec2-details" {
  value = module.dev-ec2.ec2-details
}

# ----- Output values for S3 : from module inside storage/output.tf ------

output "out-s3-id" {
  value = module.dev-s3.s3-bucket-id
}

output "out-s3-bucket-name" {
  value = module.dev-s3.s3-bucket-name
}

output "out-s3-region" {
  value = module.dev-s3.s3-bucket-region
}
output "out-s3-tag-name" {
  value = module.dev-s3.s3-bucket-tag-name
}

# ===>>> All details(object) of S3 

output "out-s3-details" {
  value = module.dev-s3.s3-details
}
