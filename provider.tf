provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket = "faith-dev-terraform-bucket"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}