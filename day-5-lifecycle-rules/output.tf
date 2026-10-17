
# ------- output variable -->> single valued --------- 

output "ec2_id" {
  description = "Output for ec2 --> id"
  value = aws_instance.my_ec2_1.id
}

output "ec2_name" {
  description = "Output for ec2 --> name"
  value = aws_instance.my_ec2_1.tags["Name"]
}

output "ec2_az" {
  description = "Output for ec2 --> availability zone"
  value = aws_instance.my_ec2_1.availability_zone
}

output "ec2_instance_type" {
  description = "Output for ec2 --> instance type"
  value = aws_instance.my_ec2_1.instance_type
}

output "ec2_ami" {
  description = "Output for ec2 --> ami id"
  value = aws_instance.my_ec2_1.ami
}

# ------- output variable -->> All valued --------- 

output "ec2_details" {
  description = "All details of EC2 values"
  value = {
    id = aws_instance.my_ec2_1.id
    ami = aws_instance.my_ec2_1.ami
    az = aws_instance.my_ec2_1.availability_zone
    name = aws_instance.my_ec2_1.tags["Name"]
    instance_type = aws_instance.my_ec2_1.instance_type
  }
}