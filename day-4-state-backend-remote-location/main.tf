resource "aws_instance" "test-ec2" {
  ami           = "ami-004d1eaf8eaa0107d"
  instance_type = "t2.micro"
  tags = {
    Name = "testing-server"
  }
}

resource "aws_instance" "dev-ec2" {
  ami           = "ami-004d1eaf8eaa0107d"
  instance_type = "t2.micro"
  tags = {
    Name = "dev-server"
  }
}
