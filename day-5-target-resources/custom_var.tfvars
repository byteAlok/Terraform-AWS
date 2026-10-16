# ----------------------------------------------------------------------------------------------
# Here i am using --> custom_var.tfvars --> instead of default terraform 
# value initialistion name of --> terraform.tfvars ==>> so its not working by default 
# unless untill while we not run this command --> terraform plan -var-file="custom_var.tfvars"
# ----------------------------------------------------------------------------------------------

# -------------- aws region variable value --------------

aws_region = "us-west-2"

# ------------- first bucket variable values ------------

s3_1_name = "s3-1-bucket0987654rtjkmnbvc"
s3_1_tags = "s3_bucket_1"

# ------------- second bucket variable values -----------

s3_2_details = {
  bucket_name = "s3-2-bucket56789yt---ghnbvftyu"
  tags_name = "s3_bucket_2"
}

