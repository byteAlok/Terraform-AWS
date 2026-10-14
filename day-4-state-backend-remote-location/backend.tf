terraform {
  backend "s3" {
    bucket       = "terraform-statefile-remote-bucket"
    key         = "dev/terraform.tfstate"
    region       = "us-west-2"
    encrypt      = true

    # -- S3 native state locking, not DynamoDB and its supported only in Terraform v1.5.0 and later --
    use_lockfile = true   

    # -- DynamoDB table for state locking & consistency checking, not supported (deprecated) in Terraform v1.5.0 and later --
    # dynamodb_table = "value"  
  }
}
