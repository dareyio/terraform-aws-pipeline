provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket = "cicd-darey"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}