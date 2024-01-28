provider "aws" {
  region = default
}



terraform {
  backend "s3" {
    bucket = "busi-dev-terraform-bucket-new"
    #key    = "terraform.tfstate"
  }
}
