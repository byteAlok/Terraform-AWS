
# ------------- Implicit Dependency (Automatic Dependency) ---------------

# -->> Terraform automatically understand this dependency so ----
# -->> first of all terrform create <AWS Key Pair> then <EC2 instance>

# ==>> 

resource "aws_key_pair" "user1" {
  key_name   = "dev-user1"
  public_key = file("C:/Users/Alok/.ssh/id_rsa.pub")
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = "server-key-pair"
  instance_type = "t2.micro"

  key_name   = aws_key_pair.user1.key_name
  monitoring = true

  subnet_id = "subnet-042fd5ee292ec98c4"
}

# ------------- Explicit Dependency (depends_on) ----------------

# ==>> Example 1: Chain Dependency

resource "aws_s3_bucket" "dev-bucket-1" {
  bucket = "my-terraform-dev-1-bucket-123456"
}

resource "aws_s3_bucket" "dev-bucket-2" {
  bucket = "my-terraform-dev-2-bucket-123456"

  depends_on = [aws_instance.server-1]
}

resource "aws_instance" "server-1" {
  ami           = "ami-04b938437b69a2c9c"
  instance_type = "t2.micro"

  depends_on = [aws_s3_bucket.dev-bucket-1]
    tags = {
    Name = "dev-server-1"
  }
}

# ==>> Example : 2 Multiple Dependencies

resource "aws_s3_bucket" "dev-bucket-3" {
  bucket = "my-terraform-dev-3-bucket-123456"
}

resource "aws_s3_bucket" "dev-bucket-4" {
  bucket = "my-terraform-dev-4-bucket-123456"
}

resource "aws_instance" "server-2" {
  ami           = "ami-04b938437b69a2c9c"
  instance_type = "t2.micro"

  depends_on = [
    aws_s3_bucket.dev-bucket-3,
    aws_s3_bucket.dev-bucket-4
  ]
  tags = {
    Name = "dev-server-2"
  }
}
