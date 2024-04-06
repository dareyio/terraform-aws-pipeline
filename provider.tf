provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket = "terraform-cicd"
    key    = "global/s3/terraform.tfstate"
    region = "eu-north-1"
  }
}