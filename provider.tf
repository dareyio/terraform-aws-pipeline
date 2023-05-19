provider "aws" {
  region = local.region
}

terraform {
  required_version = ">= 1.4.6"
  backend "s3" {
    bucket = "darey-github-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}