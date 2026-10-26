
# ------ Here i'm using default vpc, subnet, route table, IGW, etc........ 

resource "aws_instance" "ec2-public" {
  ami           = var.ami
  instance_type = var.instance-type
  tags = {
    Name = var.name
  }
}
