
# ---------- Assigning value for : dev-aws-provider variable -----------

aws-region-name = "us-east-1"

# ---------- Assigning value for : dev - EC2 variable -----------

ec2 = {
    ami-id = "ami-04b938437b69a2c9c"
    instance-type = "t2.micro"
    tag-name = "dev-server"
}

# ---------- Assigning value for : dev - S3 variable -----------

s3 = {
    bucket-name = "dev-akjw747isi93-bucket"
    region = "us-west-2"
    tag-name = "dev-bucket"
}
