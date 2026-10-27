
# --->> https://registry.terraform.io/browse/modules ----

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket-wutige7d3"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["1", "2", "3"])

  name = "instance-${each.key}"

  instance_type = "t2.micro"
  #   key_name      = "user1"         # ---> Continue without key pair 
  monitoring = true
  subnet_id  = "subnet-0592c0bbd702057a7"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "server-${each.key}"
  }
}

module "ec2_instance-2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "server-key-pair"

  instance_type = "t2.micro"
  key_name      = aws_key_pair.user1.key_name
  monitoring    = true
  subnet_id     = "subnet-042fd5ee292ec98c4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_key_pair" "user1" {
  key_name   = "user1"
  public_key = file("C:/Users/Alok/.ssh/id_rsa.pub")
}
