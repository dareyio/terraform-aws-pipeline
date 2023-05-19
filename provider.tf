provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket = "darey-github-terraform-state"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}