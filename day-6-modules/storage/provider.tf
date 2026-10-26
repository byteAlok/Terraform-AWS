
# ----- Secondary provider dedicated to your S3 region variable -----

provider "aws" {
  alias = "s3-region-name"
  region = var.s3-region
}
