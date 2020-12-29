# Terraform state will be store in S3
terraform {
  backend "s3" {
      bucket = "terraform-bucket-tannm"
      key = "terraform.tfstate"
      encrypt = "true"
      region = "us-east-1"
  }
}