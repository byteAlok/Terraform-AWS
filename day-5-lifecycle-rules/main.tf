# ----------------------------------------------------------------------------------------- 
# ------- lifecycle rule --> Terraform Feature not AWS ------

#   lifecycle {
#     # Ignore changes to the specified attribute (tags) during Terraform planning.
#     ignore_changes = [tags]

#     # Prevent Terraform from destroying the resource.
#     prevent_destroy = true

#     # Create the new resource before destroying the old one.
#     # This can help reduce downtime.
#     create_before_destroy = true

#     # Replace this resource when the referenced resource or its specified attributes undergo relevant changes.
#     replace_triggered_by = [aws_instance.my_ec2.id] 
#   }
# -----------------------------------------------------------------------------------------

# --------- Create a resource for EC2 - 1 ----------

resource "aws_instance" "my_ec2_1" {
  ami               = "ami-0ed59cbb87dfa8dba"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1c"
  tags = {
    Name = "dev-server-1"
  }

  lifecycle {
    ignore_changes = [tags]
    create_before_destroy = true

    # Comment this out if you want to allow my_ec2_1 to be destroyed. Will my_ec2_2 also be destroyed when my_ec2_1 is destroyed?
    # prevent_destroy = true
  }
}

# --------- Create a resource for EC2 - 2 ----------

resource "aws_instance" "my_ec2_2" {
  ami               = "ami-0ed59cbb87dfa8dba"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1d"
  tags = {
    Name = "dev-server-2"
  }

  lifecycle {
    # Replace this instance if my_ec2 is replaced.
    replace_triggered_by = [aws_instance.my_ec2_1.id]
  }
}
