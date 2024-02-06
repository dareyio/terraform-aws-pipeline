provider "aws" {
  region = "us-east-2"
}



terraform {
  backend "s3" {
    bucket = "busi-dev-terraform-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
