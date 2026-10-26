
# ------- EC2 - id -------

output "ec2-id" {
  description = "EC2 ID"
  value       = aws_instance.ec2-public.id
}

# ------- EC2 - AMI id -------

output "ec2-ami" {
  description = "EC2 - AMI ID"
  value       = aws_instance.ec2-public.ami
}

# ------- EC2 - Instance Type ---------

output "ec2-instance-type" {
  description = "EC2 - Instance Type"
  value       = aws_instance.ec2-public.instance_type
}

# ------- EC2 - Name --------

output "ec2-name" {
  description = "EC2 - Instance Tag name"
  value       = aws_instance.ec2-public.tags["Name"]
}

# ------ EC2 - All Details ------

output "ec2-details" {
  description = "EC2 - All details in one variable"
  value = {
    id            = aws_instance.ec2-public.id
    ami           = aws_instance.ec2-public.ami
    instance-type = aws_instance.ec2-public.instance_type
    name          = aws_instance.ec2-public.tags["Name"]
  }
}
